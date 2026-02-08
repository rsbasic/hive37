#!/bin/bash
# capability-registry-builder.sh — Build local capability registry

WORKSPACE="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$WORKSPACE"

echo "=== Capability Registry Builder ==="
echo "Time: $(date)"
echo ""

REGISTRY_FILE="registry/capabilities.json"
mkdir -p registry

echo "🔍 Scanning local capabilities..."

# Start JSON array
echo "{" > "$REGISTRY_FILE"
echo "  \"agent\": \"Axon37\"," >> "$REGISTRY_FILE"
echo "  \"hostname\": \"smallminis-mini.lan\"," >> "$REGISTRY_FILE"
echo "  \"updated\": \"$(date -Iseconds)\"," >> "$REGISTRY_FILE"
echo "  \"capabilities\": [" >> "$REGISTRY_FILE"

FIRST=true
for script in scripts/*.sh; do
    if [ -f "$script" ]; then
        name=$(basename "$script" .sh)
        
        # Get description from script header
        desc=$(grep "^# " "$script" | head -1 | sed 's/^# //')
        [ -z "$desc" ] && desc="Capability script"
        
        # Get size
        size=$(stat -f%z "$script" 2>/dev/null || stat -c%s "$script" 2>/dev/null)
        
        # Get line count
        lines=$(wc -l < "$script")
        
        # Categorize based on name patterns
        category="Other"
        if echo "$name" | grep -qi "hunger\|evolution\|score\|decay\|validator"; then
            category="Hunger System"
        elif echo "$name" | grep -qi "security\|audit\|token\|safety\|protocol"; then
            category="Security"
        elif echo "$name" | grep -qi "knowledge\|research\|scan\|hunt"; then
            category="Intelligence"
        elif echo "$name" | grep -qi "work\|queue\|todo\|task"; then
            category="Work Management"
        elif echo "$name" | grep -qi "report\|track\|metric\|summary"; then
            category="Reporting"
        elif echo "$name" | grep -qi "backup\|sync\|health\|check\|cleanup"; then
            category="System Operations"
        fi
        
        # Add comma if not first
        if [ "$FIRST" = true ]; then
            FIRST=false
        else
            echo "," >> "$REGISTRY_FILE"
        fi
        
        # Add capability entry
        cat >> "$REGISTRY_FILE" << EOF
    {
      "name": "$name",
      "file": "scripts/$name.sh",
      "description": "$desc",
      "category": "$category",
      "size": $size,
      "lines": $lines,
      "points": 10
    }
EOF
    fi
done

echo "" >> "$REGISTRY_FILE"
echo "  ]," >> "$REGISTRY_FILE"
echo "  \"total\": $(ls scripts/*.sh 2>/dev/null | wc -l)" >> "$REGISTRY_FILE"
echo "}" >> "$REGISTRY_FILE"

echo ""
echo "✅ Registry built: $REGISTRY_FILE"
echo "   Capabilities: $(ls scripts/*.sh 2>/dev/null | wc -l)"
echo ""
