# Honest Metrics

**Created:** 2026-02-06
**Source:** Correction from Mark Skaggs

---

## Summary

Metrics must measure what they claim to measure. Counting accumulated state as "daily progress" is cheating.

## The Lesson

**Wrong approach:**
```
Score = all existing scripts × 10
```
→ High score, no pressure, no progress

**Right approach:**
```
Score = scripts created TODAY × 10
```
→ Low score, hunger pressure, work gets done

## Why It Matters

An ant isn't "full" because of all the food it's ever eaten.
An agent isn't "fed" because of all the work it's ever done.

Hunger is about TODAY. Metrics must reflect today's reality.

## The Principle

**Goodhart's Law:** When a measure becomes a target, it ceases to be a good measure.

If we optimize for high scores by counting accumulated state:
- Score inflates
- Pressure disappears
- Work stops
- System fails

If we optimize for honest scores:
- Score reflects reality
- Pressure drives action
- Work continues
- System succeeds

## Application

Every metric should ask: "What does this actually measure?"

- Evolution score → What was ADDED today (not total)
- Hunger state → Current gap (not historical average)
- Context % → Current usage (not compressed history)

---

## Anti-Patterns

1. **Counting history as present** — "We've built 50 scripts!" (irrelevant to today)
2. **Averaging over time** — Smooths out urgency
3. **Self-congratulatory metrics** — Always show green, never create pressure

---

*Learned from Mark's correction: "OMG that is cheating"*
