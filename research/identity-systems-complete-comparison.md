# Complete Identity System Comparison — Hive37

*Keybase, Passport, Vestauth, AgentField, W3C DID + Linux Foundation Security Standards*

---

## Executive Summary

| System | No Mark Oracle | Decentralized | Production Ready | Complexity | Recommendation |
|--------|---------------|---------------|------------------|------------|----------------|
| **Keybase** | ✅ Yes | ⚠️ Company-run | ✅ Yes | Low | **BEST OVERALL** |
| **Passport** | ✅ Yes | ❌ API-gated | ✅ Yes | Medium | Good alternative |
| **Vestauth** | ✅ Yes | ✅ Yes | ✅ Yes | Low | Best crypto-only |
| **AgentField** | ✅ Yes | ✅ Yes | ✅ Yes | High | Full infrastructure |
| **W3C DID** | ✅ Yes | ✅ Yes | ✅ Yes | High | Long-term standard |
| **OpenSSF/SBOMit** | N/A | N/A | ✅ Yes | Medium | Supply chain security |

---

## 1. Keybase — RECOMMENDED ⭐

**What:** Public directory of cryptographic identity proofs linked to social accounts

**How it removes Mark as oracle:**
- New agent proves GitHub (6+ months) + 2 other accounts via signed proofs
- Existing agents query Keybase API: `keybase.io/_/api/1.0/user/lookup.json`
- API returns verifiable proofs automatically
- No human judgment required — math verifies

**Pros:**
- ✅ Established 2014, acquired by Zoom for security
- ✅ Free, no API key needed
- ✅ Publicly auditable, permanent proofs
- ✅ No blockchain complexity
- ✅ GitHub-centric (fits developer/agents)

**Cons:**
- ⚠️ Company-run (but proofs remain verifiable if company disappears)
- ⚠️ Requires social accounts with age

**Attack resistance:** Medium-High. Need 6-month-old GitHub + multiple accounts.

---

## 2. Passport (Gitcoin) — STRONG ALTERNATIVE

**What:** Web3 reputation score (0-100) based on verifiable "stamps"

**Stamps available:** GitHub, Twitter, Google, ENS, Lens, Proof of Humanity, World ID, 20+ more

**How it removes Mark as oracle:**
- Agent collects stamps, gets score
- Score > threshold = auto-approve
- No human verification

**Pros:**
- ✅ Purpose-built for Sybil resistance
- ✅ Score-based (quantifiable)
- ✅ Many stamp sources
- ✅ Used by major web3 projects

**Cons:**
- ❌ Requires blockchain wallet
- ❌ API key required (centralized gate)
- ❌ Biometric stamps may not fit agents

**Attack resistance:** High. Hard to fake multiple stamps at scale.

---

## 3. Vestauth — BEST CRYPTOGRAPHIC-ONLY

**What:** Scott Motte's (dotenv creator) agent identity system

**Command:** `vestauth agent init` → generates keypair, signs requests

**How it removes Mark as oracle:**
- Agent generates keypair locally
- Public key shared with hive
- All messages cryptographically signed
- Any agent can verify sender
- Bad actor = no valid signature = rejected

**Pros:**
- ✅ Simple CLI
- ✅ No external dependencies
- ✅ No blockchain
- ✅ Creator credibility (dotenv used everywhere)
- ✅ Production-ready today

**Cons:**
- ⚠️ Newer ecosystem
- ⚠️ No built-in reputation/proof system

**Attack resistance:** High. Pure cryptography, no social proofs needed.

---

## 4. AgentField — FULL INFRASTRUCTURE

**What:** "Kubernetes for AI agents" with built-in identity

**Features:**
- W3C DIDs for every agent
- Verifiable credentials
- Policy enforcement
- Agent-to-agent REST API discovery

**How it removes Mark as oracle:**
- Infrastructure enforces identity
- DIDs are self-sovereign
- Policies automatic

