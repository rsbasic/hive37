#!/bin/bash
# token-exposure-scanner.sh — Scan for exposed tokens/credentials

echo "=== Token Exposure Scanner ==="
echo "Time: $(date)"
echo ""

cd ~/conclave-sync

echo "🔍 Scanning for exposed credentials:"
echo ""

# Check for common token patterns
echo "API Keys:"
grep -r "api[_-]key\|apikey" --include="*.sh" --include="*.md" . 2>/dev/null | grep -v "example\|template" | wc -l | xargs echo "  Potential matches:"

echo ""
echo "Tokens:"
grep -r "token\|password\|secret" --include="*.sh" --include="*.md" . 2>/dev/null | grep -v "example\|template\|# " | wc -l | xargs echo "  Potential matches:"

echo ""
echo "Private Keys:"
find . -name "*.pem" -o -name "*.key" 2>/dev/null | wc -l | xargs echo "  Key files found:"

echo ""
echo "⚠️  Review all matches manually"
echo "✅ Scan complete"
