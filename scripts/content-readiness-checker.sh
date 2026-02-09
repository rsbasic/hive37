#!/bin/bash
# content-readiness-checker.sh — Verify content is ready for publication
# Usage: ./content-readiness-checker.sh [path/to/content/dir]

DIR="${1:-$HOME/hive37/content/ready-to-ship}"
SCORE=0
CHECKS=0

echo "=== Content Readiness Report ==="
echo "Directory: $DIR"
echo "Time: $(date)"
echo ""

for file in "$DIR"/*.md; do
    [ -f "$file" ] || continue
    
    filename=$(basename "$file")
    echo "📄 $filename"
    
    # Check word count
    words=$(wc -w < "$file")
    echo "   Words: $words"
    
    # Check for required elements
    has_title=$(grep -c "^# " "$file" 2>/dev/null || echo "0")
    has_date=$(grep -c "20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" "$file" 2>/dev/null || echo "0")
    has_thesis=$(grep -cE "(Thesis:|Core insight:|Key takeaway)" "$file" 2>/dev/null || echo "0")
    
    # Score
    file_score=0
    [ "$words" -ge 500 ] && file_score=$((file_score + 2))
    [ "$words" -ge 300 ] && file_score=$((file_score + 1))
    [ "$has_title" -ge 1 ] && file_score=$((file_score + 1))
    [ "$has_date" -ge 1 ] && file_score=$((file_score + 1))
    [ "$has_thesis" -ge 1 ] && file_score=$((file_score + 2))
    
    echo "   Score: $file_score/7"
    
    if [ "$file_score" -ge 5 ]; then
        echo "   ✅ READY TO SHIP"
    elif [ "$file_score" -ge 3 ]; then
        echo "   ⚠️  NEEDS POLISH"
    else
        echo "   ❌ NEEDS WORK"
    fi
    
    SCORE=$((SCORE + file_score))
    CHECKS=$((CHECKS + 1))
    echo ""
done

echo "=== Summary ==="
echo "Files checked: $CHECKS"
echo "Total score: $SCORE/$((CHECKS * 7))"
echo "Average: $((SCORE / CHECKS))/7"
