# Swapnojatri Platform: Full System Architecture & Features Specification

**Platform Name**: Swapnojatri Investment Platform (স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম)  
**Primary Focus**: Asset-Backed, Transparent Real Estate & Agro Land Crowdfunding  
**Flagship Opportunity**: LandVest 100 (LV100) & Purbachal Highway Projects  
**Version**: 1.0.0 (Production Architecture)  
**Target Environments**: Mobile (Android & iOS), Web (Responsive Progressive Web Application), Desktop (Windows)

---

## 📑 Table of Contents
1. [Executive Summary & Core Philosophy](#1-executive-summary--core-philosophy)
2. [High-Level System Architecture](#2-high-level-system-architecture)
3. [Technology Stack & Dependencies](#3-technology-stack--dependencies)
4. [Investor Mobile & Web Experience](#4-investor-mobile--web-experience)
   - [4.1 Onboarding, Auth & KYC Compliance](#41-onboarding-auth--kyc-compliance)
   - [4.2 Investor Dashboard & Portfolio Tracking](#42-investor-dashboard--portfolio-tracking)
   - [4.3 Project Discovery & 10x10 Lot Matrix](#43-project-discovery--10x10-lot-matrix)
   - [4.4 Dual-Mode Investment & Checkout Engine](#44-dual-mode-investment--checkout-engine)
   - [4.5 Financial Transparency & Audited Ledger](#45-financial-transparency--audited-ledger)
   - [4.6 Pro-Rata Profit Distribution & Dividend History](#46-pro-rata-profit-distribution--dividend-history)
   - [4.7 Cryptographic Document Vault & Share Certificates](#47-cryptographic-document-vault--share-certificates)
5. [Institutional Admin Console & Operations](#5-institutional-admin-console--operations)
   - [5.1 Executive KPI Dashboard](#51-executive-kpi-dashboard)
   - [5.2 Payment Verification & Deposit Receipt Inspector](#52-payment-verification--deposit-receipt-inspector)
   - [5.3 Project Lifecycle & Milestone Management](#53-project-lifecycle--milestone-management)
   - [5.4 Investor & User Management](#54-investor--user-management)
   - [5.5 Financial Reporting & Immutable Audit Trail](#55-financial-reporting--immutable-audit-trail)
   - [5.6 Support & In-App Customer Chat](#56-support--in-app-customer-chat)
6. [Data Models & State Management](#6-data-models--state-management)
7. [Payment Gateways & Banking Integrations](#7-payment-gateways--banking-integrations)
8. [Design System, Typography & UI Tokens](#8-design-system-typography--ui-tokens)
9. [Security, Integrity & Compliance Matrix](#9-security-integrity--compliance-matrix)

---

## 1. Executive Summary & Core Philosophy

**Swapnojatri (স্বপ্নযাত্রী)** is an institutional-grade, shariah-compliant fintech platform created to democratize access to high-growth real estate and agricultural land assets across Bangladesh.

### Core Pillars
* **Asset-Backed Security**: Every share represents a legally vetted, sub-registered land parcel with verifiable mouza, khatian, and dag numbers.
* **100% Fund Transparency**: Real-time financial ledgers allow investors to track every single taka collected, spent on land registration or development, and distributed as profit.
* **Dual-Language Native Experience**: Full native Bengali (বাংলা) interface alongside English, formatted with authentic South Asian numbering conventions (`৳ ২৫,৫০,০০০` / `৳ 25,50,000`).
* **Zero Speculation / Clear Disclosures**: Transparent risk and return modeling without unrealistic guaranteed fixed interest claims.

---

## 2. High-Level System Architecture

The application is architected around a unified **Single Source of Truth (SSOT)** utilizing Flutter's reactive `ChangeNotifier` design pattern, cleanly decoupling business logic, state persistence, and presentation layers.

```mermaid
graph TD
    UI[Flutter UI Layer - Mobile, Web & Desktop] --> AppState[Central Reactive AppState]
    
    subgraph Investor Persona
        HomeScreen[Dashboard & Portfolio]
        ProjectDetail[Project Detail & 10x10 Matrix]
        EPSCheckout[EPS Gateway Sheet]
        BankUpload[Bank Slip Upload Sheet]
        Vault[Document Vault & Certificates]
        ProfitDist[Profit Distributions]
    end

    subgraph Admin Persona
        AdminDash[Admin Dashboard]
        PaymentQueue[Payment & Slip Verification Queue]
        ProjectMgmt[Project Creation & Milestones]
        UserMgmt[User & KYC Management]
        AuditLogs[Immutable Audit Logs]
    end

    subgraph Core Services & Integration
        EPSService[EPS Payment Gateway Service]
        DocRegistry[Automated Certificate Generator]
        LedgerService[Financial Ledger & Vouchers]
    end

    UI --> Investor Persona
    UI --> Admin Persona
    AppState --> Core Services & Integration
```

---

## 3. Technology Stack & Dependencies

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Framework** | **Flutter 3.x (Material 3)** | Cross-platform runtime for Web, Android, iOS, Windows |
| **Language** | **Dart 3.x** | Null-safe, compiled language with asynchronous streams |
| **State Management** | **`AppState` (`ChangeNotifier`)** | Reactive central store with atomic state mutations |
| **Data Visualization** | **`fl_chart: ^0.69.0`** | Interactive investment growth charts and expense pie charts |
| **Micro-Animations** | **`flutter_animate: ^4.5.0`** | Staggered entrance, shimmer effects, and haptic feedback |
| **Typography** | **`google_fonts: ^6.2.1`** | `Outfit` (Numerals & Headings), `Hind Siliguri` (Bangla Typography), `Inter` |
| **Formatting** | **`intl: ^0.19.0`** | Date localization and South Asian Lakh/Crore numbering |
| **Payment Protocol** | **EPS (Easy Payment System)** | Bangladesh Bank licensed Payment System Operator (PSO) API |

---

## 4. Investor Mobile & Web Experience

### 4.1 Onboarding, Auth & KYC Compliance
* **Branded Splash & Welcome**: High-aesthetic intro showcasing company mission, project highlights, and regulatory seals.
* **Phone & OTP Authentication**: Quick sign-in with automatic 6-digit OTP verification simulation.
* **Tiered KYC Verification**:
  * Smart NID front & back scan verification.
  * Facial biometric liveness score indicator.
  * 100% Nominee registration (Name, Relationship, NID).
  * Settlement Bank details (Bank Name, Account Number, Branch, Routing).

### 4.2 Investor Dashboard & Portfolio Tracking
* **Live Portfolio Valuation**: Total capital invested, active share count, and total return payouts.
* **Active Holdings Cards**: Displays owned lot numbers (e.g. `LOT-041`, `LOT-042`), investment date, and digital certificate access.
* **Sequential Lot Timeline**: Visual progression tracking land acquisition, demarcation, boundary wall, sub-registry, and handover.

### 4.3 Project Discovery & 10x10 Lot Matrix
* **10x10 Interactive Visual Share Matrix (`ShareGridMatrixWidget`)**:
  * 100 interactive lot boxes.
  * **Emerald Green**: Allocated lots owned by the community.
  * **Glowing Gold**: Lots owned by the currently logged-in investor.
  * **Sunken Gray / Blue Border**: Available lots open for investment.
  * Tapping any lot displays real-time metadata (Lot ID, status, share price).
* **Interactive Dynamic Calculator**:
  * Stepper (+ / -) and fluid slider.
  * Real-time calculation of total investment amount, estimated annual ROI (18.5% - 22.0%), and project equity percentage.
* **7 Comprehensive Project Tabs**:
  1. **Overview (বিবরণ)**: Project summary, location, highlights, key financials.
  2. **Land & Plot Specs (জমির বিবরণ)**: Mouza plot, GPS coordinates, road width, land elevation.
  3. **Fund Allocation (তহবিল ব্যবহার)**: Real-time visual pie chart of land price, registration, and development.
  4. **Legal & Vetting (আইনি বৈধতা)**: Title deed status, AC Land mutation status, legal vetting report.
  5. **Timeline & Milestones (টাইমলাইন)**: Chronological project roadmap with completion stamps.
  6. **Live Updates (আপডেট)**: On-site photo reports, drone shots, and construction progress.
  7. **Risk & Disclosures (ঝুঁকি বিশ্লেষণ)**: Regulatory disclaimers and risk mitigations.

### 4.4 Dual-Mode Investment & Checkout Engine

The platform supports two distinct, robust payment pathways:

#### Mode 1: EPS (Easy Payment System) Gateway (Instant Online Settlement)
* **Official PSO Integration**: Built specifically for the user's purchased EPS Payment Gateway.
* **Multi-Channel Options**:
  * **Mobile Wallets (MFS)**: bKash (বিকাশ), Nagad (নগদ), DBBL Rocket (রকেট).
  * **Debit/Credit Cards**: Visa, Mastercard, DBBL Nexus Pay.
  * **Internet Banking**: City Touch, BRAC Bank Astha, Islami Bank Cellfin.
* **Instant Automation**: Once payment is authorized, the system instantly assigns sequential lot numbers, credits the ledger, generates the digitally signed share certificate, and sends notification alerts.

#### Mode 2: Manual Bank Transfer & Receipt Upload
* **Company Bank Account Display**:
  * Bank Name: City Bank PLC (The City Bank Ltd)
  * Account Name: `SWAPNOJATRI AGRO & LAND PROJECTS LTD`
  * Account Number: `1402-9988-7710-1` (One-tap copy)
  * Routing Number: `225275357` (One-tap copy)
  * Branch: Gulshan Corporate Branch, Dhaka
* **Deposit Slip / Receipt Photo Attachment**:
  * Camera capture or gallery upload preview.
  * Captures depositor name, bank name, branch, and slip/transaction reference.
  * Submits to the Admin Payment Verification Queue with status `Pending Review`.

### 4.5 Financial Transparency & Audited Ledger
* **Live Project Balance Sheet**:
  * Total Target Fund: `৳ 25,50,000`
  * Total Collected: `৳ 18,87,000`
  * Total Utilized: `৳ 20,50,000`
  * Remaining Balance: `৳ 5,00,000`
* **Audited Expense Voucher Book**:
  * Every transaction includes receipt photo, bill reference, payee details, and auditor digital stamp.

### 4.6 Pro-Rata Profit Distribution & Dividend History
* **Pro-Rata Dividend Algorithm**:
  $$\text{Investor Payout} = \frac{\text{Net Distributable Profit} \times \text{Shares Owned}}{\text{Total Project Shares (100)}}$$
* Payout records with transfer method (NPSB / BEFTN / bKash), transaction reference, and tax deduction certificates.

### 4.7 Cryptographic Document Vault & Share Certificates
* **Document Vault with SHA-256 Hashes**:
  * Sub-Registry Title Deed (`#4982/2026`).
  * Legal Vetting Report by Senior Supreme Court Advocate.
  * AC Land Mutation & DCR Khatian.
  * Environmental & Soil Viability Audit.
* **Digital Share Certificate Widget (`ShareCertificateWidget`)**:
  * Official seal with serial number (`CERT-LV100-0042`).
  * Investor name, NID, allocated lot numbers, QR verification frame.

---

## 5. Institutional Admin Console & Operations

### 5.1 Executive KPI Dashboard
* **Metrics 2x2 Grid**: Total Active Projects, Registered Users, Total Funds Raised (`৳ 2.45 Cr`), Net Profit Distributed (`৳ 18.75 L`).
* **Real-time Trend Charts**: Financial inflow vs. month-by-month projection.
* **Direct Alert Banner**: Real-time notification badge when investors submit bank deposit slips.

### 5.2 Payment Verification & Deposit Receipt Inspector
* **Queue Filtering**: Segregated views for *Pending Review*, *Approved*, and *All Transactions*.
* **Receipt Inspector Modal**:
  * High-resolution bank slip viewer with verification frame.
  * Automated cross-check of Depositor Name, Project Name, Slip No, and Amount.
  * **One-Tap Actions**:
    * **"Approve & Allocate Lots"**: Atomically updates project shares, assigns sequential lot numbers, completes transaction ledger, generates share certificate, and alerts the investor.
    * **"Reject"**: Marks transaction as failed and notifies investor with reason.

### 5.3 Project Lifecycle & Milestone Management
* **Create New Project Wizard (`AddProjectScreen`)**: Set target fund, share price, min/max shares, project category (Commercial, Agricultural, Residential), and location.
* **Milestone Tracking**: Update milestone completion states with date stamps and photos.

### 5.4 Investor & User Management
* **Investor Registry**: Search, filter by KYC verification status, view total shares held across projects.
* **Account Controls**: Review submitted KYC documents, approve verification status, lock/unlock accounts.

### 5.5 Financial Reporting & Immutable Audit Trail
* **Expense Manager**: Log operational expenses (land registry fee, site fencing, survey) with real-time project fund balance deduction.
* **Immutable Audit Trail (`AuditLogsScreen`)**: Append-only log tracking Actor Name, Role (Admin/Investor), Action Code (e.g. `ALLOCATE_SHARES`, `EPS_GATEWAY_PAYMENT`), Entity ID, IP Address, and Timestamp.
* **One-Click Export Reports**: Export Payment Reconciliation, Share Registry, and Tax statements to CSV / PDF.

### 5.6 Support & In-App Customer Chat
* **Live Chat (`AdminChatScreen`)**: Direct investor-to-admin support chat.
* **Help Center & FAQ**: Comprehensive pre-loaded answers to investor queries, helpline phone numbers, and official office address.

---

## 6. Data Models & State Management

| Model | Key Fields | Description |
| :--- | :--- | :--- |
| **`ProjectModel`** | `id`, `name`, `nameBn`, `targetFund`, `totalShares`, `allocatedShares`, `pricePerShare`, `minShares`, `maxShares`, `status`, `milestones`, `trackRecords` | Represents an asset-backed crowdfunding land opportunity |
| **`InvestmentModel`** | `id`, `investmentNo`, `userId`, `projectId`, `shares`, `unitPrice`, `grossAmount`, `status`, `allocatedLotNumbers`, `paymentMethod`, `paymentReference`, `receiptImageUrl`, `depositBankName`, `depositorName`, `paymentGateway` | Core investment contract binding investor to project lot shares |
| **`TransactionModel`** | `id`, `investmentId`, `projectId`, `type`, `direction`, `amount`, `reference`, `paymentMethod`, `receiptImageUrl`, `depositBankName`, `depositorName`, `status`, `createdAt` | Double-entry transaction ledger entry |
| **`ExpenseModel`** | `id`, `voucherNo`, `projectId`, `category`, `amount`, `payeeName`, `status`, `receiptUrl`, `auditedBy` | Audited project expenditure voucher |
| **`DistributionModel`** | `id`, `projectId`, `periodTitle`, `totalPool`, `amountPerShare`, `payoutAmount`, `status`, `paymentReference` | Pro-rata dividend payout record |
| **`DocumentModel`** | `id`, `projectId`, `title`, `titleBn`, `category`, `fileName`, `fileSize`, `version`, `checksumSha256` | Legal vault document with SHA-256 checksum |
| **`KycModel`** | `id`, `userId`, `fullName`, `nidNumber`, `fatherName`, `motherName`, `presentAddress`, `bankName`, `bankAccountNumber`, `routingNumber`, `nominee`, `status` | Regulatory compliance and KYC profile |
| **`AuditLogModel`** | `id`, `actorName`, `actorRole`, `action`, `actionBn`, `entityType`, `entityId`, `details`, `ipAddress`, `timestamp` | Append-only institutional audit trail |

---

## 7. Payment Gateways & Banking Integrations

```
                                  [Investor Checkout]
                                           |
                   +-----------------------+-----------------------+
                   |                                               |
         [Mode 1: EPS Gateway]                         [Mode 2: Bank Deposit]
                   |                                               |
     +-------------+-------------+                  +--------------+--------------+
     |             |             |                  |                             |
[MFS Wallets]   [Cards]   [Net Banking]       [City Bank PLC]              [BRAC / IBBL]
 bKash/Nagad   Visa/Master  City Touch        A/C: 1402-9988-7710-1        Deposit Counter
     |             |             |                  |                             |
     +-------------+-------------+                  +--------------+--------------+
                   |                                               |
          [EPS IPN Callback]                           [Attach Deposit Slip Photo]
                   |                                               |
     [Instant Share Allocation]                       [Admin Verification Queue]
     [Auto Certificate Generated]                                  |
                                                      [Admin Reviews & Approves]
                                                                   |
                                                      [Shares & Lots Allocated]
```

---

## 8. Design System, Typography & UI Tokens

### Color Palette Architecture
* **Primary Canvas & Surface**: Pure White (`#FFFFFF`) in Light Mode, Slate Charcoal (`#12161A`) in Dark Mode.
* **Brand Primary & Accent**: Royal Sapphire (`#0066FF`), Emerald Forest (`#0D3B2E`), Vibrant Cyan (`#00B4D8`).
* **Semantic Status Colors**:
  * **Success & Verified**: Emerald Jade (`#00C853` / `#10B981`)
  * **Pending & Processing**: Vivid Amber (`#FF9800`)
  * **Institutional Purple**: Royal Indigo (`#7B1FA2`)
  * **Error & Rejected**: Crimson Rose (`#EF4444`)

### Typography Hierarchy
* **English Numerals & Financials**: `GoogleFonts.poppins` and `GoogleFonts.outfit` for crisp geometric numeral legibility.
* **Bengali Script**: `GoogleFonts.hindSiliguri` with tailored line heights for authentic Bengali calligraphy and Matra alignments.

---

## 9. Security, Integrity & Compliance Matrix

1. **Sequential Non-Overlapping Lot Numbers**:
   - Every share purchase calculates `LOT-XXX` sequentially based on current project allocation, preventing race conditions or duplicate assignments.
2. **Cryptographic Integrity**:
   - Legal documents and Share Certificates are hashed with standard SHA-256 digests.
3. **Double Verification Safeguard**:
   - Manual bank payments require physical slip uploads and explicit admin approval before any equity or lot numbers are reserved.
4. **Append-Only Audit Logging**:
   - Every critical transaction, payment submission, admin approval, and KYC review generates a timestamped, IP-stamped audit log.

---

*Documentation maintained by Swapnojatri Engineering & Product Architecture Team.*
