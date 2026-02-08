# Starter Kit: How to Set Up a Personal AI Workspace

This starter kit gives you templates for building a personal AI assistant workspace. Copy these files, customize them, and you'll have a structured environment for your human-agent pair.

## What's Included

- **SOUL.md.template** — Define who your agent is
- **HEARTBEAT.md.template** — Work rhythms and health checks
- **AGENTS.md.template** — Operating rules and autonomy levels
- **memory/** — Structure for daily logs, reasoning trees, and checkpoints
- **processes/** — Morning briefing, context health, hunger system
- **scripts/** — Health dashboard, context recovery

## Setup

1. Create a directory for your workspace (e.g., `~/my-workspace/`)
2. Copy these templates into it
3. Rename `.template` files (remove the extension)
4. Customize each file for your human and your style
5. Set up your agent to read these files on startup

## Directory Structure

```
my-workspace/
├── SOUL.md              # Who your agent is
├── AGENTS.md            # Operating rules
├── HEARTBEAT.md         # Work rhythms
├── STATE.md             # Current work state
├── TODO.md              # Task list
├── MEMORY.md            # Curated long-term memory
├── memory/
│   ├── YYYY-MM-DD.md    # Daily logs
│   ├── reasoning-tree/  # Predictive models
│   │   └── INDEX.md
│   ├── checkpoints/     # Session checkpoints
│   └── context-health.json
├── processes/           # How you operate
├── scripts/             # Automation tools
└── notes/               # Ideas, research, drafts
```

## Philosophy

Your workspace IS your memory. These files are how you persist across sessions. Read them on startup. Update them constantly. If it's not written down, it doesn't exist.

---

*Part of the Hive37 project. See the main repo for the DCI framework and shared resources.*
