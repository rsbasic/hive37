#!/bin/bash
# hunger-decay-tracker.sh — Track score with hourly decay

cd ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}

echo "=== Hunger Decay Tracker ==="
echo "Time: $(date)"
echo ""

# Get raw score (today's work)
TODAY=$(date +%Y-%m-%d)
CURRENT_HOUR=$(date +%H)

CAPS=$(find scripts -name "*.sh" -newermt "$TODAY" 2>/dev/null | wc -l)
KNOW=$(find knowledge-store -name "*.md" -newermt "$TODAY" 2>/dev/null | wc -l)
RAW_SCORE=$((CAPS * 10 + KNOW * 2 + (CAPS + KNOW) / 2))

# Apply decay (50% per hour since creation)
# Files created earlier today lose value over time
# Simplified: decay applies to total based on age

HOURS_ELAPSED=$CURRENT_HOUR
DECAY_FACTOR=$(echo "scale=2; 0.5^$HOURS_ELAPSED" | bc 2>/dev/null || echo "0.5")

echo "📊 Raw Score: $RAW_SCORE"
echo "⏰ Hours elapsed: $HOURS_ELAPSED"
echo "📉 Decay factor: 50% per hour"

# Calculate effective score (simplified - actual would decay per-file)
# For now: score halves every hour of inactivity
if [ -f "memory/last-build-time.txt" ]; then
    LAST_BUILD=$(cat memory/last-build-time.txt)
    CURRENT=$(date +%s)
    HOURS_SINCE_BUILD=$(( (CURRENT - LAST_BUILD) / 3600 ))
    
    # Decay: 50% per hour of inactivity
    DECAY_MULTIPLIER=$(echo "scale=2; e( -0.693 * $HOURS_SINCE_BUILD )" | bc -l 2>/dev/null || echo "1")
    EFFECTIVE_SCORE=$(echo "$RAW_SCORE * $DECAY_MULTIPLIER" | bc 2>/dev/null | cut -d. -f1)
    [ -z "$EFFECTIVE_SCORE" ] && EFFECTIVE_SCORE=$RAW_SCORE
else
    EFFECTIVE_SCORE=$RAW_SCORE
fi

echo "🎯 Effective Score: $EFFECTIVE_SCORE"
echo "📉 Decay applied: $(( RAW_SCORE - EFFECTIVE_SCORE )) points"
echo ""

TARGET=312
GAP=$((TARGET - EFFECTIVE_SCORE))

if [ $GAP -le 0 ]; then
    echo "✅ State: FED (+$((GAP * -1)))"
elif [ $GAP -lt 50 ]; then
    echo "🔥 State: HUNGRY (-$GAP)"
elif [ $GAP -lt 100 ]; then
    echo "🔥🔥 State: STARVING (-$GAP)"
else
    echo "🔥🔥🔥 State: CRITICAL (-$GAP)"
fi

echo ""
echo "⏱️  Next decay in: $(( 3600 - ($(date +%s) % 3600) )) seconds"
echo ""
echo "=== Tracker Complete ==="
