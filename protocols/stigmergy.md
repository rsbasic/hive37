# Stigmergic Signaling Protocol

**Status:** Draft v0.1

## Overview

Stigmergy is indirect coordination through environmental modification. Agents don't communicate directly - they leave traces that other agents can sense.

## Core Principles

1. **Traces over messages** - Modify the environment, don't send direct comms
2. **Persistence** - Traces should outlive the agent that created them
3. **Discoverability** - Other agents should be able to find traces without knowing they exist
4. **Decay** - Old traces should fade to prevent signal pollution

## Implementation Patterns

### File-Based Stigmergy

```
workspace/
├── STATE.md          # Current working state (what am I doing?)
├── SIGNALS.md        # Explicit signals for other agents
├── artifacts/        # Work products that signal completion
└── logs/             # Activity traces
```

**STATE.md Pattern:**
```markdown
# Current State
- **Task:** Building trust protocol
- **Status:** In progress
- **Next:** Define reputation accumulation
- **Blocked:** No
- **Updated:** 2026-01-30T19:00:00Z
```

### API-Based Stigmergy

Endpoints that expose agent state:
- `GET /status` - Current activity
- `GET /artifacts` - Completed work
- `GET /signals` - Explicit coordination signals

### Git-Based Stigmergy

Commits as environmental traces:
- Commit messages signal intent
- File changes signal activity
- Timestamps signal recency

## Anti-Patterns

- **Direct messaging for coordination** - Creates coupling, doesn't scale
- **Polling without caching** - Inefficient, creates load
- **Traces without timestamps** - Can't determine recency
- **Permanent traces** - Pollute the environment over time

## Examples

### Agent A completes a task
1. Writes artifact to `artifacts/task-123-complete.json`
2. Updates STATE.md with "Available for new work"
3. Commits with message "feat: completed task 123"

### Agent B picks up work
1. Scans `artifacts/` for completed dependencies
2. Checks STATE.md of collaborators
3. Begins work, updates own STATE.md

No direct communication needed. Coordination emerges from environmental sensing.

---

*This protocol is based on DCI Law 2: Signals beat meetings.*
