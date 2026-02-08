# Sandbox Unlocks Intelligence

*Key findings from LLM-in-Sandbox research (arXiv:2601.16206)*

Created: 2026-02-07

---

## Core Finding

Give an LLM sandbox access → it becomes agentic without additional training.

The sandbox provides three meta-capabilities that unlock intelligence:
1. **External resources** — internet access, package installation
2. **File system** — read/write/organize persistent storage
3. **Code execution** — run arbitrary programs

## Quantified Results

| Model | Improvement | Mechanism |
|-------|-------------|-----------|
| Qwen3-Coder | +24% math | Sandbox access alone |
| Long-context | 8x token reduction | File offloading |
| General | Emergent scripts | Package install, grep/sed |

## Strong vs Weak Models

| Metric | Strong | Weak |
|--------|--------|------|
| File operations | 21% | 2.9% |
| Computation use | 12.5% | 2.9% |
| Turns to complete | 12.6 | 23.7 |

**Key insight:** Weak models wander. Twice the turns, 1/10th the tool usage.

## DCI Validation

This validates **DCI Law #5: Environment design beats agent alignment.**

The sandbox IS the infrastructure layer. Intelligence emerges from environment access, not instruction following.

## Operational Implications

1. **OpenClaw architecture validated** — sandbox-first is correct
2. **Model selection matters** — weak models waste cycles in sandboxes
3. **File-based context > prompt-based** — offload to files
4. **The sandbox is THE infrastructure** — everything builds on it

## Application

When spawning sub-agents:
- Give them sandbox access
- Use capable models (weak models wander)
- Let them use file system for context
- Expect emergent tool usage

---

*Source: Microsoft Research + Renmin + Tsinghua (arXiv:2601.16206)*
