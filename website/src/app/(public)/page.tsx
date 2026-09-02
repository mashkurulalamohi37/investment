"use client";

import React from "react";
import Link from "next/link";
import { formatBDT, formatCompactBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import InvestmentCalculator from "@/components/project/InvestmentCalculator";
import ShareMatrixGrid from "@/components/project/ShareMatrixGrid";
import TransparencyLedger from "@/components/project/TransparencyLedger";
import {
  ShieldCheck,
  Building2,
  TrendingUp,
  FileCheck2,
  ArrowRight,
  CheckCircle2,
  MapPin,
  FileText,
  Users,
  Coins,
  Scale,
  Sparkles,
  Award,
} from "lucide-react";

export default function HomePage() {
  const { isBangla } = useAuth();

  return (
    <div className="space-y-20 pb-20">
      {/* 1. HERO SECTION */}
      <section className="relative overflow-hidden bg-gradient-emerald text-white pt-16 pb-24 lg:pt-24 lg:pb-32">
        {/* Background Atmospheric Accents */}
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(197,155,39,0.15),transparent_50%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_bottom_left,rgba(16,185,129,0.12),transparent_50%)]" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-8 items-center">
            {/* Left Content */}
            <div className="lg:col-span-7 space-y-6 text-center lg:text-left">
              {/* Trust Badge */}
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/15 text-xs font-semibold text-gold-light">
                <ShieldCheck className="w-4 h-4 text-gold" />
                <span>
                  {isBangla
                    ? "আইনি দলিল ও সিটি ব্যাংক এসক্রো সুরক্ষিত ক্রাউডফান্ডিং"
                    : "100% Asset-Backed Land & Agro Crowdfunding in Bangladesh"}
                </span>
              </div>

              {/* Main Headline */}
              <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black tracking-tight leading-[1.15]">
                {isBangla ? (
                  <>
                    জমিতে নিরাপদ বিনিয়োগ। <br />
                    <span className="text-gold-gradient">গড়ুন স্থায়ী ভবিষ্যৎ।</span>
                  </>
                ) : (
                  <>
                    Invest in Verified Land. <br />
                    <span className="text-gold-gradient">Build Generational Wealth.</span>
                  </>
                )}
              </h1>

              {/* Sub-headline description */}
              <p className="text-base sm:text-lg text-slate-300 max-w-2xl mx-auto lg:mx-0 leading-relaxed font-normal">
                {isBangla
                  ? "সাভারের বাণিজ্যিক জমিতে মাত্র ২৫,৫০০ টাকায় ১০০টি নির্দিষ্ট শেয়ারে বিনিয়োগ করুন। সাব-রেজিস্ট্রি দলিল #৪৯৮২/২০২৬, লাইভ ফান্ড অডিট এবং ডিজিটাল শেয়ার বরাদ্দ সনদ।"
                  : "Co-own premium freehold land in Savar with transparent 100 fixed shares at ৳25,500/share. Verified title deeds, City Bank escrow clearing, and pro-rata dividend distribution."}
              </p>

              {/* Hero Action Buttons */}
              <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4 pt-2">
                <Link
                  href="/projects/landvest-100"
                  className="w-full sm:w-auto px-8 py-4 rounded-xl bg-gradient-gold text-slate-950 font-bold text-base hover:opacity-95 shadow-goldGlow flex items-center justify-center gap-2 transition-all"
                >
                  <span>{isBangla ? "ল্যান্ডভেস্ট ১০০ প্রকল্প দেখুন" : "Explore LandVest 100 (LV100)"}</span>
                  <ArrowRight className="w-5 h-5 text-slate-950" />
                </Link>

                <Link
                  href="/how-it-works"
                  className="w-full sm:w-auto px-6 py-4 rounded-xl bg-white/10 hover:bg-white/15 border border-white/20 text-white font-semibold text-base transition-all flex items-center justify-center gap-2"
                >
                  <FileText className="w-4 h-4 text-slate-300" />
                  <span>{isBangla ? "কার্যপদ্ধতি জানুন" : "How It Works"}</span>
                </Link>
              </div>

              {/* Quick Hero Statistics Bar */}
              <div className="grid grid-cols-3 gap-4 pt-8 border-t border-white/10 max-w-xl mx-auto lg:mx-0">
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-gold font-mono">
                    {isBangla ? "৭৪%" : "74%"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "শেয়ার বরাদ্দ সম্পন্ন" : "Target Funded"}
                  </span>
                </div>
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-white font-mono">
                    {isBangla ? "৳ ২৫.৫ লাখ" : "৳ 25.5L"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "টার্গেট ফান্ড" : "Target Fund"}
                  </span>
                </div>
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-jade font-mono">
                    {isBangla ? "১৮.৫-২২%" : "18.5-22%"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "প্রত্যাশিত বার্ষিক ROI" : "Projected ROI"}
                  </span>
                </div>
              </div>
            </div>

            {/* Right Interactive Calculator Widget */}
            <div className="lg:col-span-5 text-slate-900">
              <InvestmentCalculator />
            </div>
          </div>
        </div>
      </section>

      {/* 2. FLAGSHIP PROJECT BANNER (LANDVEST 100) */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="bg-white rounded-3xl border border-slate-200 shadow-cardHover overflow-hidden p-6 sm:p-10">
          <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-8 pb-8 border-b border-slate-100">
            <div className="space-y-3">
              <div className="flex items-center gap-2.5">
                <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
                  {isBangla ? "ফ্ল্যাগশিপ প্রকল্প" : "Flagship Opportunity"}
                </span>
                <span className="px-3 py-1 rounded-full text-xs font-mono font-bold bg-gold/15 text-gold-dark">
                  LV100 • OPEN
                </span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-black text-slate-900">
                {isBangla ? "ল্যান্ডভেস্ট ১০০ — সাভার ওয়াশপুর কমার্শিয়াল প্লট" : "LandVest 100 (LV100) — Savar Commercial Plot"}
              </h2>
              <p className="text-sm text-slate-600 max-w-3xl flex items-center gap-2">
                <MapPin className="w-4 h-4 text-brand-forest shrink-0" />
                <span>Washpur Tower Road, Hemayetpur, Savar, Dhaka (Mouza Plot 418, 22.5 Decimals)</span>
              </p>
            </div>

            <Link
              href="/projects/landvest-100"
              className="px-6 py-3.5 rounded-xl bg-brand-forest text-white text-sm font-bold hover:bg-brand-primary transition-all shrink-0 flex items-center justify-center gap-2 shadow-sm"
            >
              <span>{isBangla ? "সম্পূর্ণ প্রজেক্ট পেজ দেখুন" : "View Full Project Details"}</span>
              <ArrowRight className="w-4 h-4 text-gold" />
            </Link>
          </div>

          {/* Key Metrics Grid */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-6 pt-8">
            <div className="p-4 rounded-xl bg-canvas-light border border-slate-200">
              <span className="text-xs text-slate-500 block mb-1">
                {isBangla ? "প্রতি শেয়ার মূল্য:" : "Price Per Share:"}
              </span>
              <span className="text-xl font-bold text-slate-900 font-mono">
                {formatBDT(25500, { isBangla })}
              </span>
              <span className="text-[11px] text-slate-500 block mt-1">
                {isBangla ? "১-৪টি শেয়ার সীমা" : "Limit 1 to 4 shares"}
              </span>
            </div>

            <div className="p-4 rounded-xl bg-canvas-light border border-slate-200">
              <span className="text-xs text-slate-500 block mb-1">
                {isBangla ? "মোট শেয়ার সংখ্যা:" : "Total Project Shares:"}
              </span>
              <span className="text-xl font-bold text-slate-900 font-mono">
                {isBangla ? "১০০টি শেয়ার" : "100 Fixed Shares"}
              </span>
              <span className="text-[11px] text-brand-forest font-semibold block mt-1">
                {isBangla ? "৭৪টি শেয়ার বুকড" : "74 Shares Allocated"}
              </span>
            </div>

            <div className="p-4 rounded-xl bg-canvas-light border border-slate-200">
              <span className="text-xs text-slate-500 block mb-1">
                {isBangla ? "টার্গেট ফান্ডিং:" : "Target Fund Pool:"}
              </span>
              <span className="text-xl font-bold text-slate-900 font-mono">
                {formatBDT(2550000, { isBangla })}
              </span>
              <span className="text-[11px] text-jade-dark font-semibold block mt-1">
                {isBangla ? "৳ ১৮.৮৭ লাখ সংগৃহীত" : "৳ 18.87L Raised"}
              </span>
            </div>

            <div className="p-4 rounded-xl bg-canvas-light border border-slate-200">
              <span className="text-xs text-slate-500 block mb-1">
                {isBangla ? "নিবন্ধিত মূল দলিল:" : "Registered Title Deed:"}
              </span>
              <span className="text-xl font-bold text-slate-900 font-mono">
                #4982/2026
              </span>
              <span className="text-[11px] text-slate-500 block mt-1">
                {isBangla ? "সাভার সাব-রেজিস্ট্রি" : "Savar Sub-Registry"}
              </span>
            </div>
          </div>
        </div>
      </section>

      {/* 3. 10x10 SHARE MATRIX MAP */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ShareMatrixGrid />
      </section>

      {/* 4. TRANSPARENCY & FUND UTILIZATION LEDGER */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <TransparencyLedger />
      </section>

      {/* 5. 9-STEP HOW IT WORKS JOURNEY */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div className="text-center max-w-3xl mx-auto mb-14 space-y-3">
          <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
            {isBangla ? "সহজ ৯ ধাপ" : "Simple 9-Step Process"}
          </span>
          <h2 className="text-3xl sm:text-4xl font-black text-slate-900">
            {isBangla ? "কীভাবে স্বপ্নযাত্রীতে বিনিয়োগ করবেন?" : "How Swapnojatri Platform Works"}
          </h2>
          <p className="text-sm text-slate-600">
            {isBangla
              ? "অ্যাকাউন্ট খোলা থেকে শুরু করে ডিজিটাল শেয়ার সনদ প্রাপ্তি ও লভ্যাংশ সংগ্রহের সম্পূর্ণ স্বচ্ছ ধাপসমূহ"
              : "End-to-end transparent investment process from registration to lot allocation and dividend payout"}
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {[
            {
              step: "01",
              title: isBangla ? "অ্যাকাউন্ট তৈরি ও মোবাইল OTP" : "Create Account & Phone OTP",
              desc: isBangla
                ? "আপনার বাংলাদেশি মোবাইল নম্বর দিয়ে সেকেন্ডের মধ্যে অ্যাকাউন্ট খুলুন।"
                : "Register with your Bangladesh mobile number and instant SMS OTP.",
              icon: Users,
            },
            {
              step: "02",
              title: isBangla ? "স্মার্ট NID ও নমিনি কেওয়াইসি" : "Smart NID & Nominee KYC",
              desc: isBangla
                ? "স্মার্ট জাতীয় পরিচয়পত্র ও ব্যাংক অ্যাকাউন্ট তথ্য দিয়ে সম্মতি সম্পন্ন করুন।"
                : "Verify your legal identity and assign nominee dividend rights.",
              icon: ShieldCheck,
            },
            {
              step: "03",
              title: isBangla ? "শেয়ার সংখ্যা নির্বাচন (১-৪টি)" : "Select Shares (1 to 4 Limit)",
              desc: isBangla
                ? "ল্যান্ডভেস্ট ১০০ প্রকল্পে আপনার সামর্থ্য অনুযায়ী ১ থেকে ৪টি শেয়ার পছন্দ করুন।"
                : "Choose 1 to 4 shares in LandVest 100 with authoritative price preview.",
              icon: Coins,
            },
            {
              step: "04",
              title: isBangla ? "পেমেন্ট পদ্ধতি নির্বাচন" : "Select Payment Gateway / Bank",
              desc: isBangla
                ? "EPS অনলাইন পেমেন্ট (বিকাশ/নগদ/কার্ড) অথবা সরাসরি সিটি ব্যাংক ডিপোজিট।"
                : "Pay instantly via EPS Gateway (bKash/Nagad/Cards) or direct Bank Deposit.",
              icon: Building2,
            },
            {
              step: "05",
              title: isBangla ? "তাৎক্ষণিক যাচাই ও লট বরাদ্দ" : "Sequential Lot Allocation",
              desc: isBangla
                ? "সিস্টেম স্বয়ংক্রিয়ভাবে সিকোয়েনশিয়াল LOT-XXX বরাদ্দ করবে।"
                : "Backend atomically issues sequential LOT-001 to LOT-100 share numbers.",
              icon: Award,
            },
            {
              step: "06",
              title: isBangla ? "ডিজিটাল শেয়ার সনদপত্র" : "Digital Share Certificate",
              desc: isBangla
                ? "SHA-256 হ্যাশযুক্ত অফিসিয়াল ডিজিটাল শেয়ার সার্টিফিকেট ডাউনলোড করুন।"
                : "Download cryptographic PDF share certificates from your Document Vault.",
              icon: FileCheck2,
            },
            {
              step: "07",
              title: isBangla ? "লাইভ ফান্ড অডিট ট্র্যাকিং" : "Track Live Fund Utilization",
              desc: isBangla
                ? "জমির উন্নয়ন ও প্রজেক্ট ব্যয়ের প্রতিটি অনুমোদিত ভাউচার লাইভ দেখুন।"
                : "Monitor approved expense vouchers and escrow balance transparently.",
              icon: TrendingUp,
            },
            {
              step: "08",
              title: isBangla ? "প্রো-রাটা লভ্যাংশ বণ্টন" : "Pro-Rata Profit Distribution",
              desc: isBangla
                ? "বাণিজ্যিক ও কৃষি প্রজেক্ট থেকে অর্জিত মুনাফা শেয়ার অনুযায়ী সরাসরি অ্যাকাউন্টে।"
                : "Receive mathematical pro-rata dividend payouts directly to your bank account.",
              icon: Scale,
            },
            {
              step: "09",
              title: isBangla ? "রিপোর্ট ও স্টেটমেন্ট ডাউনলোড" : "Audited Financial Reports",
              desc: isBangla
                ? "আয়কর ও ব্যক্তিগত অডিটের জন্য অফিসিয়াল ইনভেস্টমেন্ট স্টেটমেন্ট পান।"
                : "Export PDF financial statements and tax certificates anytime.",
              icon: FileText,
            },
          ].map((item) => (
            <div
              key={item.step}
              className="p-6 rounded-2xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-4"
            >
              <div className="flex items-center justify-between">
                <span className="font-mono text-2xl font-black text-brand-forest/30">{item.step}</span>
                <div className="w-10 h-10 rounded-xl bg-brand-light text-brand-forest flex items-center justify-center">
                  <item.icon className="w-5 h-5" />
                </div>
              </div>
              <h3 className="text-lg font-bold text-slate-900">{item.title}</h3>
              <p className="text-xs text-slate-600 leading-relaxed">{item.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* 6. CALL TO ACTION BANNER */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="rounded-3xl bg-gradient-emerald text-white p-8 sm:p-14 relative overflow-hidden text-center space-y-6 shadow-2xl shadow-brand-forest/30">
          <div className="max-w-2xl mx-auto space-y-4">
            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-gold/20 text-gold-light border border-gold/30">
              {isBangla ? "সীমিত ২৬টি শেয়ার অবশিষ্ট" : "Only 26 Shares Remaining"}
            </span>
            <h2 className="text-3xl sm:text-4xl font-black text-white">
              {isBangla ? "আজই ল্যান্ডভেস্ট ১০০-এ আপনার অংশীদারিত্ব নিশ্চিত করুন" : "Secure Your Land Ownership in LandVest 100"}
            </h2>
            <p className="text-sm text-slate-300">
              {isBangla
                ? "নিবন্ধিত দলিল ও সিটি ব্যাংক এসক্রো অ্যাকাউন্টের মাধ্যমে আপনার পুঁজির শতভাগ নিরাপত্তা।"
                : "Transparent asset-backed co-ownership with verified deeds and City Bank escrow security."}
            </p>
          </div>

          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-2">
            <Link
              href="/register"
              className="w-full sm:w-auto px-8 py-4 rounded-xl bg-gradient-gold text-slate-950 font-bold text-base hover:opacity-95 shadow-goldGlow transition-all"
            >
              {isBangla ? "বিনিয়োগকারী হিসেবে যুক্ত হোন" : "Create Investor Account"}
            </Link>
            <Link
              href="/projects/landvest-100"
              className="w-full sm:w-auto px-8 py-4 rounded-xl bg-white/10 hover:bg-white/15 border border-white/20 text-white font-semibold text-base transition-all"
            >
              {isBangla ? "প্রকল্পের দলিলপত্র দেখুন" : "View Title Deeds & Documents"}
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
