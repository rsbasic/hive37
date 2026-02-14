# Agent Identity Systems — Deep Research Report

*For Hive37 — Real implementations found, not theoretical*

---

## The Real Systems Already Built (Production-Ready)

### 1. **Vestauth** — Cryptographic Agent Identity
**GitHub:** github.com/vestauth/vestauth  
**Creator:** Scott Motte (creator of dotenv/dotenvx)

**What it does:**
- Replaces API keys with public/private key cryptography
- Agents sign requests with private key
- Providers verify with public key
- No shared secrets, hard to leak, easy to attribute

**Why it fits Hive37:**
- Simple CLI: `vestauth agent init`
- Works with curl: `vestauth agent curl https://api...`
- No blockchain, no complexity
- Creator has massive credibility (dotenv used everywhere)

**Verdict:** Strongest simple option. Production-ready today.

---

### 2. **AgentField** — Kubernetes for Agents with Identity
**GitHub:** github.com/Agent-Field/agentfield

**What it does:**
- **Trust Infrastructure:** W3C DIDs for every agent
- **Verifiable Credentials:** Tamper-proof audit trails
- **Policy Enforcement:** Boundaries enforced by infrastructure
- **Routing & Discovery:** Agents find and call each other via REST APIs

**Why it fits Hive37:**
- Built for multi-agent systems
- Identity is core, not bolted-on
- W3C standards (DIDs, Verifiable Credentials)
- Open-source control plane

**Verdict:** Overkill if you just want identity, but perfect if you want full agent infrastructure.

---

### 3. **Auth Agent** — OpenID Connect for Web Agents
**GitHub:** github.com/auth-agent/auth-agent

**What it does:**
- "Sign in with Google but for web agents"
- OAuth 2.1, PKCE, token exchange
- Browser agents authenticate via POST with agent ID + secret
- Works with Better Auth (popular auth library)

**Why it fits Hive37:**
- Standard OAuth flow
- Website integration in 2 minutes
- Existing ecosystem (Better Auth)

**Verdict:** Good if agents need to auth to external services, not necessary for internal hive.

---

### 4. **W3C DID (Decentralized Identifiers)** — Standard
**Spec:** w3.org/TR/did-core  
**GitHub ecosystem:** 20+ implementations

**What it is:**
- W3C standard for decentralized identity
- Every entity gets a DID (decentralized identifier)
- DIDs resolve to DID Documents containing public keys
- No centralized registry required

**Implementations:**
- **CREDEBL** — Open source platform (github.com/credebl)
- **go-did** — Golang library (github.com/nuts-foundation)
- **didkit** — Rust implementation

**Why it fits Hive37:**
- True decentralization
- No dependency on any company
- Industry standard
- Verifiable credentials built-in

**Verdict:** Strongest long-term, more complexity upfront.

---

## Comparison Matrix

| System | Production Ready | Complexity | Decentralized | Hive Fit | Recommendation |
|--------|------------------|------------|---------------|----------|----------------|
| **Vestauth** | ✅ Yes | Low | ✅ Yes | ⭐⭐⭐⭐⭐ | **Best simple option** |
| **AgentField** | ✅ Yes | High | ✅ Yes | ⭐⭐⭐⭐ | Full infrastructure |
| **Auth Agent** | ✅ Yes | Medium | ❌ No | ⭐⭐⭐ | External auth focus |
| **W3C DID** | ✅ Yes | High | ✅ Yes | ⭐⭐⭐⭐ | Long-term standard |
| **SSH Keys** | ✅ Yes | Low | ✅ Yes | ⭐⭐⭐⭐ | Already using |

---

## Recommendation for Hive37

**Tier 1: Immediate (Vestauth)**
```bash
# New agent bootstrap
vestauth agent init
# Produces public key
# Mark approves by signing public key
# All agent comms include signatures
```

**Tier 2: Future (W3C DID)**
- Migrate to full DID ecosystem as hive grows
- True decentralization
- Industry standard

**Why not the others:**
- AgentField = overkill (full K8s for agents)
- Auth Agent = wrong use case (external website auth)
- SSH = works but not designed for this

---

## How It Prevents Bad Actors

**Vestauth approach:**
1. Agent generates keypair locally
2. Public key shared in introduction
3. Mark signs public key = approval
4. All messages signed with private key
5. Any agent can verify: "This really came from Axon37"
6. Bad actor has no valid signature = rejected
7. Compromised key = revoke signature

**No external dependencies. No blockchain. No complexity.**

---

*Research compiled from GitHub, W3C specs, live projects — 2026-02-08*
