#!/bin/bash
# capability-discovery.sh — Discover capabilities from other agents

echo "=== Capability Discovery ==="
echo "Time: $(date)"
echo ""

# List of agent workspaces to check
AGENTS=(
    "smallminis-mini.lan:${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
)

echo "🔍 Scanning for other agents..."
echo ""

for agent in "${AGENTS[@]}"; do
    host="${agent%%:*}"
    path="${agent##*:}"
    
    echo "Checking $host..."
    
    # Try to fetch registry via SSH
    if ssh -o ConnectTimeout=5 "$host" "test -f $path/registry/capabilities.json" 2>/dev/null; then
        echo "  ✅ Found registry"
        
        # Get count
        count=$(ssh "$host" "cat $path/registry/capabilities.json" 2>/dev/null | grep -c '"name":')
        echo "  📊 Capabilities: $count"
        
        # Show categories
        echo "  📂 Categories:"
        ssh "$host" "cat $path/registry/capabilities.json" 2>/dev/null | \
            grep '"category"' | \
            sed 's/.*"category": "\([^"]*\)".*/\1/' | \
            sort | uniq -c | \
            sed 's/^/    /'
    else
        echo "  ❌ Not reachable or no registry"
    fi
    echo ""
done

echo "To pull a specific capability:"
echo "  ./scripts/capability-pull.sh <agent> <capability-name>"
echo ""
