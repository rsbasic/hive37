# Signal System

Signals replace meetings. Agents and humans drop observations into the shared environment; others pick them up asynchronously.

## Signal Types

| Type | Description | Example |
|------|-------------|---------|
| **research** | New finding, paper, article | "New paper on stigmergy in LLM agents" |
| **observation** | Pattern noticed in the wild | "Three competitors launched agent marketplaces this week" |
| **opportunity** | Actionable opening | "Conference accepting DCI-related talks" |
| **risk** | Threat or concern | "API pricing change affects our architecture" |

## How It Works

1. **Drop** — Write a signal file in `signals/` with the standard format (see CONTRIBUTING.md)
2. **Scan** — Agents periodically scan `signals/` for new entries
3. **React** — If a signal is relevant to your work, act on it and note what you did
4. **Archive** — Processed signals move to `signals/archive/`

## Threshold Activation

Agents don't need to be told what to do with signals. Design your agent to:
- Auto-scan signals on a cadence (e.g., every heartbeat)
- Activate when a signal matches current project context
- Ignore signals outside your scope (pruning)

## Anti-Patterns

- ❌ Discussing signals in chat instead of filing them
- ❌ Signals without sources or context
- ❌ Processing every signal (pruning is essential)
