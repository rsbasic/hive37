---
platform: Twitter/LinkedIn
type: insight
status: ready
created: 2026-02-06
source: Anthropic Claude Code agent teams release, Feb 5 2026
hook: Anthropic just shipped what we built by hand
word_count: ~200
---

# Agent Teams Are DCI Productized

Anthropic just released agent team orchestration for Claude Code.

Team lead. Teammates. Shared task list. Parallel execution.

This is exactly what we built by hand two weeks ago.

---

**What we learned the hard way:**

We ran an experiment. Gave two AI agents 50+ coordination rules.
Changed it to 2 rules. The 2-rule version was 3x faster.

The rules that survived:
1. Do obvious work, report what you did
2. Blocked? Swap roles

That's it. Everything else was overhead.

---

**What Anthropic shipped:**

- Each agent gets its own context window
- Shared task list coordinates work
- No single point of failure
- Parallel execution by default

Sound familiar? It's stigmergy. Environment carries coordination.

---

**The pattern:**

When we built it: "That's a hack."
When Anthropic ships it: "That's infrastructure."

The hack was always the pattern. We just didn't have permission to call it that.

DCI Law #5: Environment design beats agent alignment.

Anthropic just made the environment.
