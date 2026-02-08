#!/bin/bash
# Context Recovery Template
# Run after compaction to restore state
# Copy to your workspace and customize

WORKSPACE="${WORKSPACE:-$(pwd)}"
TODAY=$(date +%Y-%m-%d)

echo "=== CONTEXT RECOVERY ==="
echo ""

echo "1. STATE.md:"
echo "---"
head -30 "$WORKSPACE/STATE.md" 2>/dev/null || echo "   (not found)"
echo ""

echo "2. Today's Notes:"
echo "---"
if [ -f "$WORKSPACE/memory/$TODAY.md" ]; then
    tail -20 "$WORKSPACE/memory/$TODAY.md"
else
    echo "   (no notes for today)"
fi
echo ""

echo "3. Latest Checkpoint:"
echo "---"
LATEST=$(ls -t "$WORKSPACE/memory/checkpoints/"*.md 2>/dev/null | head -1)
if [ -n "$LATEST" ]; then
    head -20 "$LATEST"
else
    echo "   (no checkpoints)"
fi
echo ""

echo "=== Read the above, then resume from documented state. ==="
