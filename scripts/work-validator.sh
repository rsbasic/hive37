#!/bin/bash
# work-validator.sh — Complete validation before counting work

FILE="$1"
TYPE="$2"  # script or knowledge

echo "=== Work Validator ==="
echo "File: $FILE"
echo "Type: $TYPE"
echo ""

if [ -z "$FILE" ] || [ -z "$TYPE" ]; then
    echo "Usage: $0 <file> <script|knowledge>"
    exit 1
fi

# Run all gates
echo "🔍 Running quality gate..."
if ! ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}/scripts/quality-gate.sh "$FILE" "$TYPE"; then
    echo ""
    echo "❌ REJECTED: Quality standards not met"
    exit 1
fi

echo ""
echo "🔍 Running anti-gaming checks..."
if ! ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}/scripts/anti-gaming-enforcer.sh "$FILE"; then
    echo ""
    echo "❌ REJECTED: Gaming detected"
    exit 1
fi

echo ""
echo "🔍 Verifying value..."
if ! ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}/scripts/value-verifier.sh "$FILE" "$TYPE"; then
    echo ""
    echo "❌ REJECTED: Insufficient value"
    exit 1
fi

echo ""
echo "🎉 APPROVED: Work counts toward evolution score"
echo "   Passes all quality gates"
echo "   No gaming detected"
echo "   Adds real value"
exit 0
