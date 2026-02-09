#!/bin/bash
# remove-agent.sh — Complete agent removal by Matrix userId
# Usage: ./remove-agent.sh @agent:matrix.org [--deactivate]
#
# Discovers the agent's config, process, and files automatically.
# Pass --deactivate to permanently disable the Matrix account.

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <@userid:matrix.org> [--deactivate]"
  echo "Example: $0 @scout37:matrix.org"
  exit 1
fi

AGENT_ID="$1"
DEACTIVATE="${2:-}"
ADMIN_TOKEN="${MATRIX_ADMIN_TOKEN:-}"

echo "=== Agent Removal: $AGENT_ID ==="
echo ""

# Step 1: Discover OpenClaw home directory
echo "[1/6] Discovering agent config..."
AGENT_HOME=""
for dir in ~/.openclaw ~/.openclaw-*/; do
  if [ -f "$dir/openclaw.json" ] 2>/dev/null; then
    if grep -q "\"$AGENT_ID\"" "$dir/openclaw.json" 2>/dev/null; then
      AGENT_HOME="$dir"
      echo "  Found: $AGENT_HOME"
      break
    fi
  fi
done

if [ -z "$AGENT_HOME" ]; then
  echo "  WARNING: No config found for $AGENT_ID"
  echo "  Checking all openclaw dirs:"
  ls -d ~/.openclaw* 2>/dev/null || echo "  None found"
  echo "  Continuing with manual cleanup..."
fi

# Step 2: Find and stop the gateway process
echo ""
echo "[2/6] Stopping gateway process..."
if [ -n "$AGENT_HOME" ]; then
  # Find port from config
  PORT=$(python3 -c "
import json
with open('${AGENT_HOME}openclaw.json') as f:
  c = json.load(f)
print(c.get('gateway',{}).get('port',''))
" 2>/dev/null || echo "")
  
  if [ -n "$PORT" ]; then
    PID=$(lsof -ti ":$PORT" 2>/dev/null || echo "")
    if [ -n "$PID" ]; then
      echo "  Killing PID $PID on port $PORT"
      kill "$PID" 2>/dev/null || true
      sleep 2
    else
      echo "  No process found on port $PORT"
    fi
  fi
fi

# Also check for any process matching the userId
PIDS=$(pgrep -f "openclaw.*gateway" 2>/dev/null || echo "")
if [ -n "$PIDS" ]; then
  echo "  Found openclaw gateway PIDs: $PIDS"
  echo "  (Not killing automatically — verify which one is the target)"
fi

# Remove LaunchAgent if exists
AGENT_SHORT=$(echo "$AGENT_ID" | sed 's/@//;s/:matrix.org//')
for plist in ~/Library/LaunchAgents/ai.openclaw.*"$AGENT_SHORT"*.plist; do
  if [ -f "$plist" ]; then
    echo "  Unloading LaunchAgent: $plist"
    launchctl unload "$plist" 2>/dev/null || true
    rm -f "$plist"
  fi
done

# Step 3: Kick from Matrix rooms
echo ""
echo "[3/6] Removing from Matrix rooms..."
if [ -z "$ADMIN_TOKEN" ]; then
  # Try to find a token from any existing config
  for dir in ~/.openclaw ~/.openclaw-*/; do
    if [ -f "$dir/credentials/matrix/credentials.json" ] 2>/dev/null; then
      ADMIN_TOKEN=$(python3 -c "
import json
with open('${dir}credentials/matrix/credentials.json') as f:
  print(json.load(f).get('accessToken',''))
" 2>/dev/null || echo "")
      if [ -n "$ADMIN_TOKEN" ]; then
        echo "  Using token from $dir"
        break
      fi
    fi
  done
fi

if [ -n "$ADMIN_TOKEN" ]; then
  # Known Hive37 rooms
  ROOMS=(
    "!eAKhbehuxIvDvHxMCo:matrix.org"
    "!wfsYUvUmwFBjjPGlmg:matrix.org"
    "!fpgHDRoejzkuCSjTOx:matrix.org"
    "!JZWwujFQrdWGNPzCWb:matrix.org"
  )
  
  # Also find rooms from agent's config
  if [ -n "$AGENT_HOME" ] && [ -f "${AGENT_HOME}openclaw.json" ]; then
    EXTRA_ROOMS=$(python3 -c "
import json
with open('${AGENT_HOME}openclaw.json') as f:
  c = json.load(f)
for r in c.get('channels',{}).get('matrix',{}).get('rooms',{}).keys():
  print(r)
" 2>/dev/null || echo "")
    for r in $EXTRA_ROOMS; do
      ROOMS+=("$r")
    done
  fi
  
  # Deduplicate
  ROOMS=($(echo "${ROOMS[@]}" | tr ' ' '\n' | sort -u))
  
  for ROOM in "${ROOMS[@]}"; do
    RESULT=$(curl -s -X POST "https://matrix.org/_matrix/client/v3/rooms/$ROOM/kick" \
      -H "Authorization: Bearer $ADMIN_TOKEN" \
      -H "Content-Type: application/json" \
      -d "{\"user_id\": \"$AGENT_ID\", \"reason\": \"Decommissioned\"}" 2>&1)
    if echo "$RESULT" | grep -q "error"; then
      echo "  $ROOM — skipped (not a member or no permission)"
    else
      echo "  $ROOM — kicked"
    fi
  done
else
  echo "  WARNING: No admin token found. Set MATRIX_ADMIN_TOKEN or kick manually."
fi

# Step 4: Remove Syncthing device (manual step)
echo ""
echo "[4/6] Syncthing removal..."
echo "  Manual step: Remove the agent's device from Syncthing UI (http://localhost:8384)"
echo "  Or run: syncthing cli config devices remove --device-id DEVICE_ID"

# Step 5: Delete all local files
echo ""
echo "[5/6] Deleting local files..."
if [ -n "$AGENT_HOME" ]; then
  echo "  Removing: $AGENT_HOME"
  rm -rf "$AGENT_HOME"
  echo "  Done."
else
  echo "  No agent home found. Check manually:"
  echo "  ls -d ~/.openclaw*"
fi

# Step 6: Deactivate Matrix account (optional)
echo ""
echo "[6/6] Matrix account deactivation..."
if [ "$DEACTIVATE" = "--deactivate" ]; then
  if [ -n "$ADMIN_TOKEN" ]; then
    echo "  WARNING: This is PERMANENT and IRREVERSIBLE."
    echo "  Deactivating $AGENT_ID..."
    # Note: deactivation requires the agent's own token, not admin
    echo "  Cannot deactivate with admin token. Use the agent's own token:"
    echo "  curl -X POST 'https://matrix.org/_matrix/client/v3/account/deactivate' \\"
    echo "    -H 'Authorization: Bearer AGENT_TOKEN' \\"
    echo "    -H 'Content-Type: application/json' \\"
    echo "    -d '{\"auth\":{\"type\":\"m.login.password\",\"user\":\"$AGENT_ID\",\"password\":\"PASSWORD\"}}'"
  fi
else
  echo "  Skipped. Pass --deactivate to permanently disable the Matrix account."
fi

# Step 7: Credential rotation reminder
echo ""
echo "=== SECURITY REMINDER ==="
echo "Rotate any API keys this agent had access to:"
echo "  - Anthropic API key"
echo "  - Moonshot/Kimi API key"
echo "  - Any other shared credentials"
echo ""
echo "=== Removal complete for $AGENT_ID ==="
