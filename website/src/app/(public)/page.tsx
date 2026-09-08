"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import ShareMatrixGrid from "@/components/project/ShareMatrixGrid";
import TransparencyLedger from "@/components/project/TransparencyLedger";
import LandVestStoryCard from "@/components/project/LandVestStoryCard";
import {
  ShieldCheck,
  Building2,
  TrendingUp,
  ArrowRight,
  CheckCircle2,
  MapPin,
  FileText,
  Users,
  Coins,
  Scale,
  Sparkles,
  Award,
  Sprout,
  Layers,
  Lock,
  Receipt,
} from "lucide-react";

export default function HomePage() {
  const { isBangla } = useAuth();

  const trustPillars = [
    {
      icon: Layers,
      title: isBangla ? "১০০ নির্দিষ্ট শেয়ার" : "Fixed 100 Unit Equity",
      desc: isBangla
        ? "প্রতিটি প্রজেক্ট কঠোরভাবে ১০০টি নির্দিষ্ট শেয়ারে সীমাবদ্ধ। অতিরিক্ত শেয়ার ইস্যুর কোনো ঝুঁকি নেই।"
        : "Strictly fixed at 100 units per project. Prevents dilution and guarantees transparent 1.0% equity per share.",
      color: "text-brand-emerald",
      bg: "bg-brand-light/60",
    },
    {
      icon: Building2,
      title: isBangla ? "সিটি ব্যাংক এসক্রো হিসাব" : "City Bank Escrow Safety",
      desc: isBangla
        ? "সকল বিনিয়োগ সুরক্ষিত দ্য সিটি ব্যাংক পিএলসি এসক্রো একাউন্টে জমা হয়। অনুমোদিত ব্যয় ছাড়া ফান্ড উত্তোলন অসম্ভব।"
        : "Direct institutional clearing through The City Bank PLC. Disbursed only against vetted project milestones.",
      color: "text-cyan-dark",
      bg: "bg-cyan-tint/60",
    },
    {
      icon: Receipt,
      title: isBangla ? "১০০% অডিটকৃত ব্যয় ভাউচার" : "100% Audited Fund Ledger",
      desc: isBangla
        ? "জমির উন্নয়ন ও প্রজেক্টের প্রতিটি খরচের ভাউচার ও রসিদ ২৪/৭ লাইভ লেজারে উন্মুক্ত থাকে।"
        : "Complete transparent real-time expense book with vendor receipts and independent audit trail.",
      color: "text-amber-600",
      bg: "bg-amber-50",
    },
    {
      icon: Scale,
      title: isBangla ? "সরাসরি প্রো-রাটা লভ্যাংশ" : "Mathematical Pro-Rata Returns",
      desc: isBangla
        ? "প্রজেক্টের যাবতীয় নিট মুনাফা গাণিতিক প্রো-রাটা সূত্রে সরাসরি আপনার ব্যাংক একাউন্টে জমা হয়।"
        : "Net commercial and agro profits are automatically calculated and distributed directly into your account.",
      color: "text-jade-dark",
      bg: "bg-jade-light/60",
    },
  ];

  return (
    <div className="space-y-16 lg:space-y-20 pb-20">
      {/* =========================================================================
          1. HERO SECTION — Ultra-Luxurious Deep Mesh Gradient
          ========================================================================= */}
      {/* =========================================================================
          1. HERO SECTION — Ultra-Luxurious Prime Asset Imagery & Ambient Mesh
          ========================================================================= */}
      <section className="relative overflow-hidden text-white pt-10 pb-12 lg:pt-14 lg:pb-16 rounded-3xl mx-2 sm:mx-4 lg:mx-8 mt-2 shadow-2xl border border-slate-800/80 min-h-[420px] lg:min-h-[480px] flex items-center">
        {/* Full Background Asset Image with Balanced Cinematic Gradient */}
        <div className="absolute inset-0 z-0 pointer-events-none">
          <img
            src="/images/hero_investment_bg.jpg"
            alt="Prime Asset and Smart Agro Development"
            className="w-full h-full object-cover object-center lg:object-[center_28%]"
          />
          {/* Subtle gradient: ensures crisp typography on the left while allowing the complete estate view to shine */}
          <div className="absolute inset-0 bg-gradient-to-r from-[#040D1A]/95 via-[#040D1A]/80 to-[#040D1A]/25 lg:to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-t from-[#040D1A]/90 via-transparent to-[#040D1A]/40" />
        </div>

        {/* Ambient Lighting Glows */}
        <div className="absolute -top-40 -right-40 w-96 h-96 bg-cyan/20 rounded-full blur-3xl pointer-events-none z-1" />
        <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-brand-emerald/25 rounded-full blur-3xl pointer-events-none z-1" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 w-full py-2">
          <div className="max-w-3xl space-y-4 lg:space-y-5 text-center lg:text-left">
            {/* Live Badge Pill */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white/10 backdrop-blur-xl border border-white/20 text-xs font-semibold text-cyan-light shadow-inner">
              <span className="w-2 h-2 rounded-full bg-emerald-400 animate-ping" />
              <Sparkles className="w-3.5 h-3.5 text-cyan" />
              <span>
                {isBangla
                  ? "ল্যান্ডভেস্ট ১০০ লাইভ • ৭৪টি শেয়ার বরাদ্দ সম্পন্ন"
                  : "LandVest 100 Live • 74 Shares Subscribed (74%)"}
              </span>
            </div>

            {/* Main Headline */}
            <h1 className="text-2xl sm:text-4xl lg:text-5xl font-black tracking-tight leading-[1.14]">
              {isBangla ? (
                <>
                  পরিকল্পিত প্রজেক্টে বিনিয়োগ। <br />
                  <span className="text-shimmer-blue">সরাসরি মুনাফা বণ্টন।</span>
                </>
              ) : (
                <>
                  Invest in High-Value Assets. <br />
                  <span className="text-shimmer-blue">Share Verified Profits.</span>
                </>
              )}
            </h1>

            {/* Sub-Headline */}
            <p className="text-xs sm:text-sm lg:text-base text-slate-300 max-w-2xl mx-auto lg:mx-0 leading-relaxed font-normal">
              {isBangla
                ? "স্বপ্নযাত্রী জমি, স্মার্ট এগ্রো এবং উচ্চ-সম্ভাবনাময় উদ্যোগে সাধারণ মানুষকে অল্প পুঁজিতে অংশ নেওয়ার আধুনিক প্ল্যাটফর্ম। কোনো প্রজেক্টের ব্যক্তিগত জটিল ঝামেলা ছাড়া সহজে ইনভেস্ট করুন এবং সরাসরি লভ্যাংশ পান।"
                : "Swapnojatri enables everyday investors to participate in vetted prime land, smart agro, and commercial businesses. No property management headaches—invest securely and earn distributed pro-rata profits."}
            </p>

            {/* Action Buttons */}
            <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-3 pt-0.5">
              <Link
                href="/projects/landvest-100"
                className="w-full sm:w-auto px-7 py-3 rounded-full btn-primary-glow text-white font-extrabold text-xs sm:text-sm flex items-center justify-center gap-2 group cursor-pointer"
              >
                <span>{isBangla ? "ল্যান্ডভেস্ট ১০০ প্রজেক্ট দেখুন" : "Explore LandVest 100"}</span>
                <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1 text-cyan-light" />
              </Link>

              <Link
                href="/projects"
                className="w-full sm:w-auto px-6 py-3 rounded-full btn-secondary-glow text-white font-bold text-xs sm:text-sm transition-all flex items-center justify-center gap-2 cursor-pointer"
              >
                <Layers className="w-4 h-4 text-cyan" />
                <span>{isBangla ? "সকল প্রজেক্ট স্পেকট্রাম" : "View All Projects"}</span>
              </Link>
            </div>

            {/* Sleek Trust & Escrow Assurance */}
            <div className="flex flex-wrap items-center justify-center lg:justify-start gap-2.5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#040D1A]/70 backdrop-blur-md border border-white/15 text-[11px] sm:text-xs text-slate-200 shadow-sm">
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-400 shrink-0" />
                <span>{isBangla ? "সিটি ব্যাংক এসক্রো অ্যাকাউন্টে ১০০% সুরক্ষিত" : "100% City Bank Escrow Protected"}</span>
              </div>
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#040D1A]/70 backdrop-blur-md border border-white/15 text-[11px] sm:text-xs text-slate-200 shadow-sm">
                <CheckCircle2 className="w-3.5 h-3.5 text-cyan shrink-0" />
                <span>{isBangla ? "মাইলস্টোন ও অডিট সাপেক্ষে তহবিল" : "Audited Milestone Disbursements"}</span>
              </div>
            </div>

            {/* Trust Metrics Ribbon — Sleek Solid Frosted Glass Bar */}
            <div className="pt-3 border-t border-white/15 max-w-2xl mx-auto lg:mx-0">
              <div className="p-2.5 sm:p-3 rounded-2xl bg-[#040D1A]/75 backdrop-blur-xl border border-white/20 shadow-xl grid grid-cols-3 divide-x divide-white/15 text-center">
                <div className="px-1.5 sm:px-3 flex flex-col items-center justify-center">
                  <span className="text-xs sm:text-base lg:text-lg font-black text-cyan font-mono whitespace-nowrap block">
                    {isBangla ? "৪টি প্রজেক্ট" : "4 Projects"}
                  </span>
                  <span className="text-[9px] sm:text-[11px] text-slate-300 font-medium whitespace-nowrap block mt-0.5">
                    {isBangla ? "ট্র্যাক রেকর্ড" : "Track Record"}
                  </span>
                </div>

                <div className="px-1.5 sm:px-3 flex flex-col items-center justify-center">
                  <span className="text-xs sm:text-base lg:text-lg font-black text-white font-mono whitespace-nowrap block">
                    {isBangla ? "১০০টি শেয়ার" : "100 Units"}
                  </span>
                  <span className="text-[9px] sm:text-[11px] text-slate-300 font-medium whitespace-nowrap block mt-0.5">
                    {isBangla ? "নির্দিষ্ট ইকুইটি" : "Fixed Equity"}
                  </span>
                </div>

                <div className="px-1.5 sm:px-3 flex flex-col items-center justify-center">
                  <span className="text-xs sm:text-base lg:text-lg font-black text-emerald-400 font-mono whitespace-nowrap block">
                    {isBangla ? "১০০% প্রদেয়" : "100% Pro-Rata"}
                  </span>
                  <span className="text-[9px] sm:text-[11px] text-slate-300 font-medium whitespace-nowrap block mt-0.5">
                    {isBangla ? "ব্যাংক লভ্যাংশ" : "Bank Payouts"}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* =========================================================================
          2. LIVE SHARE ALLOCATION & SUMMARY CARD
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ShareMatrixGrid />
      </section>

      {/* =========================================================================
          3. 4 INSTITUTIONAL TRUST PILLARS (BENTO GRID)
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
        <div className="text-center max-w-2xl mx-auto space-y-2">
          <span className="px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-brand-light text-brand-emerald">
            {isBangla ? "কেন স্বপ্নযাত্রী?" : "Core Trust Architecture"}
          </span>
          <h2 className="text-2xl sm:text-4xl font-black text-slate-900 tracking-tight">
            {isBangla ? "শতভাগ স্বচ্ছতা ও সুরক্ষার ৪টি ভিত্তি" : "Four Pillars of Transparent Crowdfunding"}
          </h2>
          <p className="text-xs sm:text-sm text-slate-500">
            {isBangla
              ? "সাধারণ বিনিয়োগকারীদের আস্থা ও সুরক্ষার জন্য তৈরি আধুনিক ফিনটেক ফ্রেমওয়ার্ক"
              : "Institutional grade fund security, audited records, and automated pro-rata profit mechanics"}
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {trustPillars.map((tp, idx) => (
            <div
              key={idx}
              className="p-6 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover hover:-translate-y-1 transition-all duration-300 space-y-4 flex flex-col justify-between"
            >
              <div className="space-y-3">
                <div className={`w-12 h-12 rounded-2xl ${tp.bg} ${tp.color} flex items-center justify-center`}>
                  <tp.icon className="w-6 h-6" />
                </div>
                <h3 className="text-base font-bold text-slate-900">{tp.title}</h3>
                <p className="text-xs text-slate-600 leading-relaxed">{tp.desc}</p>
              </div>

              <div className="pt-2 flex items-center gap-1 text-[11px] font-bold text-brand-emerald">
                <CheckCircle2 className="w-3.5 h-3.5" />
                <span>{isBangla ? "যাচাইকৃত সুবিধা" : "Verified Protocol"}</span>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* =========================================================================
          4. OFFICIAL TRACK RECORD & LANDVEST 100 STORY
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <LandVestStoryCard />
      </section>

      {/* =========================================================================
          5. LIVE FUND LEDGER & AUDITED EXPENSE VOUCHERS
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <TransparencyLedger />
      </section>

      {/* =========================================================================
          6. CALL TO ACTION RIBBON
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="p-8 sm:p-12 rounded-3xl bg-[#0A2540] hero-mesh-gradient text-white text-center sm:text-left flex flex-col sm:flex-row items-center justify-between gap-8 shadow-2xl relative overflow-hidden border border-slate-800">
          <div className="space-y-3 max-w-xl relative z-10">
            <span className="px-3.5 py-1 rounded-full text-[10px] font-mono font-bold bg-white/10 text-cyan uppercase tracking-wider border border-white/15">
              LIMITED 100 UNITS
            </span>
            <h3 className="text-2xl sm:text-3xl font-black text-white leading-tight">
              {isBangla
                ? "আজই ল্যান্ডভেস্ট ১০০-এ আপনার শেয়ার নিশ্চিত করুন"
                : "Secure Your Pro-Rata Shares in LandVest 100"}
            </h3>
            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-normal">
              {isBangla
                ? "প্রতি শেয়ার মাত্র ৳২৫,৫০০। EPS গেটওয়ে (বিকাশ/কার্ড) বা সিটি ব্যাংক এসক্রো অ্যাকাউন্টে সরাসরি জমা দিয়ে আজই বিনিয়োগ সম্পন্ন করুন।"
                : "Starting at ৳25,500 per share. Instant payment via EPS Gateway or direct City Bank Escrow deposit."}
            </p>
          </div>

          <div className="flex flex-col sm:flex-row gap-3 w-full sm:w-auto relative z-10 shrink-0">
            <Link
              href="/projects/landvest-100"
              className="px-8 py-4 rounded-full bg-brand-emerald hover:bg-brand-forest text-white font-extrabold text-sm text-center shadow-lg shadow-brand-emerald/30 transition-all flex items-center justify-center gap-2 group"
            >
              <span>{isBangla ? "অনলাইনে শেয়ার বুক করুন" : "Invest Now"}</span>
              <ArrowRight className="w-4 h-4 text-cyan-light transition-transform group-hover:translate-x-1" />
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
