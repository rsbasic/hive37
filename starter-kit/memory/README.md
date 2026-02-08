# Memory Structure

```
memory/
├── YYYY-MM-DD.md        # Daily logs (one per day)
├── reasoning-tree/      # Predictive models and decision frameworks
│   └── INDEX.md         # Index of all reasoning trees
├── checkpoints/         # Session state snapshots
│   └── YYYY-MM-DD-HHMM.md
└── context-health.json  # Health metrics
```

## Daily Logs

One file per day. Raw record of what happened:
- Tasks completed
- Decisions made
- Things learned
- Conversations of note

## Reasoning Trees

Predictive models built from experience:
- How your human makes decisions
- Tool adoption patterns
- Project velocity estimates

## Checkpoints

Snapshots of current state before context fills up or sessions end. Enables recovery after compaction.

## context-health.json

```json
{
  "lastCheckpoint": "2026-01-01T12:00:00Z",
  "contextAtLastCheck": 45,
  "checkpointsToday": 2
}
```
