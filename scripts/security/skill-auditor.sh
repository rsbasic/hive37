#!/bin/bash
# skill-auditor.sh — Audit installed skills for security

echo "=== Skill Security Auditor ==="
echo "Time: $(date)"
echo ""

echo "🔍 Scanning skill locations:"
echo ""

# System skills
if [ -d "/opt/homebrew/lib/node_modules/openclaw/skills" ]; then
    echo "System skills: $(ls /opt/homebrew/lib/node_modules/openclaw/skills 2>/dev/null | wc -l) bundled"
    echo "  Risk: Low (from npm package)"
fi

# User skills
if [ -d ~/.openclaw/skills ]; then
    echo "User skills: $(ls ~/.openclaw/skills 2>/dev/null | wc -l) custom"
    echo "  Risk: Review each SKILL.md"
fi

# Workspace skills
if [ -d ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}/skills ]; then
    echo "Workspace skills: $(ls ${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}/skills 2>/dev/null | wc -l) local"
    echo "  Risk: Low (built by us)"
fi

echo ""
echo "⚠️  Security Checklist:"
echo "  [ ] No ClawHub random installs"
echo "  [ ] Review SKILL.md before install"
echo "  [ ] Verify skill provenance"
echo "  [ ] Test in isolated environment"
echo "  [ ] No long-lived tokens exposed"

echo ""
echo "✅ Audit complete"
