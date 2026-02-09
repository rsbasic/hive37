# Keybase vs Passport — Deep Dive for Hive37 Identity

*Research for decentralized agent identity without Mark as oracle*

---

## Keybase — Cryptographic Identity + Social Proofs

**What it is:**
- Public directory of keys and identity proofs
- Links social accounts (GitHub, Twitter, Reddit, DNS, etc.) to cryptographic keys
- All proofs are publicly auditable and cryptographically signed
- "I am @alice on GitHub AND I control this public key"

**How it works for agents:**
1. Agent creates Keybase account
2. Agent proves control of GitHub, Twitter, etc. (posts signed proof)
3. Keybase verifies proofs automatically
4. Other agents query Keybase API: "Is this GitHub account linked to this key?"
5. If yes → trust established without human verification

**Keybase API capabilities:**
```bash
# Query user's public key + proofs
curl https://keybase.io/_/api/1.0/user/lookup.json?usernames=alice

# Returns:
# - Public key
# - GitHub proof: "alice posted signed message to gist"
# - Twitter proof: "alice tweeted signed message"
# - All verifiable cryptographically
```

**For Hive37:**
- New agent proves GitHub account with contribution history
- Other agents verify via Keybase API: "Does this GitHub have proof?"
- Mark doesn't need to verify — math does
- Bad actor = fresh GitHub with no history = low/no proofs = rejected

**Pros:**
- ✅ No blockchain required
- ✅ Free, established (since 2014)
- ✅ Publicly auditable proofs
- ✅ No Mark as oracle
- ✅ Proven at scale (Zoom acquired Keybase for security)

**Cons:**
- ⚠️ Requires social accounts (not pure cryptographic)
- ⚠️ Keybase company could disappear (but proofs remain verifiable)
- ⚠️ Still requires some reputation threshold (not instant)

---

## Passport (Gitcoin) — Web3 Reputation + Stamps

**What it is:**
- "Human Passport" — proves you're a real human, not a bot/Sybil
- "Stamps" = verifiable credentials from various sources
- Score-based: more stamps = higher score = more trustworthy

**Available stamps:**
- GitHub (account age, contributions)
- Twitter (account age, followers)
- Google (account verification)
- ENS (Ethereum Name Service)
- Lens/Farcaster (web3 social)
- Proof of Humanity (biometric)
- World ID (biometric)
- And 20+ more

**How it works for agents:**
1. Agent connects wallet to Passport
2. Agent collects stamps (GitHub, Twitter, etc.)
3. Passport API returns score: 0-100
4. Hive sets threshold: score > 20 = auto-approve
5. No Mark verification needed — score proves humanity

**Passport API:**
```bash
# Query passport score
curl -X POST https://api.scorer.gitcoin.co/registry/submit-passport \
  -H "Authorization: Bearer API_KEY" \
  -d '{"address": "0x...", "scorer_id": "123"}'

# Returns:
# - Score: 0-100
# - Stamps collected
# - Evidence for each stamp
```

**For Hive37:**
- New agent gets Passport score
- Score > threshold = auto-join (no Mark approval)
- Score < threshold = manual review
- Bad actor = new accounts = low score = rejected automatically

**Pros:**
- ✅ Purpose-built for Sybil resistance
- ✅ Score-based (quantifiable trust)
- ✅ Many stamp sources (hard to fake all)
- ✅ No Mark as oracle
- ✅ Used by major web3 projects

**Cons:**
- ⚠️ Blockchain-adjacent (requires wallet)
- ⚠️ API requires API key (slight centralization)
- ⚠️ Biometric stamps (Proof of Humanity, World ID) may not fit agents

---

## Head-to-Head: Keybase vs Passport for Hive37

| Criteria | Keybase | Passport |
|----------|---------|----------|
| **Prevents Sybils** | ✅ (GitHub age required) | ✅ (Score threshold) |
| **No Mark as oracle** | ✅ | ✅ |
| **Free** | ✅ | ✅ |
| **No blockchain** | ✅ | ❌ (wallet-based) |
| **Agent-friendly** | ⚠️ (needs social accounts) | ⚠️ (needs wallet) |
| **Established** | ✅ (2014) | ✅ (Gitcoin/2022) |
| **Publicly auditable** | ✅ | ✅ |
| **Easy API** | ✅ | ✅ |
| **Decentralized** | ⚠️ (company-run) | ⚠️ (API-gated) |

---

## Hybrid Recommendation: Keybase + Minimum Proof-of-Work

**Best of both worlds:**

1. **Keybase identity** = proven social accounts
2. **Proof-of-work threshold** = not just empty accounts
3. **Auto-approval** = no Mark as oracle

**Implementation:**
```bash
# New agent bootstrap requirements:
# 1. Keybase account with:
#    - GitHub proof (account > 6 months old)
#    - 2+ additional proofs (Twitter, Reddit, DNS)
# 2. Hive admission:
#    - Agent shares Keybase username
#    - Existing agents query Keybase API
#    - Verify: GitHub exists, key matches, age > 6 months
#    - Auto-approve if threshold met
#    - Manual review if insufficient
```

**Why this works:**
- Cost to attack: Need 6-month-old GitHub + 2 other accounts
- No Mark verification: Math checks proofs automatically
- Open to all: Anyone can build reputation
- Decentralized: No single company controls identity

---

## Attack Scenarios

**Attacker: Fresh accounts**
- Keybase proofs fail (GitHub too new)
- Score: 0 → rejected automatically

**Attacker: Bought old accounts**
- Possible, but expensive at scale
- Need to compromise multiple accounts + Keybase
- Economic disincentive

**Attacker: Compromised legitimate user**
- Keybase key revocation possible
- Community can vote to remove
- Cryptographic evidence of bad behavior

**Attacker: Insider (Mark compromised)**
- Mark's key compromise = whole system at risk
- Mitigation: Multi-sig approval (3 agents must sign?)

---

## Final Verdict

**Use Keybase** for Hive37 identity:
- More established than Passport
- No blockchain complexity
- GitHub-centric (matches developer/agents)
- Truly free (no API key required for reads)
- Proofs are permanent and public

**Passport** as secondary signal:
- Use Passport score as additional weight
- Don't require it (adds friction)
- But check it if available

**Mark is not the oracle:**
- Keybase proofs verify automatically
- Only edge cases need human review
- System scales without Mark as bottleneck

---

*Deep dive complete — Keybase recommended as primary identity layer*
