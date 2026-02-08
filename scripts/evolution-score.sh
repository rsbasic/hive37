#!/bin/bash
# Evolution Score Calculator - DAILY DELTA ONLY
# Score = what was ADDED today, not total accumulated

WORKSPACE="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
TODAY=$(date +%Y-%m-%d)

# Count NEW capabilities created today
NEW_CAPS=$(find "$WORKSPACE/scripts" -name "*.sh" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')

# Count NEW knowledge files created today
NEW_KNOWLEDGE=$(find "$WORKSPACE/notes/knowledge" "$WORKSPACE/notes/research" -name "*.md" -newermt "$TODAY" 2>/dev/null | wc -l | tr -d ' ')

# Count tasks done today (from memory file)
TASKS=$(grep -c "^\- \[x\]\|✅\|Done\|Completed\|Built\|Created" "$WORKSPACE/memory/$TODAY.md" 2>/dev/null || echo "0")

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
