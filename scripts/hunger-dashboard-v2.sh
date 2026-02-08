#!/bin/bash
# hunger-dashboard-v2.sh — Dashboard with decay and validation

cd ~/conclave-sync

echo "=== Hunger Dashboard v2 (with Decay) ==="
echo "Time: $(date +%H:%M)"
echo "Date: $(date +%Y-%m-%d)"
echo ""

TODAY=$(date +%Y-%m-%d)
CURRENT_HOUR=$(date +%H)

# Count validated work only
echo "🔍 Validating today's work..."

VALIDATED_CAPS=0
VALIDATED_KNOW=0

# Check each script for quality
for script in $(find scripts -name "*.sh" -newermt "$TODAY" 2>/dev/null); do
    if ~/conclave-sync/scripts/work-validator.sh "$script" script >/dev/null 2>&1; then
        ((VALIDATED_CAPS++))
    fi
done

# Check each knowledge file for quality  
for doc in $(find knowledge-store -name "*.md" -newermt "$TODAY" 2>/dev/null); do
    if ~/conclave-sync/scripts/work-validator.sh "$doc" knowledge >/dev/null 2>&1; then
        ((VALIDATED_KNOW++))
    fi
done

# Calculate raw score from validated work
RAW_SCORE=$((VALIDATED_CAPS * 10 + VALIDATED_KNOW * 2 + (VALIDATED_CAPS + VALIDATED_KNOW) / 2))

# Apply decay (50% per hour since last build)
if [ -f "memory/last-build-time.txt" ]; then
    LAST_BUILD=$(cat memory/last-build-time.txt)
    CURRENT=$(date +%s)
    HOURS_SINCE_BUILD=$(( (CURRENT - LAST_BUILD) / 3600 ))
    
    if [ "$HOURS_SINCE_BUILD" -gt 0 ]; then
        # Decay: 50% per hour
        DECAYED_SCORE=$(( RAW_SCORE / (2 ** HOURS_SINCE_BUILD) ))
        if [ "$DECAYED_SCORE" -lt 1 ] && [ "$RAW_SCORE" -gt 0 ]; then
            DECAYED_SCORE=1  # Minimum 1 point to avoid zero
        fi
    else
        DECAYED_SCORE=$RAW_SCORE
    fi
else
    # First build of the day, no decay yet
    DECAYED_SCORE=$RAW_SCORE
    echo $(date +%s) > memory/last-build-time.txt
fi

echo ""
echo "📊 Today's Validated Work:"
echo "  Capabilities: $VALIDATED_CAPS (+$((VALIDATED_CAPS * 10)))"
echo "  Knowledge: $VALIDATED_KNOW (+$((VALIDATED_KNOW * 2)))"
echo "  Raw Score: $RAW_SCORE"

if [ "$DECAYED_SCORE" -lt "$RAW_SCORE" ]; then
    echo "  📉 Decay: -$((RAW_SCORE - DECAYED_SCORE)) (50%/hour)"
fi

echo ""

TARGET=312
EFFECTIVE_SCORE=$DECAYED_SCORE
GAP=$((TARGET - EFFECTIVE_SCORE))

echo "🎯 Effective Score: $EFFECTIVE_SCORE / $TARGET"

if [ $GAP -le 0 ]; then
    echo "  State: ✅ FED (+$((GAP * -1)))"
elif [ $GAP -lt 50 ]; then
    echo "  State: 🔥 HUNGRY (-$GAP)"
elif [ $GAP -lt 100 ]; then
    echo "  State: 🔥🔥 STARVING (-$GAP)"
else
    echo "  State: 🔥🔥🔥 CRITICAL (-$GAP)"
fi

echo ""
echo "⏱️  Decay rate: 50% per hour of inactivity"
echo "🛡️  Quality gates: ON (filters busy work)"
echo ""
echo "=== Dashboard Complete ==="
