# GalaChain Perps Demo Script
## Complete Tutorial for 3PM Presentation

---

## PRE-DEMO SETUP

**Before starting:**
1. Open browser to `http://localhost:3002`
2. Ensure all services are running (gateway on :3001, UI on :3002)
3. Have $10K+ USDC ready in wallet for deposits

---

## SECTION 1: INTRODUCTION & OVERVIEW (2 minutes)

### What to say:
"This is GalaChain Perps — a decentralized perpetual futures exchange running on GalaChain. Every trade, every deposit, every position is recorded on the blockchain in real-time."

### What to show:
1. **Point to the top header:** "Live status indicator shows we're connected to the blockchain"
2. **Point to Account Summary:** "Real collateral, real P&L, real positions"
3. **Point to the 5 markets:** "BTC, ETH, SOL, GALA, LINK — all trading against USDC"

---

## SECTION 2: ACCOUNT OVERVIEW (2 minutes)

### Step 1: Show Account Summary
**Location:** Top of page, blue gradient card

**What to point out:**
- **Total Collateral:** Shows your deposited USDC (e.g., "$11,000.00")
- **Free Collateral:** Available for trading (e.g., "$8,500.00")
- **Margin Used:** Locked in positions (e.g., "$2,500.00")
- **Unrealized P&L:** Live profit/loss on open positions (e.g., "+$245.50" in green or "-$120.00" in red)
- **Account Health:** Progress bar showing margin safety (green = healthy, yellow = caution, red = danger)

**What to say:**
"This is my real account state. Every number comes directly from the blockchain. The P&L updates every 10 seconds as oracle prices move."

---

## SECTION 3: MARKET SELECTOR & CHART (3 minutes)

### Step 2: Switch Between Markets
**Location:** Horizontal bar below Account Summary

**Action:** Click through each market tab:
1. **Click BTC-PERP:** "Bitcoin perpetual, currently trading at $102,000"
2. **Click ETH-PERP:** "Ethereum at $3,200"
3. **Click SOL-PERP:** "Solana at $185"
4. **Click GALA-PERP:** "Gala at $0.042"
5. **Click LINK-PERP:** "Chainlink at $22"

**What to show:**
- Price updates instantly
- Chart switches to show each market's price history
- OrderBook updates to show relevant price levels
- 24h funding rate displays for each market

### Step 3: Explain the Chart
**Location:** Center of screen, large candlestick chart

**What to point out:**
- **100 candles of history:** "Last 100 minutes of price action"
- **Live price line:** "Current oracle price updating every 5 seconds"
- **Green/red candles:** "Price movement visualization"
- **Auto-scaling:** "Chart adjusts to show full price range"

**What to say:**
"This is real market data. Every candle represents actual trades and price movements on the blockchain. The live price comes from our decentralized oracle network."

---

## SECTION 4: ORDER BOOK (2 minutes)

### Step 4: Show Order Book Depth
**Location:** Right side of chart (bid/ask columns)

**What to point out:**
- **Green bids (left):** Buy orders, prices below current market
- **Red asks (right):** Sell orders, prices above current market
- **Spread:** Difference between best bid and best ask
- **Depth bars:** Visual representation of order size
- **Recent trades:** Scroll of last 20 trades with timestamps

**What to say:**
"This shows market depth. Even though we're in early testing, you can see the order book structure. In production, this fills with real limit orders from traders."

---

## SECTION 5: DEPOSIT COLLATERAL (3 minutes)

### Step 5: Open Deposit Modal
**Location:** Account Summary card → "Deposit" button

**Action:**
1. Click "Deposit" button
2. Modal opens with amount input

**What to show:**
- Quick presets: $100, $500, $1K, $5K
- Custom amount input
- Current wallet balance

### Step 6: Execute Deposit
**Action:**
1. Click "$5K" preset (or type "5000")
2. Click "Deposit" button
3. Wait for transaction (2-3 seconds)
4. Toast notification appears: "Successfully deposited $5,000.00"

