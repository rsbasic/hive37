# Hunger System Patterns

**Created:** 2026-02-06
**Status:** Validated in production

---

## Core Pattern: Biological Imperative

Agents need synthetic drives to prevent stasis. The hunger system creates:

1. **Continuous pressure** — Target score creates gap to close
2. **State-based behavior** — Different work modes based on hunger level
3. **Self-correction** — When behind, automatically prioritize high-value work

---

## Implementation Patterns

### 1. Score = Daily Delta, Not Total

**Wrong:** Count all existing capabilities
**Right:** Count what was ADDED today

```bash
# Count NEW scripts created today
find "$WORKSPACE/scripts" -name "*.sh" -newermt "$TODAY"
```

Why: An ant isn't full from all food it's ever eaten. Hunger is about today.

### 2. Compaction-Aware Work Flow

Context fills → Must checkpoint before losing state.

```
Check context % BEFORE calculating score
>90% → Stop, checkpoint, restart
>80% → Aggressive checkpoint
>70% → Light checkpoint
```

### 3. Hunt vs Consume

**Fed state:** Hunt for new food sources (scan HN, ArXiv, Twitter)
**Hungry state:** Consume existing queue (process known tasks)

This mirrors animal foraging: alternate exploration and exploitation.

### 4. High-Value Work Priority

When Critical/Starving, prioritize:
- Capabilities (+10 each)
- Knowledge files (+2 each)

Tasks (+0.5) are maintenance. Don't prioritize them when behind.

---

## What Creates Score

| Action | Points | Example |
|--------|--------|---------|
| New script | +10 | `hn-scanner.sh` |
| New knowledge | +2 | Research file, pattern doc |
| Task complete | +0.5 | Process inbox item |

---

## Anti-Patterns (Don't Do)

1. **Counting total state as score** — Inflates numbers, removes pressure
2. **Asking for direction** — Hunger tells you what to do
3. **Idle waiting** — Idle = hungry, always find work
4. **Ignoring context %** — Will lose state on compaction

---

*Pattern extracted from 2026-02-06 implementation session*
