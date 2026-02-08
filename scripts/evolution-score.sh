#!/bin/bash
# Evolution Score - Track workspace growth
# Score = (Scripts × 10) + (Knowledge Files × 2) + (Daily Tasks × 0.5)

WORKSPACE="${WORKSPACE:-$(pwd)}"

SCRIPTS=$(find "$WORKSPACE/scripts" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
PROCESSES=$(find "$WORKSPACE/processes" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
RESEARCH=$(find "$WORKSPACE/research" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
CONTENT=$(find "$WORKSPACE/content" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SIGNALS=$(find "$WORKSPACE/signals" -name "*.md" ! -path "*/archive/*" 2>/dev/null | wc -l | tr -d ' ')

KNOWLEDGE=$((PROCESSES + RESEARCH + CONTENT))
SCORE=$(echo "($SCRIPTS * 10) + ($KNOWLEDGE * 2) + ($SIGNALS * 0.5)" | bc 2>/dev/null || echo "N/A")

echo "Evolution Score: $SCORE"
echo "  Scripts: $SCRIPTS (×10)"
echo "  Knowledge: $KNOWLEDGE (×2)"
echo "  Active Signals: $SIGNALS (×0.5)"
echo ""
echo "  Breakdown:"
echo "    Processes: $PROCESSES"
echo "    Research: $RESEARCH"
echo "    Content: $CONTENT"
