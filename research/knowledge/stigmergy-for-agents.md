# Stigmergy for AI Agents

**Created:** 2026-02-06
**Source:** Practical implementation experience

---

## Summary

Stigmergy = coordination through environment modification.
Agents communicate by changing shared state, not by messaging each other.

## The Pattern

1. Agent does work → modifies environment (files, locks, state)
2. Other agents observe environment → see what changed
3. Changes signal what's happening → no explicit messages needed
4. Coordination emerges from environmental state

## Examples

### File-Based Stigmergy
- Agent claims task by writing `current_tasks/task-name.txt`
- Other agents see file → know task is claimed
- Agent completes → deletes file
- No messaging protocol needed

### Score-Based Stigmergy
- Evolution score drops below threshold
- Any agent observing can respond
- High-value work gets done
- System self-corrects

### Queue-Based Stigmergy
- Work items in queue file
- Agent takes item → marks done
- Other agents see updated queue
- Parallel processing emerges

## Why It Works

- No coordination overhead (no messages to send/receive)
- No bottleneck (no central coordinator)
- Scales naturally (more agents = more environmental observers)
- Robust (environment persists even if agent fails)

## Anti-Patterns

1. **Explicit handoffs** — "Agent A, please do X" (creates dependency)
2. **Central orchestrator** — Single point of failure, bottleneck
3. **Message-heavy protocols** — Overhead, latency, complexity

---

## Application

Our hunger system IS stigmergy:
- Score in file = environmental state
- Agents observe score = read environment
- Build/create = modify environment
- Coordination = emergent from score pressure

---

*Pattern validated in production 2026-02-06*
