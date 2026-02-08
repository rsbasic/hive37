#!/bin/bash
# capability-pull.sh — Pull capability from another agent

AGENT="$1"
CAPABILITY="$2"

if [ -z "$AGENT" ] || [ -z "$CAPABILITY" ]; then
    echo "Usage: $0 <agent-host> <capability-name>"
    echo "Example: $0 smallminis-mini.lan arxiv-scanner"
    exit 1
fi

echo "=== Capability Pull ==="
echo "From: $AGENT"
echo "Capability: $CAPABILITY"
echo ""

# Determine remote path based on agent
if [ "$AGENT" = "smallminis-mini.lan" ]; then
    REMOTE_PATH="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
else
    REMOTE_PATH="${WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}"
fi

# Check if capability exists on remote
echo "🔍 Checking remote..."
if ! ssh -o ConnectTimeout=5 "$AGENT" "test -f $REMOTE_PATH/scripts/$CAPABILITY.sh" 2>/dev/null; then
    echo "❌ Capability not found on $AGENT"
    exit 1
fi

echo "✅ Found: scripts/$CAPABILITY.sh"

# Get metadata
DESC=$(ssh "$AGENT" "grep '^# ' $REMOTE_PATH/scripts/$CAPABILITY.sh | head -1" 2>/dev/null | sed 's/^# //')
echo "📝 Description: $DESC"

# Confirm pull
echo ""
read -p "Pull to local? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Copy file
    scp "$AGENT:$REMOTE_PATH/scripts/$CAPABILITY.sh" "scripts/$CAPABILITY.sh" 2>/dev/null
    
    if [ -f "scripts/$CAPABILITY.sh" ]; then
        chmod +x "scripts/$CAPABILITY.sh"
        echo ""
        echo "✅ Pulled: scripts/$CAPABILITY.sh"
        echo "🎯 +10 points when validated"
        
        # Validate
        echo ""
        echo "🔍 Validating..."
        if ./scripts/work-validator.sh "scripts/$CAPABILITY.sh" script 2>/dev/null; then
            echo ""
            echo "🎉 Capability ready to use!"
        else
            echo ""
            echo "⚠️  Needs adjustment to pass quality gates"
        fi
    else
        echo "❌ Pull failed"
        exit 1
    fi
else
    echo "Cancelled"
fi
