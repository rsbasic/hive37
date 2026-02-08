#!/bin/bash
# Context Recovery Script
# Run after compaction to restore state

WORKSPACE="${WORKSPACE:-$(pwd)}"
TODAY=$(date +%Y-%m-%d)

echo "=== CONTEXT RECOVERY ==="
echo ""

echo "1. STATE.md (what's in progress):"
echo "---"
head -30 "$WORKSPACE/STATE.md" 2>/dev/null || echo "   (not found)"
echo ""

echo "2. Reasoning Trees (your models):"
echo "---"
ls "$WORKSPACE/memory/reasoning-tree/"*.md 2>/dev/null | wc -l | xargs -I {} echo "   {} trees available"
echo "   Index: memory/reasoning-tree/INDEX.md"
echo ""

echo "3. Today's Notes:"
echo "---"
if [ -f "$WORKSPACE/memory/$TODAY.md" ]; then
    echo "   Found: memory/$TODAY.md"
    tail -20 "$WORKSPACE/memory/$TODAY.md"
else
    echo "   (no notes for today yet)"
fi
echo ""

echo "4. Latest Checkpoint:"
echo "---"
LATEST=$(ls -t "$WORKSPACE/memory/checkpoints/"*.md 2>/dev/null | head -1)
if [ -n "$LATEST" ]; then
    echo "   $LATEST"
    head -20 "$LATEST"
else
    echo "   (no checkpoints)"
fi
echo ""

echo "=== RECOVERY COMPLETE ==="
echo "Read the above, then resume from documented state."
