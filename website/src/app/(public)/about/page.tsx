"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Building2,
  ShieldCheck,
  TrendingUp,
  HeartHandshake,
  ArrowRight,
  Sparkles,
  MapPin,
  CheckCircle2,
  Layers,
  Coins,
} from "lucide-react";

export default function AboutPage() {
  const { isBangla } = useAuth();

  const principles = [
    {
      title: isBangla ? "১০০টি নির্দিষ্ট শেয়ার" : "Fixed 100 Shares",
      desc: isBangla
        ? "প্রতিটি প্রজেক্টে শেয়ার সংখ্যা কঠোরভাবে ১০০টিতে সীমাবদ্ধ, যা সমতা ও অতিরিক্ত ইস্যু প্রতিরোধ নিশ্চিত করে।"
        : "Strict hard cap of 100 shares per project preventing dilution and concentration.",
      icon: Layers,
    },
    {
      title: isBangla ? "সিটি ব্যাংক এসক্রো নিরাপত্তা" : "City Bank Escrow Safety",
      desc: isBangla
        ? "সকল বিনিয়োগ তহবিল অডিটকৃত অনুমোদন ছাড়া উত্তোলনযোগ্য নয়, যা ১০০% ট্রাস্ট ও সুরক্ষা দেয়।"
        : "Funds are legally held in The City Bank PLC Escrow with audited disbursements.",
      icon: ShieldCheck,
    },
    {
      title: isBangla ? "১০০% লাইভ অডিট ভাউচার" : "100% Live Audited Ledger",
      desc: isBangla
        ? "সংগৃহীত তহবিলের প্রতিটি খরচ ও পেমেন্টের ভাউচার লাইভ লেজারে দৃশ্যমান।"
        : "Every single taka deployed is documented with live audited vouchers.",
      icon: TrendingUp,
    },
    {
      title: isBangla ? "গাণিতিক প্রো-রাটা মুনাফা" : "Mathematical Pro-Rata Returns",
      desc: isBangla
        ? "অর্জিত নিট মুনাফা শেয়ারের অনুপাতে স্বয়ংক্রিয়ভাবে সরাসরি ব্যাংক অ্যাকাউন্টে জমা হয়।"
        : "Realized net profits are automatically distributed pro-rata to bank accounts.",
      icon: Coins,
    },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Compact Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <Sparkles className="w-3.5 h-3.5" />
          <span>{isBangla ? "আমাদের গল্প ও দর্শন" : "Our Story & Vision"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "স্বচ্ছ ও নির্ভরযোগ্য যৌথ উদ্যোগ" : "Transparent Fractional Co-Ownership"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম সাধারণ মানুষকে ক্ষুদ্র পুঁজিতে ঢাকার লাভজনক জমি ও বাণিজ্যিক উদ্যোগে অংশীদারিত্বের সুযোগ তৈরি করে।"
            : "Swapnojatri democratizes access to high-value Dhaka land and commercial agriculture through fractional profit-sharing."}
        </p>
      </div>

      {/* 2. 4-Pillar Trust Bento Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
        {principles.map((p, idx) => {
          const Icon = p.icon;
          return (
            <div
              key={idx}
              className="p-6 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-3 flex flex-col justify-between"
            >
              <div className="space-y-3">
                <div className="w-10 h-10 rounded-2xl bg-blue-50 text-[#0066FF] flex items-center justify-center shadow-2xs">
                  <Icon className="w-5 h-5" />
                </div>
                <h3 className="font-extrabold text-[#0A2540] text-sm sm:text-base">
                  {p.title}
                </h3>
                <p className="text-xs text-slate-600 leading-relaxed font-normal">
                  {p.desc}
                </p>
              </div>

              <div className="pt-2 text-[11px] font-mono text-emerald-700 flex items-center gap-1 font-bold">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                <span>{isBangla ? "যাচাইকৃত ভিত্তি" : "Verified Pillar"}</span>
              </div>
            </div>
          );
        })}
      </div>

      {/* 3. Narrative & Founder Commitment */}
      <div className="p-6 sm:p-8 rounded-3xl bg-[#F8FAFC] border border-slate-200/90 space-y-4 text-xs sm:text-sm text-slate-700 leading-relaxed font-normal">
        <h3 className="font-extrabold text-[#0A2540] text-base border-b border-slate-200/60 pb-2">
          {isBangla ? "আমাদের মূল বিশ্বাস ও উদ্দেশ্য" : "Our Core Philosophy"}
        </h3>
        <p>
          {isBangla
            ? "আমরা অপরিচিত মানুষের কাছ থেকে বড় আকারে অর্থ সংগ্রহের চিন্তা থেকে এটি শুরু করিনি। বরং পরিচিত ও আমাদের ওপর আস্থা রাখেন—এমন মানুষদের ছোট অঙ্কে একটি নিরাপদ যৌথ বিনিয়োগের সুযোগে যুক্ত করার চিন্তা থেকেই স্বপ্নযাত্রী ও LandVest 100 এর সূচনা।"
            : "Rather than raising capital indiscriminately from strangers, Swapnojatri was born to provide trusted individuals with low-ticket access to asset-backed co-investments."}
        </p>
        <p className="font-bold text-[#0066FF]">
          {isBangla
            ? "আমাদের লক্ষ্য সম্পূর্ণ স্বচ্ছতা—কোনো লুকায়িত শর্ত নেই। আপনি পরিকল্পনা বুঝবেন, ভাউচার দেখবেন, তারপর সিদ্ধান্ত নেবেন।"
            : "Our goal is absolute fiduciary transparency without hidden clauses. Review our audited ledger, inspect the bank escrow, and invest with confidence."}
        </p>
      </div>
    </div>
  );
}