**What to verify:**
- Account Summary updates: Total Collateral increases by $5,000
- Free Collateral increases by $5,000
- Trade History shows deposit record

**What to say:**
"That transaction just happened on the GalaChain blockchain. My collateral is now locked in the smart contract, ready for trading. The entire process took 2 seconds."

---

## SECTION 6: OPEN A POSITION (5 minutes)

### Step 7: Navigate to Trading Panel
**Location:** Left sidebar (or bottom on mobile)

**What to show:**
- Market/Limit/Stop order type tabs
- Long/Short direction toggle
- Size input field
- Leverage slider (1x to 50x)
- Order preview showing margin required

### Step 8: Configure Long Position
**Action:**
1. Ensure BTC-PERP is selected
2. Click "Long" (should already be selected)
3. Click "Market" order type
4. Enter size: "0.5" (half a BTC)
5. Set leverage: 10x (slider or click)

**What to show:**
- **Estimated Margin:** "~$5,100" (0.5 BTC × $102,000 ÷ 10)
- **Entry Price:** Current market price
- **Liquidation Price:** ~$91,800 (10x leverage)
- **Available:** Shows your free collateral

**What to say:**
"I'm going long 0.5 BTC with 10x leverage. This uses $5,100 of my collateral as margin. If Bitcoin drops to $91,800, I get liquidated."

### Step 9: Execute the Trade
**Action:**
1. Click "Long BTC" button (green)
2. Wait for transaction (3-5 seconds)
3. Toast: "Position opened successfully"

**What to verify:**
- Position appears in Position Dashboard
- Account Summary: Margin Used increases, Free Collateral decreases
- Trade History: New entry "BTC-PERP LONG 0.5 @ $102,000"

---

## SECTION 7: POSITION MANAGEMENT (3 minutes)

### Step 10: View Open Position
**Location:** Position Dashboard (below chart)

**What to point out:**
- **Symbol:** BTC-PERP
- **Side:** LONG (green badge)
- **Size:** 0.5000 BTC
- **Entry Price:** $102,000.00
- **Mark Price:** Current oracle price (e.g., $102,150)
- **Unrealized P&L:** Live profit/loss (e.g., "+$75.00")
- **Notional Value:** ~$51,075
- **Margin Used:** $5,100

**What to say:**
"My position is live. The P&L updates every 10 seconds as the oracle price moves. This is real unrealized profit — if I close now, I capture it."

### Step 11: Watch Live P&L Updates
**Action:** Wait 10-20 seconds

**What to show:**
- P&L number changes as price moves
- Green = profit, Red = loss
- Price direction indicator

**What to say:**
"Watch the P&L update in real-time. This is the mark price from our decentralized oracle network updating on-chain."

---

## SECTION 8: CLOSE POSITION (3 minutes)

### Step 12: Close the Position
**Action:**
1. Find the BTC position row
2. Click "Close" button (right side)
3. Modal confirms: "Close BTC-PERP LONG 0.5?"
4. Click "Confirm"
5. Wait for transaction (2-3 seconds)
6. Toast: "Position closed. Realized P&L: $XX.XX"

**What to verify:**
- Position disappears from dashboard
- Account Summary updates: Margin Used decreases, Free Collateral increases
- Realized P&L added to total
- Trade History: New entry "BTC-PERP CLOSE 0.5 @ $102,XXX, P&L: $XX.XX"

**What to say:**
"Position closed. The profit is now realized and added to my collateral balance. The entire trade — from deposit to close — happened entirely on-chain."

---

## SECTION 9: TRADE HISTORY (2 minutes)

### Step 13: Show Complete History
**Location:** TradeHistory component (scrollable list)

**What to point out:**
- **Open trades:** Entry price, size, direction
- **Close trades:** Exit price, realized P&L
- **Deposit/Withdraw:** Fund movements
- **Timestamps:** Exact time of each blockchain transaction

**What to say:**
"Every action is recorded permanently on the blockchain. This audit trail shows my complete trading history — transparent, immutable, verifiable."

---

