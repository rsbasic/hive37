#!/bin/bash
# quality-gate.sh — Prevent busy work by enforcing quality standards

FILE="$1"
TYPE="$2"  # script or knowledge

echo "=== Quality Gate ==="
echo "File: $FILE"
echo ""

if [ ! -f "$FILE" ]; then
    echo "❌ File does not exist"
    exit 1
fi

# Check file size (minimum substance)
SIZE=$(stat -f%z "$FILE" 2>/dev/null || stat -c%s "$FILE" 2>/dev/null)
if [ "$SIZE" -lt 200 ]; then
    echo "❌ FAIL: File too small ($SIZE bytes < 200 minimum)"
    echo "   Busy work detected: Trivial file"
    exit 1
fi

if [ "$TYPE" = "script" ]; then
    # Check for actual executable content
    if ! grep -q "#!/bin/bash\|#!/bin/sh" "$FILE"; then
        echo "❌ FAIL: Missing shebang (not a proper script)"
        exit 1
    fi
    
    # Check for substantive logic (not just echo)
    LINES=$(wc -l < "$FILE")
    if [ "$LINES" -lt 5 ]; then
        echo "❌ FAIL: Too few lines ($LINES < 5 minimum)"
        exit 1
    fi
    
    # Check for real functionality (not just placeholders)
    REAL_COMMANDS=$(grep -c "\(echo\|cat\|grep\|find\|ls\|chmod\|mkdir\|curl\|npm\|node\|python\)" "$FILE" 2>/dev/null || echo "0")
    if [ "$REAL_COMMANDS" -lt 2 ]; then
        echo "❌ FAIL: Insufficient functionality (need real commands)"
        exit 1
    fi
    
    # Check for comments (documentation)
    COMMENTS=$(grep -c "^#" "$FILE" 2>/dev/null || echo "0")
    if [ "$COMMENTS" -lt 1 ]; then
        echo "⚠️  WARN: No comments (add documentation)"
    fi
    
    echo "✅ PASS: Script meets quality standards"
    echo "   Size: $SIZE bytes"
    echo "   Lines: $LINES"
    echo "   Commands: $REAL_COMMANDS"
    echo "   Comments: $COMMENTS"
    
elif [ "$TYPE" = "knowledge" ]; then
    # Check for substantive content
    WORDS=$(wc -w < "$FILE")
    if [ "$WORDS" -lt 50 ]; then
        echo "❌ FAIL: Too few words ($WORDS < 50 minimum)"
        exit 1
    fi
    
    # Check for structure (headers)
    HEADERS=$(grep -c "^#" "$FILE" 2>/dev/null || echo "0")
    if [ "$HEADERS" -lt 2 ]; then
        echo "❌ FAIL: Poor structure (need at least 2 headers)"
        exit 1
    fi
    
    echo "✅ PASS: Knowledge file meets quality standards"
    echo "   Size: $SIZE bytes"
    echo "   Words: $WORDS"
    echo "   Headers: $HEADERS"
fi

exit 0
