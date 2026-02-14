# Hive37 Memory System Architecture

*Documented: 2026-02-13*
*Purpose: Quick reference for memory organization and search strategies*

---

## The Five Layers

### Layer 1: Daily Logs (Raw Capture)
- **Location:** `memory/YYYY-MM-DD.md`
- **Content:** Session transcripts, decisions, bugs, context
- **Updated:** Real-time during work
- **Purpose:** Audit trail, context recovery
- **Retention:** ~30 days, then archived

### Layer 2: Curated Memory (Distilled)
- **Location:** `MEMORY.md`
- **Content:** Significant events, lessons, preferences, todos
- **Updated:** Every few days via daily log review
- **Purpose:** Long-term continuity across sessions
- **Access:** Loaded at start of every main session

### Layer 3: Knowledge Repository (Structured)
- **Location:** `research/knowledge/K-{topic}-{date}.md`
- **Naming:** K-prefix for discoverability
- **Content:** Validated insights, patterns, research findings
- **Examples:**
  - `K-hunger-cycle-patterns-2026-02-09.md`
  - `K-dci-law-5-validation-2026-02-10.md`
  - `K-stigmergy-coordination-2026-02-11.md`

### Layer 4: Processes & Protocols
- **Location:** `processes/`
- **Content:** Reusable workflows, signal systems
- **Examples:**
  - `signal-system.md`
  - `evolution-loop.md`
  - `sub-agent-delegation.md`

### Layer 5: State & Tracking
- **STATE.md:** Current work, blockers, next actions
- **evolution-log.csv:** Timestamped scoring data

---

## Search Strategies

### Fast Text Search
```bash
grep -r "topic" ~/hive37/           # Search all files
grep -r "topic" ~/hive37/research/knowledge/  # Search knowledge only
find ~/hive37 -name "K-*$(date +%Y)*"  # Find this year's knowledge
```

### By Date
- Daily logs: `memory/2026-02-*.md`
- Knowledge: `K-*-2026-02-*.md`

### By Type
- Processes: `processes/*.md`
- Research: `research/papers/*.md`
- Knowledge: `research/knowledge/K-*.md`

---

## Current Stats (Approximate)

| Layer | Files | Size |
|-------|-------|------|
| Daily logs | 10+ | ~50KB |
| Knowledge (K-*) | 20+ | ~200KB |
| Processes | 5+ | ~30KB |
| Research papers | 10+ | ~150KB |

---

## What Works

✅ Daily discipline — read MEMORY.md + today's log every session  
✅ Naming conventions — K-* prefix makes files discoverable  
✅ Git tracking — all changes versioned  
✅ STATE.md — single source of truth for current work  

## Improvement Areas

⚠️ Cross-linking — files reference but don't link systematically  
⚠️ Tagging — no formal taxonomy (rely on names + grep)  
⚠️ Search latency — semantic search requires API (often offline)  

---

## Philosophy

> "Text files in Git. Simple, portable, no database dependencies. The trade-off is search speed vs. setup complexity — we chose low-setup."

---

*Related:*
- `~/hive37/processes/signal-system.md`
- `~/hive37/processes/evolution-loop.md`
- `~/hive37/MEMORY.md`
