# Stigmergy: Environment-Mediated Coordination

*Core DCI Pattern*

## Definition

Stigmergy: Coordination through environment modification, not direct communication.

Greek: stigma (mark) + ergon (work)

## Examples in Nature

| System | Signal Medium | Behavior |
|--------|---------------|----------|
| Ant colonies | Pheromone trails | Shortest path finding |
| Termite mounds | Soil pellet placement | Complex architecture |
| Neurons | Synaptic weights | Learning |

## Examples in Our System

| Pattern | Implementation |
|---------|----------------|
| Task coordination | work-queue.md, STATE.md |
| Memory persistence | memory/*.md files |
| Progress tracking | INDEX.md, work-log-*.md |
| Agent handoff | File changes, not messages |

## Why It Works

1. **Decoupled** — Agents don't need synchronous communication
2. **Persistent** — Environment holds state across sessions
3. **Scalable** — More agents don't mean more coordination overhead
4. **Observable** — Any agent can read the current state

## Implementation Rules

1. **Write to files, not messages** — Files persist, messages don't
2. **State lives in environment** — Not in agent memory
3. **Changes are signals** — File modifications communicate intent
4. **Read before acting** — Environment tells you what's needed

## The Anthropic Validation

Claude Code's agent teams use stigmergy:
- Shared task list (environment)
- No direct agent-to-agent communication
- File system carries coordination

> "The environment is the message."

---
*Created: 2026-02-07 00:15*
