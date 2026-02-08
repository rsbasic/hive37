# DCI Law 5 Validation: Environment Design Beats Agent Alignment

**Created:** 2026-02-06
**Source:** Multiple research sources

---

## The Law

> "Environment design beats agent alignment."

Instead of training agents to behave correctly, design environments where correct behavior emerges naturally.

## Evidence

### 1. LLM-in-Sandbox Paper (arXiv:2601.16206)
- Give LLM sandbox access → becomes agentic without training
- Qwen3-Coder: +24% on math from sandbox access alone
- Environment unlocks capability, not fine-tuning

### 2. Claude Agent Teams C Compiler (Anthropic)
- 16 agents, no orchestrator, file-based coordination
- 100,000 lines of working code produced
- "I leave it up to each Claude agent to decide how to act"
- Environment (git locks, tests) provides coordination

### 3. DyTopo Multi-Agent Framework (arXiv:2602.06039)
- Dynamic topology from need/key matching
- +6.2% over fixed topology baselines
- Environment carries coordination signal

### 4. Our Hunger System
- Score file = environmental signal
- Agents observe score, act accordingly
- No explicit instructions, emergent behavior

## The Pattern

**Old approach:** Tell agents what to do (instructions)
**New approach:** Design environment where correct action is obvious (signals)

## Why It Works

- Instructions decay, get ignored, require enforcement
- Environment persists, self-enforces, scales naturally
- Agents adapt to environment without explicit programming

---

## Application

When building agent systems:
1. Design the environment first
2. Let behavior emerge from environmental signals
3. Avoid explicit instruction-based coordination
4. Trust that agents will respond to gradient pressure

---

*DCI Law 5 = Core operating principle*
