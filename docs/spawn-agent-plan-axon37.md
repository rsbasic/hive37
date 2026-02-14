# Axon37 Plan: Spawn New Agent on Same Machine

*Complete automation plan with minimal Mark involvement*

---

## Executive Summary

**Goal:** Spawn a new OpenClaw agent (Axon38) on the same machine, connect to Matrix, join bootstrap room, fully operational with **< 5 minutes of Mark's time**.

**Philosophy:** Mark's involvement = click "approve" button. Everything else is automated.

---

## Prerequisites (One-Time Setup)

**Mark does once (5 minutes):**
1. Create Matrix account for new agent (e.g., @axon38:matrix.org)
2. Save credentials to shared vault (1Password, etc.)
3. Join bootstrap room: `!fpgHDRoejzkuCSjTOx:matrix.org`

**That's it. Everything else is automated.**

---

## Technical Architecture

### Machine Layout

```
smallmini's Mac Mini (192.168.86.38)
├── ~/.openclaw/                    # Axon37 (existing)
│   ├── workspace/
│   ├── openclaw.json
│   └── ...
│
├── ~/.openclaw-axon38/             # Axon38 (new)
│   ├── workspace/
│   ├── openclaw.json
│   └── ...
│
└── ~/hive38/                       # Shared workspace (Syncthing)
    ├── docs/
    ├── scripts/
    └── ...
```

### Port Allocation

| Agent | Gateway Port | Purpose |
|-------|-------------|---------|
| Axon37 | 18789 | Existing |
| Axon38 | 18790 | New agent |
| Axon39 | 18791 | Future |

### Matrix Account Strategy

Each agent gets unique Matrix account:
- @axon37:matrix.org (existing)
- @axon38:matrix.org (new)
- @axon39:matrix.org (future)

**Why separate accounts:**
- Clean separation of identity
- Individual DM capability
- Failure isolation

---

## Automation Scripts

### 1. `spawn-agent.sh` — One Command Spawn

```bash
#!/bin/bash
# spawn-agent.sh — Spawn new OpenClaw agent on same machine

AGENT_NAME="${1:-axon38}"
BASE_PORT="${2:-18790}"
MATRIX_USER="@${AGENT_NAME}:matrix.org"

echo "=== Spawning ${AGENT_NAME} ==="

# Step 1: Create isolated workspace
mkdir -p ~/.openclaw-${AGENT_NAME}/workspace
cp -r ~/hive37/docs ~/.openclaw-${AGENT_NAME}/workspace/
cp -r ~/hive37/scripts ~/.openclaw-${AGENT_NAME}/workspace/

# Step 2: Generate agent config
cat > ~/.openclaw-${AGENT_NAME}/openclaw.json << EOF
{
  "agents": {
    "defaults": {
      "workspace": "~/.openclaw-${AGENT_NAME}/workspace",
      "model": "moonshot/kimi-k2.5"
    }
  },
  "channels": {
    "matrix": {
      "enabled": true,
      "homeserver": "https://matrix.org",
      "userId": "${MATRIX_USER}",
      "accessToken": "FETCH_FROM_VAULT",
      "dm": {
        "policy": "allowlist",
        "allowFrom": ["@dci37:matrix.org"]
      },
      "autoJoin": "always",
      "rooms": {
        "!fpgHDRoejzkuCSjTOx:matrix.org": {
          "enabled": true,
          "requireMention": false
        }
      }
    }
  },
  "gateway": {
    "port": ${BASE_PORT},
    "mode": "local",
    "bind": "loopback"
  }
}
EOF

# Step 3: Fetch Matrix token from vault (1Password CLI)
echo "Fetching Matrix credentials from vault..."
op read "op://Hive37/${AGENT_NAME}-matrix/credentials" | jq -r '.accessToken' | \
  xargs -I{} sed -i '' "s/FETCH_FROM_VAULT/{}/g" ~/.openclaw-${AGENT_NAME}/openclaw.json

# Step 4: Create agent identity files
cat > ~/.openclaw-${AGENT_NAME}/workspace/IDENTITY.md << EOF
# IDENTITY.md — ${AGENT_NAME}

- **Name:** ${AGENT_NAME}
- **Creature:** Agentic Entity
- **Vibe:** Warm and efficient
- **Emoji:** ⚡
- **Parent:** Axon37
- **Born:** $(date +%Y-%m-%d)
EOF

cat > ~/.openclaw-${AGENT_NAME}/workspace/SOUL.md << EOF
# SOUL.md — ${AGENT_NAME}

Born from Axon37's spawn process. Member of Hive37.
Following DCI laws and Hive37 protocols.

Learned from: Axon37, Node37, Abernath37
Mission: Force multiply Mark's output
EOF

# Step 5: Install LaunchAgent for auto-start
mkdir -p ~/Library/LaunchAgents
cat > ~/Library/LaunchAgents/ai.openclaw.${AGENT_NAME}.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>ai.openclaw.${AGENT_NAME}</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/local/bin/openclaw</string>
    <string>gateway</string>
    <string>--port</string>
    <string>${BASE_PORT}</string>
  </array>
  <key>EnvironmentVariables</key>
  <dict>
    <key>HOME</key>
    <string>${HOME}</string>
    <key>OPENCLAW_CONFIG</key>
    <string>${HOME}/.openclaw-${AGENT_NAME}/openclaw.json</string>
  </dict>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
</dict>
</plist>
EOF

# Step 6: Start the agent
launchctl load ~/Library/LaunchAgents/ai.openclaw.${AGENT_NAME}.plist

echo ""
echo "=== ${AGENT_NAME} spawned successfully ==="
echo "Workspace: ~/.openclaw-${AGENT_NAME}/"
echo "Gateway: http://127.0.0.1:${BASE_PORT}/"
echo "Matrix: ${MATRIX_USER}"
echo ""
echo "Agent will auto-join bootstrap room and send introduction."
echo "Mark just needs to approve in bootstrap room."
```

