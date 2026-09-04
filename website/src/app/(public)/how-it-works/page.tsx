"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Users,
  ShieldCheck,
  Coins,
  Building2,
  Award,
  FileCheck2,
  TrendingUp,
  Scale,
  FileText,
  ArrowRight,
  CheckCircle2,
  Sparkles,
  Layers,
  Landmark,
} from "lucide-react";

export default function HowItWorksPage() {
  const { isBangla } = useAuth();

  const phases = [
    {
      phaseNum: "01",
      phaseTitle: isBangla ? "পরিচিতি ও নিরাপদ নিবন্ধন" : "Investor Onboarding & KYC",
      steps: [
        {
          num: "১",
          title: isBangla ? "মোবাইল OTP ভেরিফিকেশন" : "Mobile OTP Verification",
          desc: isBangla
            ? "বাংলাদেশি মোবাইল নম্বরে তাৎক্ষণিক SMS কোডের মাধ্যমে এনক্রিপ্টেড অ্যাকাউন্ট সক্রিয় করুন।"
            : "Quick instant SMS OTP verification secures your account identity.",
          icon: Users,
        },
        {
          num: "২",
          title: isBangla ? "স্মার্ট এনআইডি ও নমিনি কেওয়াইসি" : "Smart NID & Nominee KYC",
          desc: isBangla
            ? "আইনি নিরাপত্তা ও উত্তরাধিকার সংরক্ষণে আপনার জাতীয় পরিচয়পত্র ও নমিনির তথ্য জমা দিন।"
            : "Submit legal Smart NID details and designate nominee for fiduciary safety.",
          icon: ShieldCheck,
        },
      ],
    },
    {
      phaseNum: "02",
      phaseTitle: isBangla ? "শেয়ার নির্বাচন ও এসক্রো পেমেন্ট" : "Share Booking & Escrow",
      steps: [
        {
          num: "৩",
          title: isBangla ? "শেয়ার সংখ্যা নির্বাচন (১-৪টি)" : "Share Selection (1 to 4 Units)",
          desc: isBangla
            ? "ল্যান্ডভেস্ট ১০০ প্রকল্পে ১ থেকে ৪টি শেয়ার নির্বাচন করুন (প্রতি শেয়ার মাত্র ৳২৫,৫০০)।"
            : "Select 1 to 4 fixed share units with transparent pro-rata equity calculation.",
          icon: Coins,
        },
        {
          num: "৪",
          title: isBangla ? "সিটি ব্যাংক এসক্রো ক্লিয়ারিং" : "City Bank Escrow Clearing",
          desc: isBangla
            ? "EPS গেটওয়ে (বিকাশ/কার্ড) অথবা সরাসরি সিটি ব্যাংক এসক্রো অ্যাকাউন্টে অর্থ জমা দিন।"
            : "Direct deposit via The City Bank PLC Escrow or online EPS gateway.",
          icon: Landmark,
        },
      ],
    },
    {
      phaseNum: "03",
      phaseTitle: isBangla ? "ডিজিটাল সার্টিফিকেট ও লভ্যাংশ" : "Digital Asset & Profit Payout",
      steps: [
        {
          num: "৫",
          title: isBangla ? "SHA-256 ডিজিটাল সার্টিফিকেট" : "Cryptographic Share Certificate",
          desc: isBangla
            ? "পেমেন্ট নিশ্চিতের সাথে সাথে সিকোয়েনশিয়াল লট নম্বর ও হ্যাশযুক্ত সার্টিফিকেট ইস্যু।"
            : "Instant issuance of cryptographic SHA-256 certificate in your vault.",
          icon: FileCheck2,
        },
        {
          num: "৬",
          title: isBangla ? "প্রো-রাটা ব্যাংক লভ্যাংশ জমা" : "Pro-Rata Profit Payout",
          desc: isBangla
            ? "প্রকল্প থেকে অর্জিত নিট মুনাফা সরাসরি আপনার ব্যাংক অ্যাকাউন্টে প্রো-রাটা হারে জমা হবে।"
            : "Direct pro-rata net profit bank transfer upon commercial milestones.",
          icon: TrendingUp,
        },
      ],
    },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <Layers className="w-3.5 h-3.5" />
          <span>{isBangla ? "কার্যপদ্ধতি" : "How It Works"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "সহজ ও নিরাপদ বিনিয়োগ কার্যপদ্ধতি" : "Institutional 3-Phase Process"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "মোবাইল ওয়ান-টাইম পাসওয়ার্ড থেকে শুরু করে সিটি ব্যাংক এসক্রো এবং লভ্যাংশ বণ্টন পর্যন্ত ৩টি ধাপে স্বচ্ছ কার্যপ্রণালী।"
            : "From instant mobile verification to City Bank escrow clearing and pro-rata profit payout in 3 transparent phases."}
        </p>
      </div>

      {/* 2. Compact 3-Phase Architecture */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {phases.map((phase) => (
          <div
            key={phase.phaseNum}
            className="bg-white rounded-3xl border border-slate-200/90 shadow-card p-6 space-y-5 flex flex-col justify-between hover:shadow-cardHover transition-all"
          >
            {/* Phase Header */}
            <div className="pb-3 border-b border-slate-100 flex items-center justify-between">
              <span className="px-2.5 py-0.5 rounded-lg text-xs font-black font-mono bg-blue-50 text-[#0066FF] border border-blue-100">
                PHASE {phase.phaseNum}
              </span>
              <h3 className="font-extrabold text-[#0A2540] text-sm">
                {phase.phaseTitle}
              </h3>
            </div>

            {/* Steps in this phase */}
            <div className="space-y-4">
              {phase.steps.map((s) => {
                const Icon = s.icon;
                return (
                  <div key={s.num} className="p-4 rounded-2xl bg-[#F8FAFC] border border-slate-200/80 space-y-2">
                    <div className="flex items-center gap-2.5">
                      <div className="w-8 h-8 rounded-xl bg-white border border-slate-200 text-[#0066FF] flex items-center justify-center shrink-0 shadow-2xs font-bold text-xs">
                        <Icon className="w-4 h-4" />
                      </div>
                      <h4 className="font-bold text-[#0A2540] text-xs sm:text-[13px]">
                        {s.title}
                      </h4>
                    </div>
                    <p className="text-xs text-slate-600 leading-relaxed font-normal">
                      {s.desc}
                    </p>
                  </div>
                );
              })}
            </div>

            <div className="pt-2 text-[11px] font-mono text-slate-400 flex items-center gap-1">
              <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
              <span>100% Verified Step</span>
            </div>
          </div>
        ))}
      </div>

      {/* 3. Bottom Compact Action Banner */}
      <div className="p-6 sm:p-8 rounded-3xl bg-gradient-to-r from-[#0A2540] via-[#041628] to-[#0A2540] text-white flex flex-col sm:flex-row sm:items-center justify-between gap-4 shadow-xl border border-slate-800">
        <div className="space-y-1">
          <h4 className="text-base sm:text-lg font-black text-white">
            {isBangla ? "আজই ল্যান্ডভেস্ট ১০০ প্রকল্পে অংশ নিন" : "Start with LandVest 100 Today"}
          </h4>
          <p className="text-xs text-cyan-light font-normal">
            {isBangla ? "মাত্র ৳২৫,৫০০ দিয়ে সরাসরি প্রফিট-শেয়ারিং পার্টনার হন।" : "Join with ৳25,500 per unit for asset-backed pro-rata profits."}
          </p>
        </div>

        <Link
          href="/projects/landvest-100"
          className="px-6 py-3 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-extrabold flex items-center justify-center gap-2 shadow-md transition-all self-start sm:self-auto shrink-0"
        >
          <span>{isBangla ? "প্রকল্প পেজ দেখুন" : "View Project"}</span>
          <ArrowRight className="w-4 h-4 text-[#00B4D8]" />
        </Link>
      </div>
    </div>
  );
}
