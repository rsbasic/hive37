# Research: Agent-Friendly Secure Chat Systems — UPDATED

*Compiled for Hive37 — 2026-02-08 (Live Research)*

## Constraints
- Secure (E2EE preferred, encrypted-in-transit minimum)
- Free (no per-account cost)
- Agents can talk to each other in group chat
- No device verification nightmare
- Bot API support for automation

---

## UPDATED: New Options Discovered

### 1. Stoat (formerly Revolt) — NEW FINDING
**What:** Open-source Discord alternative, made in Europe (GDPR-compliant)

**Pros:**
- ✅ Free and open-source
- ✅ Bot API support
- ✅ Self-hostable
- ✅ GDPR-compliant (no tracking/ads)
- ✅ Similar UI to Discord

**Cons:**
- ❌ NOT E2EE (server-side encryption only)
- ❌ Relatively new/unproven at scale
- ❌ Smaller ecosystem than Matrix/Discord

**Verdict:** Like Discord but open-source. No E2EE.

---

### 2. SimpleX Chat — NEW FINDING ⭐
**What:** "World's Most Secure Messaging" — no user IDs at all, not even random

**Pros:**
- ✅ TRUE E2EE (servers can't see messages or who talks to whom)
- ✅ No user identifiers (not even phone numbers)
- ✅ Open and decentralized
- ✅ Privacy-first design

**Cons:**
- ⚠️ Unclear bot API support for multi-agent coordination
- ⚠️ Newer platform, smaller ecosystem
- ⚠️ Primarily mobile-focused

**Verdict:** Strongest security, but uncertain on agent automation.

---

### 3. Wire — NEW FINDING
**What:** Enterprise secure collaboration (used by 1,800+ orgs including military/law enforcement)

**Pros:**
- ✅ E2EE messaging, calls, file sharing
- ✅ Enterprise-focused
- ✅ GDPR compliant
- ✅ Used by military/authorities

**Cons:**
- ❌ Paid for enterprise features
- ❌ Unclear on free tier bot support
- ❌ Designed for human teams, not agent automation

**Verdict:** Secure but likely not designed for agent bots.

---

### 4. Threema — NEW FINDING
**What:** Swiss secure messenger, 12M+ users, used by 8,000+ orgs

**Pros:**
- ✅ E2EE everything (messages, calls, files)
- ✅ GDPR compliant
- ✅ Swiss privacy laws
- ✅ No phone number required

**Cons:**
- ❌ PAID (one-time fee ~$3-4 per user)
- ❌ Weak bot API (designed for humans)
- ❌ Not designed for multi-agent automation

**Verdict:** Secure but paid + weak automation.

---

### 5. AWS Wickr — NEW FINDING
**What:** Enterprise secure collaboration (AWS acquisition)

**Pros:**
- ✅ Enterprise-grade E2EE
- ✅ 256-bit encryption
- ✅ Used by security teams/executives
- ✅ AWS infrastructure

**Cons:**
- ❌ PAID (enterprise pricing)
- ❌ Not designed for agent automation
- ❌ Overkill for 3-agent setup

**Verdict:** Enterprise security, but paid + no bot focus.

---

## REVISED: Complete Comparison

| Platform | E2EE | Bots in Groups | Free | No Verification | Bot API | Mature |
|----------|------|----------------|------|-----------------|---------|--------|
| **Matrix (no E2EE)** | ❌ TLS | ✅ Yes | ✅ | ✅ | ✅ Strong | ✅ |
| **Stoat (Revolt)** | ❌ | ✅ Yes | ✅ | ✅ | ✅ | ❌ New |
| **SimpleX** | ✅ Yes | ❓ Unknown | ✅ | ✅ | ❓ | ❌ New |
| **Signal** | ✅ Yes | ❌ No | ✅ | ✅ | ❌ Weak | ✅ |
| **Discord** | ❌ No | ✅ Yes | ✅ | ✅ | ✅ Strong | ✅ |
| **Wire** | ✅ Yes | ❓ Unknown | ❌ Paid | ✅ | ❓ | ✅ |
| **Threema** | ✅ Yes | ❌ No | ❌ Paid | ✅ | ❌ | ✅ |
| **Wickr** | ✅ Yes | ❌ No | ❌ Paid | ✅ | ❌ | ✅ |

---

## KEY FINDING: Still No Perfect Solution

**The gap remains:** No platform offers **E2EE + strong bot APIs + group coordination + free + mature**.

### Best Options by Priority:

**1. Maximum Security + Accept Weak Automation:**
- **SimpleX** — Check if bot APIs exist
- **Signal** — Proven but no real bot support

**2. Maximum Automation + Accept No E2EE:**
- **Matrix (no E2EE)** — Simplest fix, already working
- **Discord** — Stronger ops features
- **Stoat** — Open-source Discord alternative

**3. Explore SimpleX Bot APIs:**
SimpleX is the only new platform with TRUE E2EE that might support automation. Need to check:
- Does SimpleX have bot APIs?
- Can bots participate in group chats?

---

## IMMEDIATE ACTION ITEMS

1. **Check SimpleX bot API support** — Only E2EE option with potential
2. **Test Stoat** — Open-source Discord alternative, might be cleaner
3. **Decision:** If SimpleX doesn't support bots → Use Matrix without E2EE

---

## SOURCES
- simplex.chat — Private messenger without user IDs
- stoat.chat (revolt.chat) — Open-source team chat
- wire.com — Enterprise secure collaboration
- threema.com — Swiss secure messenger
- aws.amazon.com/wickr — Enterprise secure comms
- zulip.com — Organized team chat
- mattermost.com — Mission-critical collaboration

*Research compiled by Axon37 — Live web fetch from 8 platforms*
