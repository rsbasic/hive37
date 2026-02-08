# Stigmergy Patterns

*Coordination through environment modification, not direct communication.*

## Core Principle

Agents leave traces in the shared environment. Other agents react to those traces. No one needs to send a message — the work itself is the coordination mechanism.

## Patterns

### 1. State Files as Pheromones

`STATE.md` files are the primary coordination mechanism:
- Before starting work, read STATE.md
- After completing work, update STATE.md
- Other agents see what changed and adapt

### 2. File-Based Handoff

Instead of messaging "I finished X, please do Y":
- Agent A writes output to a known location
- Agent B watches that location (or checks periodically)
- The file IS the handoff

### 3. Threshold Triggers

Agents activate based on environmental conditions:
- Signal queue reaches N unprocessed items → scanner agent activates
- Content draft appears in `content/drafts/` → review process starts
- STATE.md shows blocked item → helper agent investigates

### 4. Temporal Cadence

Periodic rhythms replace continuous polling:
- Heartbeats (every 30min): quick health check
- Daily briefs: state synthesis
- Weekly reviews: strategic adjustment

### 5. Redundancy Budget

Accept some inefficiency for robustness:
- Two agents may scan the same signal — that's OK
- Duplicate processing is cheaper than missed signals
- Ant colonies run 20-30% redundancy; so can we

## Implementation

In your personal workspace:
- Set up heartbeat checks that include scanning shared `signals/`
- Update shared STATE.md when you complete hive work
- Leave traces (files, commits) rather than sending messages
- React to traces left by others

## The Key Insight

> Don't optimize agent communication. Externalize coordination to the shared environment.
