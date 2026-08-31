# Swapnojatri Investment Platform — UI/UX Specification & Customization Guide

This document serves as the complete **UI/UX Design System, Component Architecture, and Customization Manual** for the **Swapnojatri Investment Platform (স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম)** and its flagship project **LandVest 100 (LV100)**.

Use this guide to update, re-theme, customize, or extend any visual element, screen, or business logic.

---

## 📑 Table of Contents
1. [Design Tokens & Theme System](#1-design-tokens--theme-system)
   - [Color Palette](#color-palette)
   - [Typography & Bengali Fonts](#typography--bengali-fonts)
   - [Spacing, Radius & Shadows](#spacing-radius--shadows)
2. [Financial Formatting & Bilingual Engine](#2-financial-formatting--bilingual-engine)
3. [Component Library & Widget Architecture](#3-component-library--widget-architecture)
4. [Screen Directory & Navigation Tree](#4-screen-directory--navigation-tree)
5. [Business Logic & Mathematical Formulas](#5-business-logic--mathematical-formulas)
6. [How-To Customization Recipes](#6-how-to-customization-recipes)

---

## 1. Design Tokens & Theme System

### Color Palette
Location: `lib/core/theme/app_colors.dart`

The palette is benchmarked against Swiss/British private wealth applications (Revolut Ultra, Wise, Apple Wallet) with zero artificial neon gradients.

| Token Name | Hex Code | Purpose & Usage |
| :--- | :--- | :--- |
| `primary` | `#0B281E` | Deep Oxford Pine — Main brand color, buttons, hero backgrounds |
| `primaryDark` | `#061812` | Midnight Pine — Dark mode primary headers |
| `primaryMedium` | `#134233` | Secondary brand surface accents |
| `primaryLight` | `#1C5C48` | Interactive active states, subtle borders |
| `primarySubtle`| `#EBF5F0` | Pill badges, light card highlight fills |
| `accentGold` | `#C59B27` | Muted Matte Gold — Certified seal borders, lot highlights |
| `accentGoldLight` | `#DFBA4C` | Dark mode gold text, icons |
| `success` | `#0D8A5E` | Jade Green — Positive returns, audited status, paid dividends |
| `warning` | `#D97706` | Amber — Risk disclaimers, pending verification |
| `error` | `#DC2626` | Crimson — Rejected transactions, failed states |
| `info` | `#2563EB` | Cobalt Blue — Informational tags, legal disclosures |
| `lightBg` | `#F8FAFC` | Off-white canvas background in light mode |
| `lightCard` | `#FFFFFF` | Ceramic white card surface |
| `lightCardBorder` | `#E2E8F0` | Hairline border (0.8px – 1.0px) |
| `darkBg` | `#0B0F14` | Deep Charcoal background in dark mode |
| `darkCard` | `#151E2B` | Slate surface in dark mode |
| `darkCardBorder` | `#243242` | Hairline border for dark mode cards |

---

### Typography & Bengali Fonts
Location: `lib/core/theme/app_typography.dart`

We use a dual typography engine powered by Google Fonts:
- **Display & Financial Numerals**: `GoogleFonts.outfit` (ultra-clean, modern geometric banking typography).
- **Bangla Script & UI Copy**: `GoogleFonts.hindSiliguri` (authentic, readable Bengali typography).
- **Subtitles & Captions**: `GoogleFonts.inter` (high-density body text).

```dart
// Examples of Typography Tokens:
AppTypography.financialAmountLarge()   // 34-36px Outfit/Hind, Weight 800
AppTypography.financialAmountMedium()  // 18-20px Outfit/Hind, Weight 700
AppTypography.headingLarge()           // 22-24px, Weight 700
AppTypography.headingMedium()          // 16-18px, Weight 700
AppTypography.bodyMedium()             // 14px, Height 1.5
AppTypography.caption()                // 11-12px, Weight 500-600
```

---

### Spacing, Radius & Shadows
- **Spacing Scale** (`lib/core/theme/app_spacing.dart`): `xs: 4`, `sm: 8`, `md: 12`, `lg: 16`, `xl: 20`, `xxl: 24`, `xxxl: 32`, `huge: 48`.
- **Border Radius** (`lib/core/theme/app_radius.dart`):
  - `borderXs`: `4.0` (Lot matrix tiles, tiny status badges)
  - `borderSm`: `8.0` (Buttons, tags)
  - `borderMd`: `12.0` (Standard cards, inputs, tiles)
  - `borderLg`: `16.0` (Hero cards, modals)
  - `borderXl`: `24.0` (Action dialogs, bottom sheets)
  - `borderFull`: `999.0` (Pills, progress bar ends)
- **Shadow Tokens** (`lib/core/theme/app_shadows.dart`): Precision 1-2px ambient diffusion, zero heavy neon blur.

---

## 2. Financial Formatting & Bilingual Engine

Location: `lib/core/localization/currency_formatter.dart`

### Bangladeshi Taka (BDT) Lakh / Crore Notation
Implements authentic South Asian comma grouping:

$$\text{৳ 25,50,000 (Twenty-Five Lakh Fifty Thousand)}$$

- `CurrencyFormatter.format(2550000)` $\rightarrow$ `৳ 25,50,000`
- `CurrencyFormatter.format(2550000, isBangla: true)` $\rightarrow$ `৳ ২৫,৫০,০০০`
- `CurrencyFormatter.formatCompact(2550000, isBangla: true)` $\rightarrow$ `৳ ২৫.৫০ লাখ`

### Bilingual String Dictionary
Location: `lib/core/localization/app_strings.dart`
Contains all paired strings across investor and admin modules for instant language switching without page reloads.

---

## 3. Component Library & Widget Architecture

All bespoke widgets are modular and located in `lib/core/widgets/`:

| Component | File Path | Description & Props |
| :--- | :--- | :--- |
| **`PortfolioHeroCard`** | `portfolio_hero_card.dart` | Institutional black-emerald card showing total capital, lot numbers, escrow bank, and realized dividend. |
| **`ShareGridMatrixWidget`** | `share_grid_matrix_widget.dart` | 10x10 Cadastral plot map showing 100 shares. Color-codes Allocated (slate), User Owned (forest emerald/gold), and Available (clickable). |
| **`AnimatedCountText`** | `animated_count_text.dart` | Smooth rolling counter for currency (`৳ 0` $\rightarrow$ `৳ 1,02,000`) and percentages. |
| **`KpiCard`** | `kpi_card.dart` | Financial counter card with micro-spring scale feedback on touch (`1.0` $\rightarrow$ `0.97`). |
| **`ProjectCard`** | `project_card.dart` | LandVest 100 featured discovery card with live progress bar and share counters. |
| **`TransactionTile`** | `transaction_tile.dart` | Ledger row with credit/debit badges, timestamps, and status chips. |
| **`ExpenseTile`** | `expense_tile.dart` | Transparency fund voucher row with verified bill inspection modal. |
| **`DocumentVaultCard`** | `document_vault_card.dart` | Cryptographically sealed document tile with SHA-256 hash badge and PDF download. |
| **`StatusChip`** | `status_chip.dart` | Semantic badge for Investment, Project, Distribution, and KYC statuses. |
| **`AppButton`** | `app_button.dart` | Primary, Secondary, Outline, Gold, and Ghost button variants with haptic feedback. |
| **`CelebratorySuccessWidget`** | `celebratory_success_widget.dart` | Fintech confirmation sheet with expanding gold halo and verified checkmark. |

---

## 4. Screen Directory & Navigation Tree

```
lib/
├── core/
│   ├── constants/project_seeds.dart          # Realistic seed records
│   ├── localization/currency_formatter.dart  # BDT South Asian grouping
│   ├── localization/app_strings.dart        # Bilingual dictionary
│   ├── theme/                               # Colors, Typography, Shadows, Radius
│   └── widgets/                             # Modular UI component library
├── data/
│   ├── models/                              # 12 Immutable Domain Models
│   └── state/app_state.dart                 # Central reactive state engine
├── features/
│   ├── splash/splash_screen.dart            # Logo reveal & branding
│   ├── onboarding/onboarding_screen.dart    # 3-Step value tour
│   ├── auth/auth_screen.dart                # Phone OTP & One-Click Demo
│   ├── investor/
│   │   ├── main_layout.dart                 # Bottom navigation container
│   │   ├── home/home_screen.dart            # Investor dashboard
│   │   ├── projects/projects_screen.dart    # Project discovery & filters
│   │   ├── project_detail/project_detail_screen.dart # LandVest 100 deep dive & 10x10 lot map
│   │   ├── investment_flow/investment_flow_dialog.dart # 5-Step investment wizard
│   │   ├── portfolio/portfolio_screen.dart  # Holdings & share certificates
│   │   ├── transactions/transactions_screen.dart # Ledger & PDF/CSV export
│   │   ├── transparency/transparency_screen.dart # Live fund balance & touch FlChart
│   │   ├── assets/assets_screen.dart        # Land plot 418 deed & coordinates
│   │   ├── profit_distribution/profit_distribution_screen.dart # Pro-rata payouts
│   │   ├── document_vault/document_vault_screen.dart # SHA-256 vault
│   │   ├── kyc/kyc_screen.dart              # NID, bank & nominee verification
│   │   ├── support/support_screen.dart      # FAQ accordions & help desk
│   │   └── profile/profile_screen.dart      # Settings, Theme, Role switcher
│   └── admin/
│       ├── admin_layout.dart                # Admin management container
│       ├── dashboard/admin_dashboard_screen.dart # Executive KPIs & 100-lot inspector
│       └── modules/
│           ├── investments_manager_screen.dart # Payment verification & atomic lot allocator
│           ├── expense_manager_screen.dart  # Fund voucher creation & ledger deduction
│           ├── kyc_approvals_screen.dart    # Investor identity approval queue
│           ├── audit_logs_screen.dart       # Immutable security logs
│           └── reports_screen.dart          # Regulatory PDF/CSV generators
└── main.dart                                # Root entry, state provider & theme switcher
```

---

## 5. Business Logic & Mathematical Formulas

### 1. LandVest 100 (LV100) Constants
- **Total Project Shares**: $100$
- **Price per Share**: $৳ 25,500$
- **Target Project Fund**: $100 \times ৳ 25,500 = ৳ 25,50,000$
- **Investor Share Limit**: $1 \text{ to } 4 \text{ shares per investor}$
- **Current Allocation**: $74 \text{ shares allocated} \ (৳ 18,87,000) \ | \ 26 \text{ shares available} \ (৳ 6,63,000)$

### 2. Fund Transparency Balance Calculation
$$\text{Total Expenses} = \sum \text{Approved Expense Vouchers} = ৳ 20,50,000$$
$$\text{Remaining Fund Balance} = \text{Target Fund} - \text{Total Expenses} = ৳ 25,50,000 - ৳ 20,50,000 = ৳ 5,00,000$$

### 3. Pro-Rata Dividend Distribution Formula
$$\text{Investor Payout} = \frac{\text{Net Distributable Pool} \times \text{Eligible Shares Owned}}{\text{Total Project Shares (100)}}$$

*Example: For a ৳ 1,50,000 land lease distribution pool, an investor owning 4 shares receives $(1,50,000 \times 4) / 100 = ৳ 6,000$.*

### 4. Atomic Share Lot Allocation
When Admin verifies an investment via `state.adminVerifyAndAllocateShare(id)`, the system:
1. Calculates sequential available lot numbers (e.g. `LOT-075`, `LOT-076`).
2. Atomically increments `allocatedShares`.
3. Creates a cryptographically signed Share Certificate PDF in `_documents`.
4. Marks the ledger transaction as `completed`.

---

## 6. How-To Customization Recipes

### Recipe A: How to Change the Brand Colors
Open `lib/core/theme/app_colors.dart` and update the primary tokens:
```dart
static const Color primary = Color(0xFF0B281E);      // Replace with your brand color
static const Color accentGold = Color(0xFFC59B27);  // Replace accent color
```

### Recipe B: How to Adjust Share Price or Max Share Limit
Open `lib/core/constants/project_seeds.dart` and modify `landVest100`:
```dart
pricePerShare: 25500.0,  // Adjust unit price
maxShares: 4,            // Change individual investor limit
```

### Recipe C: How to Add a New Deposit Bank
Open `lib/core/constants/project_seeds.dart` or `lib/features/investor/investment_flow/investment_flow_dialog.dart`:
```dart
_paymentMethodOption(
  title: 'Eastern Bank PLC',
  subtitle: 'A/C: 104-129-0039201 • Principal Branch',
  icon: Icons.account_balance_rounded,
  value: 'Eastern Bank PLC',
  isDark: isDark,
  isBangla: isBangla,
)
```

### Recipe D: How to Add a New Document to the Vault
In `lib/core/constants/project_seeds.dart`:
```dart
DocumentModel(
  id: 'doc-008',
  title: 'Environmental Clearance Certificate (ECC)',
  titleBn: 'পরিবেশ ছাড়পত্র সনদ',
  category: 'Legal',
  fileSize: '1.4 MB',
  fileType: 'PDF',
  verifiedBy: 'Department of Environment (DoE)',
  sha256Hash: '9a8b7c6d5e4f3a2b1c0d9e8f7a6b5c4d',
  publishedAt: DateTime.now(),
)
```

---

## 💻 Running & Testing Commands

```bash
# Analyze codebase (Ensure 0 issues)
flutter analyze

# Run unit & widget test suite
flutter test

# Run live on Chrome (Port 3000)
flutter run -d chrome --web-port=3000 --web-hostname=localhost

# Run on Windows Desktop
flutter run -d windows
```
