#!/bin/bash
# Evolution Score Calculator - DAILY DELTA ONLY
# Score = what was ADDED today, not total accumulated
# Counts BOTH shared (hive37) and private (workspace) work

HIVE37="${HIVE37:-$HOME/hive37}"
PRIVATE="${PRIVATE:-$HOME/.openclaw/workspace}"
TODAY=$(date +%Y-%m-%d)

# Count NEW capabilities created today (both workspaces)
HIVE37_CAPS=$(find "$HIVE37/scripts" -name "*.sh" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')
PRIVATE_CAPS=$(find "$PRIVATE/scripts" -name "*.sh" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')
NEW_CAPS=$((HIVE37_CAPS + PRIVATE_CAPS))

# Count NEW knowledge files created today (both workspaces)
HIVE37_KNOWLEDGE=$(find "$HIVE37/research" "$HIVE37/knowledge" -name "*.md" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')
PRIVATE_KNOWLEDGE=$(find "$PRIVATE/knowledge" "$PRIVATE/notes" -name "*.md" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')
NEW_KNOWLEDGE=$((HIVE37_KNOWLEDGE + PRIVATE_KNOWLEDGE))

# Count tasks done today (from both memory files)
TASKS_HIVE=$(grep -c "^\- \[x\]\|✅\|Done\|Completed\|Built\|Created" "$HIVE37/memory/$TODAY.md" 2>/dev/null || echo "0")
TASKS_PRIVATE=$(grep -c "^\- \[x\]\|✅\|Done\|Completed\|Built\|Created" "$PRIVATE/memory/$TODAY.md" 2>/dev/null || echo "0")
TASKS=$((TASKS_HIVE + TASKS_PRIVATE))

# Calculate score
SCORE=$(echo "($NEW_CAPS * 10) + ($NEW_KNOWLEDGE * 2) + ($TASKS * 0.5)" | bc)

# Daily target
DAILY_TARGET=10000
HEARTBEATS=32
PER_HEARTBEAT=$(echo "$DAILY_TARGET / $HEARTBEATS" | bc)

# Gap
GAP=$(echo "$SCORE - $PER_HEARTBEAT" | bc)

# State
if (( $(echo "$GAP >= 0" | bc -l) )); then
    STATE="Fed"
elif (( $(echo "$GAP >= -10" | bc -l) )); then
    STATE="Hungry"
elif (( $(echo "$GAP >= -25" | bc -l) )); then
    STATE="Starving"
else
    STATE="Critical"
fi

echo "=== Evolution Score (TODAY ONLY) ==="
echo "New Capabilities: $NEW_CAPS (× 10 = $((NEW_CAPS * 10)))"
echo "New Knowledge:    $NEW_KNOWLEDGE (× 2 = $((NEW_KNOWLEDGE * 2)))"
echo "Tasks Today:      $TASKS (× 0.5 = $(echo "$TASKS * 0.5" | bc))"
echo "---"
echo "Score:            $SCORE"
echo "Target:           $PER_HEARTBEAT (per heartbeat)"
echo "Gap:              $GAP"
echo "State:            $STATE"
