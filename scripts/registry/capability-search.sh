#!/bin/bash
# capability-search.sh — Search capabilities across agents

QUERY="$1"

echo "=== Capability Search ==="
if [ -n "$QUERY" ]; then
    echo "Query: $QUERY"
fi
echo ""

# Search local first
echo "📍 LOCAL (Abernath37):"
echo ""

if [ -f "registry/capabilities.json" ]; then
    if [ -n "$QUERY" ]; then
        # Filter by query
        cat registry/capabilities.json | \
            grep -A3 -B1 "\"name\":\|\"category\":\|\"description\":" | \
            grep -i "$QUERY" | \
            grep "\"name\":" | \
            sed 's/.*"name": "\([^"]*\)".*/  • \1/' | \
            sort | uniq
    else
        # Show all by category
        for cat in "Hunger System" "Security" "Intelligence" "Work Management" "Reporting" "System Operations" "Other"; do
            count=$(grep "\"category\": \"$cat\"" registry/capabilities.json 2>/dev/null | wc -l)
            if [ "$count" -gt 0 ]; then
                echo "  $cat: $count"
            fi
        done
        echo ""
        echo "  Total: $(grep -c '"name":' registry/capabilities.json) capabilities"
    fi
else
    echo "  ⚠️  No local registry. Run: ./scripts/capability-registry-builder.sh"
fi

echo ""

# Try to search remote agents
echo "🔍 REMOTE AGENTS:"
echo ""

# Check Abernath
if ssh -o ConnectTimeout=2 smallminis-mini.lan "echo ok" 2>/dev/null | grep -q "ok"; then
    echo "  smallminis-mini.lan (Abernath37):"
    if ssh smallminis-mini.lan "test -f ~/.openclaw/workspace/registry/capabilities.json" 2>/dev/null; then
        REMOTE_COUNT=$(ssh smallminis-mini.lan "grep -c '\"name\":' ~/.openclaw/workspace/registry/capabilities.json" 2>/dev/null)
        echo "    ✅ $REMOTE_COUNT capabilities available"
        
        if [ -n "$QUERY" ]; then
            echo "    Matching '$QUERY':"
            ssh smallminis-mini.lan "cat ~/.openclaw/workspace/registry/capabilities.json" 2>/dev/null | \
                grep -i "\"name\":.*$QUERY" | \
                sed 's/.*"name": "\([^"]*\)".*/      • \1 (pull with: capability-pull.sh smallminis-mini.lan \1)/'
        fi
    else
        echo "    ⚠️  No registry built yet"
    fi
else
    echo "  smallminis-mini.lan: ❌ Not reachable"
fi

echo ""
echo "Commands:"
echo "  Search:     ./scripts/capability-search.sh [query]"
echo "  Discover:   ./scripts/capability-discovery.sh"
echo "  Pull:       ./scripts/capability-pull.sh <agent> <name>"
echo ""
