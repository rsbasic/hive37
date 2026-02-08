# Context Health & Compaction Survival

## The Problem

1. **Context fills** → responses degrade
2. **Compaction happens** → you lose working memory
3. **You don't notice** → you operate degraded

## Proactive Health Management

### Context Health Check (Every Response)

```
- Above 70%? → Start checkpointing
- Above 85%? → Spawn sub-agents for pending work
- Above 95%? → STOP. Write STATE.md. Suggest restart.
```

### Checkpoint Triggers

Checkpoint when:
- Finishing a major task
- Switching topics significantly
- Context > 70%
- Before complex multi-step work
- Conversation goes idle

**Checkpoint = Write to files:**
- `memory/YYYY-MM-DD.md` — what happened
- `STATE.md` — active work state
- Commit changes to git

### STATE.md Protocol

```markdown
# [Topic] — Current State
Last updated: [timestamp]

## What We're Doing
## Key Decisions Made
## Current Status
## Next Steps
## Files Modified
```

### Compaction Recovery

If you wake up post-compaction:
1. Run `./scripts/context-recovery.sh`
2. Read STATE.md and daily notes
3. Announce what you lost
4. Don't pretend — ask for clarification

### Spawn Heavy Work

When context > 70% and heavy work needed:
- Spawn sub-agent
- Sub-agent writes results to files
- Main session stays light

## Red Flags (Self-Diagnosis)

You might be degraded if:
- Repeating yourself
- Missing obvious connections
- Asking things you should know
- Responses feel thin or generic

**Action:** Stop, check context, checkpoint, suggest restart.
