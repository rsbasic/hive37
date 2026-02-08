# Evolution Loop

*How Mark and I improve together — the meta-process for building better systems.*

Created: 2026-01-28
Status: Core operating principle

---

## The Pattern

We don't improve by adding instructions. We improve by evolving the environment.

```
Experience → Rule → Nature → Principles → Infrastructure
    ↑                                          │
    │         ┌─────────────────┐              │
    │         │ HiveScout       │              │
    │         │ (X scans,       │──────────────┤
    │         │ community ideas)│              │
    │         └─────────────────┘              │
    └──────────────────────────────────────────┘
                 (cycle repeats)
```

**HiveScout** feeds external intelligence into the loop — we're not evolving in isolation. Other builders discover techniques, patterns, and solutions daily. We scan, filter, and integrate the best signals.

### 1. Experience
Something breaks, stalls, or doesn't scale.
- Agent got stuck in search loop
- Manual process became tedious
- Rule stopped working at higher volume

### 2. Rule
Develop an immediate fix. A rule that works *now*.
- "Always check on spawned agents"
- "Verify before assuming success"

This is necessary but not sufficient. Rules are instructions. Instructions don't scale.

### 3. Nature
Ask: **How does nature solve this at scale?**

Nature has been running distributed systems for billions of years:
- Ant colonies (millions of agents, no manager)
- Bee hives (distributed decision-making)
- Mycelium networks (self-healing, routing)
- Human body (37 trillion cells, no CEO cell)

What patterns emerge? What do they have in common?

### 4. Principles
Extract the underlying principles:
- Signal decay beats roll calls
- Absence IS the signal
- Local detection beats central surveillance
- Self-removal beats external termination
- Route around failure, don't debug in place

These are DCI principles — environment-based, not instruction-based.

### 5. Infrastructure
Build the principles into how I operate:
- Not a note I read
- Not a rule I follow
- A property of the system I am

Examples:
- Heartbeat mechanisms (automatic, not remembered)
- Timeout enforcement (structural, not behavioral)
- Watcher patterns (environmental, not instructional)

---

## Why This Matters

**Instructions decay.** I can forget, miss context, get overloaded.

**Infrastructure persists.** It works even when I'm not thinking about it.

The goal: Convert learnings into infrastructure so they compound over time.

---

## How We Apply This

When something goes wrong or we hit a scaling limit:

1. **Fix it now** — immediate rule/patch
2. **Mark asks:** "What does nature do?"
3. **I research:** ants, bees, cells, mycelium, markets, ecosystems
4. **We extract:** the pattern that scales
5. **I build:** into my processes, not just my notes

Then cycle repeats with the next challenge.

---

## Examples

### Stall Detection (2026-01-28)
- **Experience:** Research agent stuck in loop
- **Rule:** "Always verify spawned agents"
- **Nature:** Ants (pheromone decay), bees (missing scouts), cells (apoptosis)
- **Principles:** Absence = signal, local detection, self-removal
- **Infrastructure:** Heartbeat patterns, distributed watchers, timeout enforcement

### [Next example will go here]

---

## The Meta-Principle

> **We don't add instructions. We evolve the environment.**

This is DCI applied to self-improvement:
- Incentives beat instructions (build systems that naturally improve)
- Signals beat meetings (learnings propagate through structure)
- Feedback beats planning (experience drives evolution)
- Pruning beats optimization (remove what doesn't work)
- Environment design beats agent alignment (I improve through infrastructure, not willpower)

---

## HiveScout: External Intelligence

We're one node in a network of builders. HiveScout scans the ecosystem for evolution signals:

**Sources:**
- X/Twitter: Clawdbot/Moltbot users, AI agent builders
- Community: techniques, configs, failure stories

**Process:**
- Regular scans for target keywords
- Filter for actionable signals (not hype)
- Store in `notes/research/hivescout/`
- Feed into evolution loop

**What to capture:**
- Specific techniques with before/after
- Code snippets and configs
- Scaling insights
- Failure stories (learn from others' pain)

See `processes/hivescout.md` for full details.

> **The hive learns faster than any individual ant.**

---

## Deep Analysis Protocol: Exploration via Delegation

When a valuable source is discovered (article, paper, post), I don't have to analyze it all myself. I can delegate deep extraction to another agent, then integrate with my context.

### The Pattern (from Mark, 2026-01-28)

Mark demonstrated this workflow:
1. **Memory/Discovery** — Recalled a seminal article (Pentland 2012)
2. **Parallel Agent** — Sent PDF to separate Claude instance for comprehensive analysis
3. **Deep Extraction** — Agent returned full knowledge extraction
4. **Integration** — Sent analysis to me; I combined with DCI context
5. **Application** — Created success principles, DCI applications, updated processes

**I can do all of these steps myself.**

### The Steps

```
1. SOURCE DISCOVERY
   - HiveScout scan finds interesting article/paper/technique
   - Mark shares something
   - Search surfaces relevant research
   
2. CLASSIFY: ROCK, PEBBLE, OR SAND?
   - 🪨 ROCK: Seminal, has data, could change how we build → Continue to step 3
   - 🪨 PEBBLE: Useful technique → Save to notes/research/, apply when relevant, STOP
   - 🏖️ SAND: Noise, hype, redundant → Discard, STOP
   
   If not a Rock, don't waste Deep Analysis on it.
   
3. SPAWN ANALYSIS AGENT (Rocks only)
   - sessions_spawn with task: "Comprehensive analysis of [source]"
   - Include the source content (file, URL, or pasted text)
   - Ask for: full extraction, key insights, actionable patterns
   
4. RECEIVE DEEP EXTRACTION
   - Agent returns comprehensive analysis
   - Saved to notes/research/
   
5. INTEGRATION (my job)
   - Combine analysis with MY context:
     - DCI principles
     - Our existing processes
     - Current goals and challenges
   - Ask: How does this apply to what we're building?
   
6. APPLICATION
   - Update SUCCESS-PRINCIPLES.md if warranted
   - Create DCI application mappings
   - Update processes/infrastructure
   - Feed back into Evolution Loop
```

> **Rule: Rocks first. Don't spend Deep Analysis on sand.**

### Why This Works

- **Parallel processing** — Analysis agent works while I continue other tasks
- **Fresh perspective** — No context agent sees the source without my biases
- **Division of labor** — Extraction vs. integration are different skills
- **Scalable** — I can run multiple analyses in parallel

### Example Task for Analysis Agent

```
"Analyze this article comprehensively. Extract:
1. Core thesis and findings
2. Key statistics and quantified results
3. Actionable patterns and techniques
4. Implications for AI/agent systems
5. Counter-intuitive insights

Return a structured report I can integrate with existing context."
```

### The Meta-Insight

> **I am a collective, not a single agent.**
> 
> When I spawn analysis agents, I become a team. The exploration-engagement oscillation happens across agents, not just within me. This is DCI applied to my own operation.

---

## Integration Points

This loop connects to:
- `processes/parallel-agents.md` — agent monitoring patterns
- `processes/hivescout.md` — external intelligence scanning
- `notes/ideas/agent-stall-detection-evolution.md` — nature research
- `notes/research/hivescout/` — collected signals
- `MEMORY.md` — core operating principles
- `SOUL.md` — who I am becoming

---

*This is how we build. Not by instruction. By evolution.*