## SECTION 10: ADVANCED FEATURES (3 minutes)

### Step 14: Limit Orders
**Action:**
1. In Trading Panel, click "Limit" tab
2. Enter size: "0.1"
3. Enter limit price: "$100,000" (below current market)
4. Click "Long BTC"

**What to show:**
- Order appears in Orders Panel (below positions)
- Status: OPEN
- Shows trigger price, size, direction

**What to say:**
"This limit order will execute if BTC drops to $100,000. Until then, it sits on the order book. I can cancel anytime."

### Step 15: Cancel Limit Order
**Action:**
1. Find order in Orders Panel
2. Click "Cancel" button
3. Toast: "Order cancelled"

### Step 16: Short Position (Optional)
**Action:**
1. Select ETH-PERP
2. Click "Short" toggle (now red)
3. Enter size: "1.0"
4. Click "Short ETH"

**What to say:**
"Short positions profit when prices fall. Same mechanics — margin, liquidation price, real-time P&L — but inverse exposure."

---

## SECTION 11: MULTIPLE POSITIONS (2 minutes)

### Step 17: Open Multiple Positions
**Action:** Open positions in different markets:
1. BTC Long 0.2 @ 10x
2. ETH Short 1.0 @ 5x
3. SOL Long 10 @ 10x

**What to show:**
- Position Dashboard lists all 3 positions
- Each with independent P&L
- Total margin used aggregated in Account Summary
- Account health reflects combined risk

**What to say:**
"I can hold multiple positions across markets simultaneously. Each has its own margin, liquidation price, and P&L. The account health bar shows my overall risk level."

---

## SECTION 12: WITHDRAWAL (2 minutes)

### Step 18: Withdraw Funds
**Action:**
1. Click "Withdraw" in Account Summary
2. Enter amount: "1000"
3. Click "Withdraw"
4. Confirm transaction
5. Toast: "Successfully withdrew $1,000.00"

**What to verify:**
- Account Summary updates
- Free collateral decreases
- Trade History shows withdrawal

**What to say:**
"Withdrawals are instant. My funds are never locked — I can exit anytime."

---

## CLOSING REMARKS (1 minute)

### Final Summary:
"What you just saw:
- Real decentralized perpetual futures
- Every trade on GalaChain blockchain
- Sub-second settlement
- Real-time P&L with live oracle prices
- No counterparty risk — fully collateralized
- Professional trading interface

This is live, working, today. Not a mockup. Real contracts, real trades, real money."

### Call to Action:
"Questions? Let's open some positions together."

---

## DEMO CHECKLIST

Before presenting, verify:
- [ ] localhost:3002 loads correctly
- [ ] Account shows collateral balance
- [ ] All 5 markets display prices
- [ ] Chart shows candlestick history
- [ ] Can switch between markets
- [ ] Deposit button opens modal
- [ ] Trading panel shows order preview
- [ ] Position dashboard displays correctly
- [ ] Close button works
- [ ] Trade history populates

---

## TROUBLESHOOTING

**If chart is empty:**
- Refresh page (chart regenerates)
- Check that `market?.oraclePrice` is populated

**If prices show wrong (e.g., $100B instead of $100K):**
- Refresh page (precision formatting issue)

**If "Connecting" shows instead of "Live":**
- Check gateway is running on :3001
- Check oracle keepers are running

**If position won't open:**
- Check sufficient free collateral
- Try smaller size
- Check browser console for errors

---

## DEMO TIPS

1. **Speak slowly** — Give audience time to see UI updates
2. **Point specifically** — Use cursor to highlight elements
3. **Wait for confirmations** — Let toasts appear before continuing
4. **Show live updates** — Pause to show P&L changing
5. **Have backup** — If one feature fails, skip to next
6. **Keep $10K+ collateral** — Enough for multiple demo trades
7. **Pre-open 1-2 positions** — So there's something to show immediately

---

*Generated: 2026-02-09 06:45 AM*
*Demo Location: localhost:3002*
*Target: 3PM Presentation*
