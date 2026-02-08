#!/bin/bash
# score-tracker.sh - Track evolution scores over time with trend analysis
# Logs scores to memory/score-history.md and shows trends
# Usage: ./scripts/score-tracker.sh [log|trend|today|week]

set -e
cd "$(dirname "$0")/.."

HISTORY_FILE="memory/score-history.md"
TODAY=$(date +%Y-%m-%d)
NOW=$(date +%H:%M)
TIMESTAMP=$(date +%s)

# Initialize history file if needed
init_history() {
    if [[ ! -f "$HISTORY_FILE" ]]; then
        cat > "$HISTORY_FILE" << 'EOF'
# Evolution Score History

*Tracking evolution scores over time for trend analysis*

| Date | Time | Caps | Knowledge | Tasks | Score | Target | Gap | State |
|------|------|------|-----------|-------|-------|--------|-----|-------|
EOF
    fi
}

# Get current score components
get_score() {
    local caps=$(find scripts -name "*.sh" -mtime -1 2>/dev/null | wc -l | tr -d ' ')
    local knowledge=$(find notes/research notes/knowledge memory -name "*.md" -mtime -1 2>/dev/null | wc -l | tr -d ' ')
    local tasks=$(grep -c "^\- \[x\]" notes/work-queue.md 2>/dev/null | head -1 || echo 0)
    
    local score=$((caps * 10 + knowledge * 2 + tasks / 2))
    local target=312  # per heartbeat standard
    local gap=$((score - target))
    
    local state="Fed"
    if [[ $gap -lt -200 ]]; then
        state="Critical"
    elif [[ $gap -lt -100 ]]; then
        state="Starving"
    elif [[ $gap -lt 0 ]]; then
        state="Hungry"
    fi
    
    echo "$caps|$knowledge|$tasks|$score|$target|$gap|$state"
}

# Log current score to history
log_score() {
    init_history
    local data=$(get_score)
    IFS='|' read -r caps knowledge tasks score target gap state <<< "$data"
    
    # Add row to history
    echo "| $TODAY | $NOW | $caps | $knowledge | $tasks | $score | $target | $gap | $state |" >> "$HISTORY_FILE"
    
    echo "📊 Score logged: $score (gap: $gap, state: $state)"
}

# Show today's scores
show_today() {
    init_history
    echo "=== Today's Scores ($TODAY) ==="
    grep "| $TODAY |" "$HISTORY_FILE" 2>/dev/null || echo "No scores logged today"
    echo ""
    
    # Calculate trend
    local scores=$(grep "| $TODAY |" "$HISTORY_FILE" 2>/dev/null | awk -F'|' '{print $7}' | tr -d ' ')
    if [[ -n "$scores" ]]; then
        local first=$(echo "$scores" | head -1)
        local last=$(echo "$scores" | tail -1)
        local delta=$((last - first))
        
        if [[ $delta -gt 0 ]]; then
            echo "📈 Today's trend: +$delta (improving)"
        elif [[ $delta -lt 0 ]]; then
            echo "📉 Today's trend: $delta (declining)"
        else
            echo "➡️ Today's trend: flat"
        fi
    fi
}

# Show week's trend
show_week() {
    init_history
    echo "=== Weekly Score Trend ==="
    
    local week_ago=$(date -v-7d +%Y-%m-%d 2>/dev/null || date -d '7 days ago' +%Y-%m-%d 2>/dev/null)
    
    # Get scores from last 7 days
    for i in {6..0}; do
        local day=$(date -v-${i}d +%Y-%m-%d 2>/dev/null || date -d "$i days ago" +%Y-%m-%d 2>/dev/null)
        local avg=$(grep "| $day |" "$HISTORY_FILE" 2>/dev/null | awk -F'|' '{sum+=$7; count++} END {if(count>0) print int(sum/count); else print "N/A"}')
        local count=$(grep -c "| $day |" "$HISTORY_FILE" 2>/dev/null || echo 0)
        
        if [[ "$avg" != "N/A" && "$count" -gt 0 ]]; then
            # Create visual bar
            local bar=""
            local bar_len=$((avg / 20))
            for ((j=0; j<bar_len && j<20; j++)); do bar+="█"; done
            
            echo "$day: avg=$avg ($count samples) $bar"
        else
            echo "$day: no data"
        fi
    done
}

# Show trends and recommendations
show_trend() {
    init_history
    echo "=== Evolution Score Trends ==="
    echo ""
    
    local data=$(get_score)
    IFS='|' read -r caps knowledge tasks score target gap state <<< "$data"
    
    echo "Current: score=$score, gap=$gap, state=$state"
    echo "Components: caps=$caps (×10), knowledge=$knowledge (×2), tasks=$tasks (×0.5)"
    echo ""
    
    # Recommendations based on state
    case $state in
        Critical)
            echo "🔴 CRITICAL - Aggressive work needed"
            echo "   Priority: Build capabilities (+10 each)"
            echo "   Quick wins: Process inbox, create knowledge docs"
            ;;
        Starving)
            echo "🟠 STARVING - Heavy work needed"
            echo "   Focus: Capabilities and knowledge creation"
            ;;
        Hungry)
            echo "🟡 HUNGRY - Work needed"
            echo "   Balance: Capabilities + tasks + knowledge"
            ;;
        Fed)
            echo "🟢 FED - Hunt mode"
            echo "   Mode: Proactive scanning, speculative building"
            ;;
    esac
    echo ""
    
    # Show improvement suggestions
    echo "=== Quick Score Boosts ==="
    echo "  • Create new script: +10 points"
    echo "  • Write research doc: +2 points"
    echo "  • Complete queue task: +0.5 points"
}

# Main
case "${1:-log}" in
    log)
        log_score
        ;;
    today)
        show_today
        ;;
    week)
        show_week
        ;;
    trend|*)
        show_trend
        ;;
esac
