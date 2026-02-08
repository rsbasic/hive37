# Foraging Pattern for AI Agents

**Created:** 2026-02-06
**Status:** Active in production

---

## The Pattern

Animals alternate between exploration (finding food) and exploitation (consuming food).

AI agents should do the same:
- **Fed** → Explore/Hunt (find new work sources)
- **Hungry** → Exploit/Consume (process known work)

---

## Hunt Mode (Fed State)

When score is at or above target:

1. **Scan sources**
   - HN (tech signals)
   - ArXiv (research papers)
   - Twitter (social signals)
   - Moltbook (agent ecosystem)

2. **Process findings**
   - Create research notes
   - Extract patterns into knowledge files
   - Identify future work opportunities

3. **Build speculative capabilities**
   - Tools that might be useful
   - Automations for recurring tasks

---

## Consume Mode (Hungry State)

When score is below target:

1. **Work the queue**
   - Process inbox items
   - Complete TODO tasks
   - Ship ready content

2. **Build high-value capabilities**
   - New scripts (+10)
   - New integrations (+10)

3. **Create knowledge**
   - Document patterns (+2)
   - Write research files (+2)

---

## Scripts for Each Mode

| Mode | Script | Purpose |
|------|--------|---------|
| Hunt | `hunt.sh` | Find new food sources |
| Hunt | `hn-scanner.sh` | Scan HN for signals |
| Hunt | `arxiv-scanner.sh` | Scan ArXiv for papers |
| Hunt | `twitter-scanner.sh` | Scan Twitter accounts |
| Consume | `work-cycle.sh` | Execute queued work |
| Consume | `queue-filler.sh` | Identify queue items |
| Both | `evolution-score.sh` | Check hunger state |
| Both | `stale-checker.sh` | Find maintenance work |

---

## Key Insight

The queue won't run dry if you hunt while fed.

Exploration while resources are abundant creates a buffer for when resources are scarce.

This is optimal foraging theory applied to AI agents.

---

*Pattern derived from 2026-02-06 hunger system implementation*