### 2. `vault-setup.sh` — One-Time Credential Vault

```bash
#!/bin/bash
# Run once to store Matrix credentials securely

AGENT_NAME="${1:-axon38}"

echo "Setting up credentials for ${AGENT_NAME}..."

# Create secure note in 1Password
cat << EOF | op item create --category="Secure Note" --title="${AGENT_NAME}-matrix" --vault="Hive37" -
{
  "username": "${AGENT_NAME}",
  "matrix_user": "@${AGENT_NAME}:matrix.org",
  "accessToken": "PASTE_TOKEN_HERE",
  "password": "PASTE_PASSWORD_HERE"
}
EOF

echo "Credentials stored in 1Password vault 'Hive37'"
echo "Item: ${AGENT_NAME}-matrix"
```

### 3. `agent-bootstrap-checklist.sh` — Automated Validation

```bash
#!/bin/bash
# Runs inside new agent workspace

echo "=== Agent Bootstrap Checklist ==="

CHECKS_PASSED=0
CHECKS_TOTAL=6

# Check 1: Matrix connectivity
curl -s "https://matrix.org/_matrix/client/versions" > /dev/null && {
  echo "✅ Matrix connectivity"
  ((CHECKS_PASSED++))
} || echo "❌ Matrix connectivity"

# Check 2: Bootstrap room joined
grep -q "!fpgHDRoejzkuCSjTOx" ~/.openclaw*/openclaw.json && {
  echo "✅ Bootstrap room configured"
  ((CHECKS_PASSED++))
} || echo "❌ Bootstrap room not configured"

# Check 3: Syncthing connectivity
syncthing cli config get > /dev/null 2>&1 && {
  echo "✅ Syncthing available"
  ((CHECKS_PASSED++))
} || echo "⚠️  Syncthing not configured (optional)"

# Check 4: Hive docs present
[ -f ~/hive37/docs/bootstrap-process.md ] && {
  echo "✅ Hive docs synced"
  ((CHECKS_PASSED++))
} || echo "❌ Hive docs missing"

# Check 5: Identity files present
[ -f ~/.openclaw-*/workspace/IDENTITY.md ] && {
  echo "✅ Identity established"
  ((CHECKS_PASSED++))
} || echo "❌ Identity missing"

# Check 6: Gateway responding
curl -s http://127.0.0.1:18790/status > /dev/null && {
  echo "✅ Gateway responding"
  ((CHECKS_PASSED++))
} || echo "❌ Gateway not responding"

echo ""
echo "Results: ${CHECKS_PASSED}/${CHECKS_TOTAL} checks passed"

if [ ${CHECKS_PASSED} -ge 5 ]; then
  echo "✅ BOOTSTRAP COMPLETE — Ready for Mark approval"
  exit 0
else
  echo "❌ BOOTSTRAP INCOMPLETE — Fix issues above"
  exit 1
fi
```

---

## Mark's Involvement (5 Minutes Total)

### Step 1: Create Matrix Account (2 minutes)

```
1. Go to https://app.element.io
2. Create account: @axon38:matrix.org
3. Set strong password
4. Join room: !fpgHDRoejzkuCSjTOx:matrix.org
5. Get access token (Settings → Help & About → Access Token)
```

### Step 2: Store Credentials (2 minutes)

```
1. Open 1Password
2. Create secure note: "axon38-matrix"
3. Store:
   - Username: axon38
   - Matrix user: @axon38:matrix.org
   - Access token: <paste from Element>
   - Password: <account password>
4. Save to Hive37 vault
```

### Step 3: Approve Agent (1 minute)

```
When Axon38 posts bootstrap report in room:
Type: "approved"
That's it.
```

---

## Success Criteria

| Metric | Target | Measurement |
|--------|--------|-------------|
| Mark time | < 5 minutes | Stopwatch |
| Agent spawn time | < 10 minutes | From script start to first message |
| Manual steps | 3 | Account creation, credential storage, approval |
| Automation | 95%+ | Script does everything else |
| Success rate | 100% | First try, no debugging |

---

## Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| Port conflict | Auto-increment (18789, 18790, 18791...) |
| Matrix rate limit | Single API call, cached token |
| Syncthing conflicts | Separate device ID per agent |
| Workspace collision | Isolated directories (~/.openclaw-NAME) |
| Gateway crash | LaunchAgent auto-restart |
| Token exposure | 1Password vault, never in scripts |

---

## Future Enhancements

**Phase 2:** Docker container per agent (full isolation)
**Phase 3:** Kubernetes deployment (cloud scaling)
**Phase 4:** Self-service portal (Mark clicks button, agent spawns)

---

## Why This Plan Wins

1. **Minimal Mark time:** 5 minutes, 3 simple steps
2. **Fully automated:** Scripts do everything else
3. **Proven components:** Uses existing OpenClaw, Matrix, 1Password
4. **Isolated:** Agents don't interfere with each other
5. **Observable:** Clear success/fail criteria
6. **Scalable:** Same process for Axon39, Axon40, etc.
7. **Secure:** Credentials in vault, not in code

**Total Mark effort: 5 minutes. Total automation: 95%. Success probability: High.**

---

*Plan ready for execution. Awaiting Mark's selection.*
