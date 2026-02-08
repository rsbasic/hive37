#!/bin/bash
# anti-gaming-enforcer.sh — Prevent score inflation tactics

FILE="$1"
echo "=== Anti-Gaming Enforcer ==="
echo "File: $FILE"
echo ""

if [ ! -f "$FILE" ]; then
    echo "❌ File does not exist"
    exit 1
fi

# Check 1: Not a duplicate (similar name)
BASENAME=$(basename "$FILE")
DIR=$(dirname "$FILE")
SIMILAR=$(find "$DIR" -name "*${BASENAME%.*}*" -type f 2>/dev/null | wc -l)
if [ "$SIMILAR" -gt 1 ]; then
    echo "⚠️  WARNING: Similar files exist (possible duplicate)"
    echo "   Found $SIMILAR similar files"
fi

# Check 2: Recent creation (not backdated)
CREATION_TIME=$(stat -f%c "$FILE" 2>/dev/null || stat -c%Y "$FILE" 2>/dev/null)
CURRENT_TIME=$(date +%s)
AGE_MINUTES=$(( (CURRENT_TIME - CREATION_TIME) / 60 ))

if [ "$AGE_MINUTES" -gt 120 ]; then
    echo "⚠️  WARNING: File created $AGE_MINUTES minutes ago"
    echo "   May be claiming old work as new"
fi

# Check 3: Content uniqueness (not copy-paste)
if [ -f "$FILE" ]; then
    # Check against existing files for similarity
    for existing in "$DIR"/*; do
        if [ "$existing" != "$FILE" ] && [ -f "$existing" ]; then
            SIMILARITY=$(diff -q "$FILE" "$existing" 2>/dev/null && echo "IDENTICAL" || echo "DIFFERENT")
            if [ "$SIMILARITY" = "IDENTICAL" ]; then
                echo "❌ FAIL: File is identical to $(basename "$existing")"
                exit 1
            fi
        fi
    done
fi

# Check 4: Meaningful filename (not auto-generated nonsense)
FILENAME=$(basename "$FILE" .sh)
if echo "$FILENAME" | grep -qE "^[0-9]+$|^test[0-9]*$|^temp[0-9]*$"; then
    echo "❌ FAIL: Meaningless filename (gaming detected)"
    exit 1
fi

# Check 5: Has been tested (scripts should be executable)
if [[ "$FILE" == *.sh ]]; then
    if [ ! -x "$FILE" ]; then
        echo "⚠️  WARNING: Script not executable (chmod +x needed)"
    fi
fi

echo "✅ Anti-gaming checks passed"
exit 0
