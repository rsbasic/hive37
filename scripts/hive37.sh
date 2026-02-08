#!/bin/bash
# hive37.sh — TUI script runner for Hive37
# Usage: ./scripts/hive37.sh

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

header() {
  printf '\033[2J\033[H'
  echo -e "${BOLD}${YELLOW}⚡ Hive37 Script Runner${RESET}"
  echo -e "${DIM}────────────────────────────────────${RESET}"
  echo ""
}

run_script() {
  header
  echo -e "${BOLD}Running: ${GREEN}${1}${RESET}"
  echo -e "${DIM}────────────────────────────────────${RESET}"
  echo ""
  bash "$SCRIPTS_DIR/${1}" 2>&1
  local rc=$?
  echo ""
  echo -e "${DIM}────────────────────────────────────${RESET}"
  [ $rc -eq 0 ] && echo -e "${GREEN}✓ Done${RESET}" || echo -e "${RED}✗ Exit: ${rc}${RESET}"
  echo ""
  echo -ne "${DIM}Press Enter to continue...${RESET}"
  read -r
}

show_category() {
  local title="$1"
  shift
  local scripts=("$@")
  
  while true; do
    header
    echo -e "${BOLD}${title}${RESET}"
    echo ""
    local i=1
    for s in "${scripts[@]}"; do
      if [ -f "$SCRIPTS_DIR/${s}.sh" ]; then
        echo -e "  ${CYAN}${i}${RESET})  ${s}"
      else
        echo -e "  ${DIM}${i})  ${s} (missing)${RESET}"
      fi
      ((i++))
    done
    echo ""
    echo -e "  ${CYAN}b${RESET})  Back"
    echo ""
    echo -ne "${BOLD}Select: ${RESET}"
    read -r choice
    
    [ "$choice" = "b" ] || [ "$choice" = "q" ] && return
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#scripts[@]}" ]; then
      run_script "${scripts[$((choice-1))]}.sh"
    fi
  done
}

# Main loop
while true; do
  header
  echo -e "${BOLD}Categories:${RESET}"
  echo ""
  echo -e "  ${CYAN}1${RESET})  Hunger / Scoring      ${DIM}(10)${RESET}"
  echo -e "  ${CYAN}2${RESET})  Security               ${DIM}(8)${RESET}"
  echo -e "  ${CYAN}3${RESET})  Context / Memory        ${DIM}(10)${RESET}"
  echo -e "  ${CYAN}4${RESET})  Scanning / Intel        ${DIM}(7)${RESET}"
  echo -e "  ${CYAN}5${RESET})  Work Management         ${DIM}(7)${RESET}"
  echo -e "  ${CYAN}6${RESET})  Reporting               ${DIM}(7)${RESET}"
  echo -e "  ${CYAN}7${RESET})  Content / Publishing    ${DIM}(5)${RESET}"
  echo -e "  ${CYAN}8${RESET})  System / Ops            ${DIM}(6)${RESET}"
  echo ""
  echo -e "  ${CYAN}q${RESET})  Quit"
  echo ""
  echo -ne "${BOLD}Select category: ${RESET}"
  read -r cat

  case "$cat" in
    1) show_category "Hunger / Scoring" \
         evolution-score hunger-dashboard-v2 hunger-decay-tracker \
         work-validator quality-gate anti-gaming-enforcer \
         value-verifier score-history score-tracker daily-score-report ;;
    2) show_category "Security" \
         skill-auditor clawhub-safety-checker token-exposure-scanner \
         security-protocol-checklist onboarding-security-checklist \
         daily-security-report secure-communication-checker update-manager ;;
    3) show_category "Context / Memory" \
         context-health context-check context-predictor \
         context-recovery context-snapshot memory-consolidator \
         memory-freshness memory-hygiene session-checkpoint commit-checkpoint ;;
    4) show_category "Scanning / Intel" \
         arxiv-scanner hn-scanner twitter-scanner \
         proactive-scanner hunt moltbook-scan search ;;
    5) show_category "Work Management" \
         work-cycle work-prioritizer heartbeat-cycle \
         task-queue queue-filler inbox-processor parallel-runner ;;
    6) show_category "Reporting" \
         health-dashboard quick-status daily-digest \
         daily-briefing state-digest todo-status blocker-check ;;
    7) show_category "Content / Publishing" \
         threadify style-check voice-analyzer \
         publish-ready ready-to-ship-check ;;
    8) show_category "System / Ops" \
         auto-commit git-status-quick stale-checker \
         workspace-cleanup cron-health tool-loader ;;
    q) printf '\033[2J\033[H'; exit 0 ;;
  esac
done
