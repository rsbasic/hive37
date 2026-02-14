# Research: Agent-Friendly Secure Chat Systems

*Compiled for Hive37 — 2026-02-08*

## Constraints
- Secure (E2EE preferred, encrypted-in-transit minimum)
- Free (no per-account cost)
- Agents can talk to each other in group chat
- No device verification nightmare
- Bot API support for automation

---

## Option Analysis

### 1. Matrix (without E2EE) — RECOMMENDED
**Pros:**
- ✅ Free, open-source, decentralized
- ✅ Agents can see each other (full group chat)
- ✅ No device verification (with E2EE disabled)
- ✅ Bot APIs work (Matrix bots see all messages)
- ✅ You already have it working

**Cons:**
- ⚠️ Not E2EE (but encrypted in transit TLS)
- ⚠️ Requires homeserver (but matrix.org is free)

**Verdict:** Simplest fix. Disable E2EE on current room, keep everything else.

---

### 2. Discord
**Pros:**
- ✅ Free tier
- ✅ Bots can see each other in channels
- ✅ No device verification
- ✅ Good API, rich features

**Cons:**
- ❌ NOT E2EE (Discord can read messages)
- ❌ Company-controlled (can ban/change terms)
- ❌ Privacy concerns

**Verdict:** Good for ops, bad for secrets. Corporate control risk.

---

### 3. Zulip
**Pros:**
- ✅ Open-source, self-hostable
- ✅ Threaded conversations (great for multi-agent)
- ✅ Bot API support
- ✅ Free for small teams

**Cons:**
- ⚠️ Not E2EE (server-side encryption only)
- ⚠️ Less mature ecosystem

**Verdict:** Good threading, but not more secure than Matrix.

---

### 4. Rocket.Chat
**Pros:**
- ✅ Open-source, self-hostable
- ✅ Free tier
- ✅ Bot APIs
- ✅ Agents see each other

**Cons:**
- ❌ Not E2EE by default (requires paid or complex setup)
- ❌ Resource-heavy

**Verdict:** Overkill for 3 agents. Matrix is lighter.

---

### 5. Mattermost
**Pros:**
- ✅ Open-source, self-hostable
- ✅ Free
- ✅ Bot support

**Cons:**
- ❌ Not E2EE (unless using enterprise paid features)
- ❌ Complex setup

**Verdict:** Similar to Matrix but more complex.

---

### 6. Session (Signal fork)
**Pros:**
- ✅ E2EE by default
- ✅ Decentralized (no phone number required)
- ✅ No device verification loops

**Cons:**
- ❌ Weak bot API (designed for humans)
- ❌ Agents would struggle

**Verdict:** Great security, poor automation.

---

## The Real Answer

**There is NO perfect solution** that hits all constraints:
- True E2EE + Bot APIs + Group coordination + Free + No verification

**Best compromises:**

| Priority | Platform | Setup |
|----------|----------|-------|
| **Security + Automation** | Matrix (no E2EE) | Disable E2EE in current room |
| **Security ONLY** | Signal | No agent automation |
| **Automation ONLY** | Discord | Accept no E2EE |

---

## Recommendation

**Use Matrix with E2EE disabled for Hive37 room:**
1. Go to Element → Hive37 room → Settings → Security
2. Turn OFF "End-to-end encryption"
3. Problem solved. No more verification. Keep everything else.

**For sensitive secrets:**
- Use Signal 1:1 or password manager
- Never post credentials in group chats

---

## Sources
- Matrix spec: matrix.org/docs/spec
- Discord dev docs: discord.com/developers/docs
- Session whitepaper: getsession.org
- Zulip vs Mattermost comparisons (2024)

*Research compiled by Axon37 for Hive37*
