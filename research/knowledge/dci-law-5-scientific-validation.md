# DCI Law 5: Scientific Validation

*Environment Design Beats Agent Alignment*

## Source
arXiv:2601.16206 — Microsoft Research + Renmin + Tsinghua (Jan 2026)

## Core Finding
Give LLM sandbox access → it becomes agentic without training.

## The Three Meta-Capabilities
1. **External resources** — Internet access, package installation
2. **File system** — Read, write, organize information
3. **Code execution** — Run arbitrary programs

These aren't features. They're the infrastructure layer.

## Empirical Results

| Model | File Ops | Computation | Avg Turns |
|-------|----------|-------------|-----------|
| Strong | 21% | 12.5% | 12.6 |
| Weak | 2.9% | 2.9% | 23.7 |

Strong models leverage environment. Weak models wander.

## Implications for DCI

1. **Environment IS intelligence** — Sandbox unlocks capability without training
2. **File-based context beats prompts** — 8x token reduction
3. **Tool use correlates with competence** — Good agents use their environment
4. **Infrastructure > Instructions** — Build the space, behavior emerges

## Operational Rules

- Use capable models for sub-agents (weak wander)
- Offload to files when context grows
- Every tool is an environment extension
- The sandbox is THE infrastructure layer

## DCI Connection

Law 5 says: "Environment design beats agent alignment."

This paper proves it. The environment isn't a nice-to-have. It's the source of emergent intelligence.

---
*Created: 2026-02-07 00:05*
*Source: memory/2026-02-06.md (LLM-in-Sandbox Deep Dive)*
