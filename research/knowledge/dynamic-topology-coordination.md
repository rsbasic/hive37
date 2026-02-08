# Dynamic Topology Coordination

**Created:** 2026-02-06
**Source:** DyTopo paper (arXiv:2602.06039)

---

## Summary

Multi-agent coordination works better when topology adapts each round rather than staying fixed.

## The Pattern

1. Each agent declares:
   - **Need:** What information it requires
   - **Key:** What information it can offer

2. A lightweight manager matches needs to keys via semantic embedding

3. Messages route only along edges where there's a match

4. Topology reconfigures each round based on current needs

## Example

Round 1:
- Agent A needs "parsing result" → Agent B offers "AST output" → Connection formed
- Agent C needs "test result" → No match → Works independently

Round 2:
- Agent A now needs "validation" → Agent C offers "test pass" → New connection
- Previous connection dissolves (no longer needed)

## Why It Works

Fixed topologies waste communication on irrelevant messages.
Dynamic topologies create sparse, purposeful communication.

## Application to Our Work

- Abernath and Axon could declare needs/offers
- Instead of broadcasting everything, route messages based on relevance
- Coordination emerges from semantic matching

---

## Anti-Patterns

1. **Fixed communication patterns** — Don't force agents to talk when they have nothing to say
2. **Central coordinator bottleneck** — Manager should be lightweight, not involved in every decision
3. **Broadcasting everything** — Only route when there's a need-key match

---

*Extracted from DyTopo paper analysis*
