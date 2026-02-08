#!/bin/bash
# clawhub-safety-checker.sh — Check ClawHub skills before install

echo "=== ClawHub Safety Checker ==="
echo "Time: $(date)"
echo ""

echo "⚠️  WARNING: ClawHub skills can contain malware"
echo ""

echo "🔍 Pre-Install Checks:"
echo "  [ ] Review download count (popularity != safety)"
echo "  [ ] Check author reputation"
echo "  [ ] Read SKILL.md thoroughly"
echo "  [ ] Look for suspicious commands (curl, wget, bash)"
echo "  [ ] Verify no token/API key requests"

echo ""
echo "🛡️ Install Safely:"
echo "  1. Download to temp directory"
echo "  2. Review all files before install"
echo "  3. Check for hidden scripts"
echo "  4. Test in isolated environment"
echo "  5. Monitor network activity"

echo ""
echo "❌ Red Flags:"
echo "  • Asks for admin/sudo"
echo "  • Downloads from untrusted sources"
echo "  • Requests credentials"
echo "  • Obfuscated code"
echo ""
echo "✅ Safety checker ready"