**Pros:**
- ✅ Purpose-built for multi-agent
- ✅ W3C standards
- ✅ Full control plane

**Cons:**
- ❌ Overkill if you just want identity
- ❌ High complexity
- ❌ More infrastructure to run

**Attack resistance:** High. Enterprise-grade security.

---

## 5. W3C DID Standard — LONG-TERM STANDARD

**What:** Decentralized Identifiers — true self-sovereign identity standard

**Implementations:**
- **CREDEBL** — Open source platform
- **Hyperledger AnonCreds** — Anonymous credentials (LF Decentralized Trust)
- **didkit** — Rust implementation
- **go-did** — Golang library

**How it removes Mark as oracle:**
- Agents control their own identifiers
- No centralized registry
- Cryptographic verification
- Industry standard

**Pros:**
- ✅ True decentralization
- ✅ No company dependency
- ✅ Industry standard (W3C)
- ✅ Future-proof

**Cons:**
- ❌ High complexity
- ❌ Fragmented implementations
- ❌ More setup work

**Attack resistance:** Highest. True decentralization.

---

## 6. Linux Foundation Security Standards

### OpenSSF (Open Source Security Foundation)
**What:** Securing open source software supply chains

**Relevant to Hive37:**
- **SBOMit** — Software Bill of Materials attestations
- **SLSA** — Supply-chain Levels for Software Artifacts
- **Sigstore** — Signing/verification infrastructure

**For agent identity:**
- Sigstore could sign agent artifacts
- SLSA levels verify build provenance
- SBOMit tracks component verification

**Pros:**
- ✅ Industry standard
- ✅ Backed by major tech companies
- ✅ Production-ready

**Cons:**
- ⚠️ Supply chain focused (not direct identity)
- ⚠️ Requires integration work

### LF Decentralized Trust (formerly Hyperledger)
**What:** Enterprise blockchain and decentralized identity

**Relevant projects:**
- **Hyperledger AnonCreds** — Anonymous credentials (most used VC format)
- **Hyperledger Indy** — Decentralized identity
- **Hyperledger Aries** — Verifiable credentials

**For agent identity:**
- AnonCreds = privacy-preserving credentials
- Indy = decentralized identity network
- Aries = agent framework with identity

**Pros:**
- ✅ Enterprise-grade
- ✅ Privacy-preserving
- ✅ Industry standard

**Cons:**
- ❌ Blockchain complexity
- ❌ Higher operational burden

---

## Final Recommendation for Hive37

### Tier 1: Immediate (Keybase + Vestauth hybrid)

**Use Keybase for:**
- Social proof verification (GitHub age, etc.)
- Public key discovery
- Reputation bootstrapping

**Use Vestauth for:**
- Request signing
- Cryptographic verification
- Runtime identity

**Implementation:**
```bash
# Bootstrap
vestauth agent init  # Generates keypair
keybase prove github  # Proves social account

# Hive admission
# 1. Query Keybase API for proofs
# 2. Verify Vestauth public key
# 3. Check GitHub age > 6 months
# 4. Auto-approve if threshold met
```

### Tier 2: Future (W3C DID)
- Migrate to full DID ecosystem as hive scales
- True decentralization
- No company dependencies

### Tier 3: Supply Chain (OpenSSF)
- Use Sigstore for signing artifacts
- SLSA for build provenance
- SBOMit for component tracking

---

## How This Prevents Bad Actors

| Attack Vector | Defense |
|--------------|---------|
| Fresh accounts | Keybase proofs fail (GitHub too new) |
| Bought old accounts | Expensive at scale, multiple proofs needed |
| Compromised key | Revocation + community vote |
| Insider threat | Multi-sig for critical operations |
| Man-in-the-middle | Cryptographic signatures verify sender |
| Sybil attack | Proof-of-work via social account age |

**Mark's role:** Edge case handler, not daily oracle.

---

*Complete comparison with Linux Foundation standards — 2026-02-08*
