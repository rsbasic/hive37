#!/bin/bash
# Score History - Track evolution scores over time
# Appends current score to hunger-log.md

WORKSPACE="/Users/jms/.openclaw/workspace"
LOG="$WORKSPACE/memory/hunger-log.md"

# Create log if doesn't exist
if [[ ! -f "$LOG" ]]; then
    echo "# Hunger Log" > "$LOG"
    echo "" >> "$LOG"
    echo "| Date | Time | Score | Target | Gap | State |" >> "$LOG"
    echo "|------|------|-------|--------|-----|-------|" >> "$LOG"
fi

# Get current score
RESULT=$($WORKSPACE/scripts/evolution-score.sh 2>/dev/null)
SCORE=$(echo "$RESULT" | grep "^Score:" | awk '{print $2}')
TARGET=$(echo "$RESULT" | grep "^Target:" | awk '{print $2}')
GAP=$(echo "$RESULT" | grep "^Gap:" | awk '{print $2}')
STATE=$(echo "$RESULT" | grep "^State:" | awk '{print $2}')

# Append to log
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M')
echo "| $DATE | $TIME | $SCORE | $TARGET | $GAP | $STATE |" >> "$LOG"

echo "Score logged: $SCORE ($STATE)"
echo "Log: $LOG"
