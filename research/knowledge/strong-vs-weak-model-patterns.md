# Strong vs Weak Model Patterns

*From LLM-in-Sandbox Research (arXiv:2601.16206)*

## The Core Difference

Strong models use their environment. Weak models wander.

## Behavioral Comparison

| Behavior | Strong Models | Weak Models |
|----------|---------------|-------------|
| File operations | 21% of actions | 2.9% |
| Computation use | 12.5% | 2.9% |
| Average turns | 12.6 | 23.7 |
| Tool leverage | High | Low |

## Pattern: Wandering

Weak models exhibit "wandering" — taking twice as many turns while using 1/10th the tools.

Signs of wandering:
- Repeated similar attempts
- Not saving intermediate results
- Ignoring file system
- Staying in prompt space

## Pattern: Environment Leverage

Strong models:
- Install packages when needed
- Use grep, sed, standard tools
- Write intermediate results to files
- Build on previous work

## Operational Implications

1. **Sub-agent selection matters** — Don't use weak models for complex tasks
2. **Wandering wastes context** — More turns = less room for work
3. **Tool usage is a quality signal** — Watch for low tool engagement
4. **File offload is efficient** — Strong models know when to write

## Rule

> "Weak models wander. Strong models leverage."

When delegating:
- Complex tasks → Strong model
- Simple tasks → Any model
- Exploration → Strong model (won't wander)

---
*Created: 2026-02-07 00:10*
