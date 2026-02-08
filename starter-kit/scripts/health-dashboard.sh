#!/bin/bash
# Health Dashboard Template
# Copy to your workspace and customize
# Run: ./scripts/health-dashboard.sh [--json]

set -e

WORKSPACE="${WORKSPACE:-$(pwd)}"
cd "$WORKSPACE"

TODAY=$(date +%Y-%m-%d)

echo "═══════════════════════════════════════"
echo "  Health Dashboard — $(date '+%Y-%m-%d %H:%M')"
echo "═══════════════════════════════════════"
echo ""

# Memory
echo "Memory:"
[ -f "memory/${TODAY}.md" ] && echo "  ✓ Today's notes exist" || echo "  ✗ No notes for today"
[ -f "STATE.md" ] && echo "  ✓ STATE.md exists" || echo "  ✗ No STATE.md"
echo ""

# Git
GIT_DIRTY=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
echo "Git: ${GIT_DIRTY} uncommitted files"
echo ""

# Customize: add your own checks below
# Example: check for pending tasks, signal queue, etc.
