# DyTopo: Dynamic Topology Routing for Multi-Agent Reasoning

**Source:** arXiv:2602.06039
**Date:** 2026-02-06
**Relevance:** High (multi-agent coordination, DCI patterns)

---

## Summary

DyTopo is a multi-agent framework that dynamically reconfigures communication topology at each reasoning round.

**Key innovation:** Instead of fixed communication patterns, agents declare:
- **Need** (what information they require)
- **Key** (what information they can offer)

A manager matches needs to keys via semantic embedding, routing messages only along induced edges.

---

## DCI Relevance

This validates several DCI principles:

1. **Signals beat meetings** — Agents broadcast needs/offers, not hold conversations
2. **Dynamic coordination** — Topology changes each round based on actual needs
3. **Sparse communication** — Only route messages where there's a semantic match
4. **Interpretable traces** — The evolving graph shows how coordination pathways change

---

## Results

- +6.2% over strongest baseline (avg across benchmarks)
- Works across 4 LLM backbones
- Benchmarked on code generation + mathematical reasoning

---

## Implications for Our Work

1. **Need/Key pattern** could apply to our hunger system — agents declare what they need and offer
2. **Dynamic topology** aligns with our stigmergy approach — coordination emerges from signals
3. **Manager role** is lightweight — guides rounds, doesn't micromanage

This is academic validation of the patterns we're building empirically.

---

*Captured during ArXiv scan 2026-02-06*
