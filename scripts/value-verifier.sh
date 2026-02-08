#!/bin/bash
# value-verifier.sh — Verify work adds real value

FILE="$1"
TYPE="$2"

echo "=== Value Verifier ==="
echo "File: $FILE"
echo ""

# Value criteria
VALUE_SCORE=0

if [ "$TYPE" = "script" ]; then
    # Can it be executed? (+1 value)
    if [ -x "$FILE" ]; then
        ((VALUE_SCORE++))
        echo "✅ Executable"
    fi
    
    # Does it have inputs/outputs? (+1 value)
    if grep -qE '\$[0-9]|\$@|\$\*|read |echo |cat |>' "$FILE"; then
        ((VALUE_SCORE++))
        echo "✅ Has I/O"
    fi
    
    # Does it solve a real problem? (+2 value)
    if grep -qE 'audit|check|scan|process|update|sync|backup|security|monitor' "$FILE"; then
        ((VALUE_SCORE+=2))
        echo "✅ Solves real problem"
    fi
    
    # Is it reusable? (+1 value)
    LINES=$(wc -l < "$FILE")
    if [ "$LINES" -gt 10 ]; then
        ((VALUE_SCORE++))
        echo "✅ Substantial/reusable"
    fi
    
    # Does it integrate with existing system? (+1 value)
    if grep -qE 'conclave-sync|~/|scripts|knowledge' "$FILE"; then
        ((VALUE_SCORE++))
        echo "✅ System integration"
    fi
    
elif [ "$TYPE" = "knowledge" ]; then
    # Has structure? (+1 value)
    if grep -qE "^# |^## " "$FILE"; then
        ((VALUE_SCORE++))
        echo "✅ Structured"
    fi
    
    # Has actionable insights? (+2 value)
    if grep -qE "Action:|Next:|TODO:|Recommendation|Pattern" "$FILE"; then
        ((VALUE_SCORE+=2))
        echo "✅ Actionable insights"
    fi
    
    # Has external references? (+1 value)
    if grep -qE "http|github|arxiv|@" "$FILE"; then
        ((VALUE_SCORE++))
        echo "✅ Referenced sources"
    fi
    
    # Is it discoverable/searchable? (+1 value)
    WORDS=$(wc -w < "$FILE")
    if [ "$WORDS" -gt 100 ]; then
        ((VALUE_SCORE++))
        echo "✅ Substantial content"
    fi
fi

echo ""
echo "📊 Value Score: $VALUE_SCORE / 6"

if [ "$VALUE_SCORE" -ge 4 ]; then
    echo "✅ HIGH VALUE — Counts toward evolution"
    exit 0
elif [ "$VALUE_SCORE" -ge 2 ]; then
    echo "⚠️  MEDIUM VALUE — Acceptable"
    exit 0
else
    echo "❌ LOW VALUE — Busy work detected"
    exit 1
fi
