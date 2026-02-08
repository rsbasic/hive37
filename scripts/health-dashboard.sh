#!/bin/bash
# Health Dashboard - System status at a glance
# Run: ./scripts/health-dashboard.sh [--json]
# Expects WORKSPACE env var or defaults to current directory

set -e

WORKSPACE="${WORKSPACE:-$(pwd)}"
cd "$WORKSPACE"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

JSON_MODE=false
[[ "$1" == "--json" ]] && JSON_MODE=true

status_icon() {
    case $1 in
        healthy) echo -e "${GREEN}●${NC}" ;;
        degraded) echo -e "${YELLOW}●${NC}" ;;
        critical) echo -e "${RED}●${NC}" ;;
    esac
}

NOW=$(date +%s)
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)

# Context Health
CONTEXT_FILE="memory/context-health.json"
if [[ -f "$CONTEXT_FILE" ]]; then
    CONTEXT_PCT=$(grep -o '"contextAtLastCheck"[^,]*' "$CONTEXT_FILE" | cut -d':' -f2 | tr -d ' ')
    CHECKPOINTS_TODAY=$(grep -o '"checkpointsToday"[^,]*' "$CONTEXT_FILE" | cut -d':' -f2 | tr -d ' ')
    [[ $CONTEXT_PCT -lt 60 ]] && CONTEXT_STATUS="healthy" || { [[ $CONTEXT_PCT -lt 80 ]] && CONTEXT_STATUS="degraded" || CONTEXT_STATUS="critical"; }
else
    CONTEXT_STATUS="critical"; CONTEXT_PCT="?"; CHECKPOINTS_TODAY="0"
fi

# Memory Files
MEMORY_TODAY="memory/${TODAY}.md"
MEMORY_YESTERDAY="memory/${YESTERDAY}.md"
[[ -f "$MEMORY_TODAY" && -f "$MEMORY_YESTERDAY" ]] && MEMORY_STATUS="healthy" || { [[ -f "$MEMORY_TODAY" ]] && MEMORY_STATUS="degraded" || MEMORY_STATUS="critical"; }

# State Files
STATE_STATUS="healthy"
if [[ -f "STATE.md" ]]; then
    STATE_AGE=$(( (NOW - $(stat -f %m STATE.md 2>/dev/null || stat -c %Y STATE.md)) / 3600 ))
    [[ $STATE_AGE -gt 24 ]] && STATE_STATUS="degraded"
else
    STATE_STATUS="degraded"; STATE_AGE="N/A"
fi

# Git Status
GIT_DIRTY=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
[[ $GIT_DIRTY -eq 0 ]] && GIT_STATUS="healthy" || GIT_STATUS="degraded"

# Signals
SIGNAL_COUNT=$(find signals/ -name "*.md" ! -path "*/archive/*" 2>/dev/null | wc -l | tr -d ' ')

if $JSON_MODE; then
    cat <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "context": { "status": "$CONTEXT_STATUS", "percentage": $CONTEXT_PCT, "checkpointsToday": $CHECKPOINTS_TODAY },
  "memory": { "status": "$MEMORY_STATUS", "todayExists": $([ -f "$MEMORY_TODAY" ] && echo true || echo false) },
  "state": { "status": "$STATE_STATUS", "ageHours": ${STATE_AGE:-0} },
  "git": { "status": "$GIT_STATUS", "uncommitted": $GIT_DIRTY },
  "signals": { "unprocessed": $SIGNAL_COUNT }
}
EOF
else
    echo ""
    echo -e "${BOLD}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}  Health Dashboard — $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo -e "${BOLD}═══════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  $(status_icon $CONTEXT_STATUS) Context: ${CONTEXT_PCT}% | Checkpoints: ${CHECKPOINTS_TODAY}"
    echo -e "  $(status_icon $MEMORY_STATUS) Memory: today $([ -f "$MEMORY_TODAY" ] && echo "✓" || echo "✗"), yesterday $([ -f "$MEMORY_YESTERDAY" ] && echo "✓" || echo "✗")"
    echo -e "  $(status_icon $STATE_STATUS) State: ${STATE_AGE}h old"
    echo -e "  $(status_icon $GIT_STATUS) Git: ${GIT_DIRTY} uncommitted"
    echo -e "  Signals: ${SIGNAL_COUNT} unprocessed"
    echo ""
fi
