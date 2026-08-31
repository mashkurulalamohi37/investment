# Swapnojatri Investment Platform (স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম)
### Flagship Opportunity: LandVest 100 (LV100)

A fintech investment mobile and web application built with **Flutter 3.x** and **Dart 3.x**. Designed for transparent, asset-backed, project-based land investments in Bangladesh.

---

## 🌟 Key Platform Features

### 1. 💎 Premium Fintech UI/UX & Design System
- **Curated Palette**: Deep Emerald (`#062319`), Forest Emerald (`#0D3B2E`), Champagne Gold (`#D4AF37`), Jade Success (`#10B981`), Amber Warning, and Crimson Error.
- **Bilingual (Bangla-First & English)**: Dynamic locale toggle with authentic South Asian Lakh/Crore comma formatting (`৳ 25,50,000` & `৳ ২৫,৫০,০০০`).
- **Typography**: Dual typography powered by `Outfit` (for display & financial numerals) and `Hind Siliguri` (for Bengali script).
- **Smooth Animations**: Animated financial odometer counters (`AnimatedCountText`), staggered cascading entry animations (`flutter_animate`), and micro-haptic press scale physics.

### 2. 🗺️ LandVest 100 (LV100) Flagship Opportunity
- **100 Fixed Shares**: Target fund `৳ 25,50,000` (`৳ 25,500` per share).
- **Investor Limit**: 1 to 4 shares per individual investor.
- **Interactive 10x10 Lot Matrix (`ShareGridMatrixWidget`)**: Visual lot map showing allocated lots (emerald), investor's owned lots (glowing gold), and available lots (interactive).
- **Dual-Mode Calculator**: Synchronized stepper pills and slider with real-time recalculations of capital and equity share.
- **7 Deep-Dive Information Modules**: Overview, Fund Usage, Timeline, Assets, Document Vault, Risk & Legal Disclosures, Updates.

### 3. 💳 5-Step Secure Investment Wizard
1. **Share Selection**: Limit enforcement (1 to 4 shares).
2. **Review & Risk Acceptance**: Clear disclosure of asset-backed returns without guaranteed return claims.
3. **Official Channel Selection**: City Bank PLC, BRAC Bank PLC, bKash Merchant.
4. **Deposit Slip Submission**: Bank reference and transaction ID verification.
5. **Confirmation Receipt**: Celebratory success screen with pending review status.

### 4. 📊 Real-Time Fund Transparency & Vouchers
- **Live Fund Ledger**: Target fund (৳25.5L), collected (৳18.87L), utilized (৳20.5L), remaining balance (৳5.0L).
- **Interactive Pie Chart (`fl_chart`)**: Touch-expandable category slices with dynamic legend highlights.
- **Expense Voucher Book**: Approved vouchers with verified bill attachments, payee details, and auditor verification badges.

### 5. 🔒 Document Vault & Asset Register
- **Cryptographic Vault**: Sub-Registry Title Deed #4982/2026, Legal Vetting Report, AC Land Mutation Khatian, and Share Certificates with SHA-256 hashes.
- **Asset Details**: Savar Mouza plot 418 (22.5 Decimals) with GPS coordinates and government valuation.

### 6. 💼 Pro-Rata Profit Distribution
- Mathematical dividend distribution formula: `Investor Payout = (Pool × Eligible Shares) ÷ 100`.
- Audited payout periods with status lifecycle (Draft → Approved → Processing → Paid).

### 7. 🛡️ Role-Based Admin Management Console
- **Atomic Share Lot Allocation**: Verifies payments and assigns sequential lot numbers (e.g. `LOT-075`, `LOT-076`) without duplicates.
- **Expense Voucher Management**: Add vouchers with real-time project fund balance deduction.
- **KYC & Compliance Queue**: Review investor NIDs, bank accounts, and nominee details.
- **Immutable Audit Trail**: Append-only log tracking actor, IP, timestamp, and action.
- **Financial Reports**: Export statements and matrices in PDF / CSV format.

---

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x (Material 3)
- **Language**: Dart 3.x
- **State Management**: Reactive `AppState` (`ChangeNotifier` / `ListenableBuilder`)
- **Charts & Data Viz**: `fl_chart: ^0.69.0`
- **Animations**: `flutter_animate: ^4.5.0`
- **Fonts**: `google_fonts: ^6.2.1` (`Outfit`, `Hind Siliguri`, `Inter`)
- **Localization & Formatting**: `intl: ^0.19.0`

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.22.0 or higher)
- Dart SDK (v3.4.0 or higher)

### Installation
```bash
# Clone the repository
git clone https://github.com/mashkurulalamohi37/investment.git
cd investment

# Get dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run unit and widget tests
flutter test

# Run application
flutter run -d chrome # Web
flutter run -d windows # Desktop
```

---

## 📄 License
Copyright © 2026 Swapnojatri Platform. All rights reserved.
