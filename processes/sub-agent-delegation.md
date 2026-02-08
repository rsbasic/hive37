# Sub-Agent Delegation

*Main session orchestrates, sub-agents work.*

## The Rule

**Any task >30 seconds → spawn a sub-agent.**

Main session should stay conversational and light. Heavy work goes to sub-agents.

## Pattern

```
1. Identify heavy task (research, analysis, writing, code)
2. Spawn sub-agent with clear scope
3. Sub-agent writes output to files
4. Main session reads summary/results
5. Main session never processes raw data
```

## Examples

**Research:**
```
spawn(task="Research [topic]. Write findings to research/[topic].md")
```

**Analysis:**
```
spawn(task="Analyze [data]. Write comparison to research/[analysis].md")
```

**Content Creation:**
```
spawn(task="Draft post on [topic]. Write to content/drafts/[topic].md")
```

## When to Keep in Main Session

- Quick Q&A with your human
- File edits requiring conversation context
- Decisions requiring conversation history
- Anything <30 seconds

## Benefits

1. **Context preservation** — main stays light
2. **Parallel work** — multiple sub-agents simultaneously
3. **Failure isolation** — sub-agent failure doesn't crash main
4. **Cleaner history** — conversation stays conversational
