"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { HelpCircle, ChevronDown, ChevronUp, Search, Sparkles, CheckCircle2 } from "lucide-react";

export default function FAQPage() {
  const { isBangla } = useAuth();
  const [openIdx, setOpenIdx] = useState<number | null>(0);
  const [search, setSearch] = useState("");

  const faqs = [
    {
      q: isBangla ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম কীভাবে কাজ করে?" : "How does the Swapnojatri platform work?",
      a: isBangla
        ? "স্বপ্নযাত্রী একটি বহুমুখী ইনভেস্টমেন্ট প্ল্যাটফর্ম। জমি, স্মার্ট কৃষি ও লাভজনক প্রজেক্টে সাধারণ মানুষ অল্প পুঁজিতে অংশ নেন। প্রজেক্ট থেকে অর্জিত নিট মুনাফা অংশগ্রহণকারীদের মাঝে গাণিতিক প্রো-রাটা সূত্রে বণ্টন করা হয়।"
        : "Swapnojatri is a transparent multi-project crowdfunding platform. Investors subscribe to fixed share units in vetted land, smart agro, and business projects to earn proportional pro-rata net profits.",
      cat: "GENERAL",
    },
    {
      q: isBangla ? "একটি প্রজেক্টে কতগুলো শেয়ার থাকে এবং একজন কতটি শেয়ার কিনতে পারেন?" : "How many shares exist per project and what is the purchase limit?",
      a: isBangla
        ? "ল্যান্ডভেস্ট ১০০ প্রজেক্টে কঠোরভাবে মোট ১০০টি নির্দিষ্ট শেয়ার রয়েছে (প্রতি শেয়ারের মূল্য ৳২৫,৫০০)। একজন বিনিয়োগকারী সর্বোচ্চ ৪টি শেয়ার (৪.০% ইকুইটি) ক্রয় করতে পারেন, যা সবার জন্য সমান সুযোগ নিশ্চিত করে।"
        : "LandVest 100 has strictly 100 fixed shares (৳25,500 per share). Each investor can purchase a maximum of 4 shares (4.0% project equity) to prevent concentration and guarantee fair access.",
      cat: "SHARES",
    },
    {
      q: isBangla ? "আমার বিনিয়োগের টাকা কীভাবে সুরক্ষিত থাকে?" : "How is my invested capital secured?",
      a: isBangla
        ? "সকল বিনিয়োগ দ্য সিটি ব্যাংক পিএলসি-এর বিশেষ এসক্রো অ্যাকাউন্টে জমা হয়। অডিটকৃত ও অনুমোদিত প্রজেক্ট ব্যয় ছাড়া এই অ্যাকাউন্ট থেকে ফান্ড উত্তোলন করা সম্ভব নয়। প্রতিটি খরচের ভাউচার লাইভ লেজারে দেখা যায়।"
        : "All capital is cleared directly through The City Bank PLC Escrow Account. Funds cannot be withdrawn without verified project milestone vouchers, ensuring 100% fiduciary protection.",
      cat: "SECURITY",
    },
    {
      q: isBangla ? "লভ্যাংশ কখন এবং কীভাবে বণ্টন করা হয়?" : "When and how are profits distributed?",
      a: isBangla
        ? "বাণিজ্যিক ও কৃষি প্রজেক্টের মুনাফা ত্রৈমাসিক অথবা প্রজেক্ট সমাপ্তির পর সরাসরি আপনার ব্যাংক অ্যাকাউন্টে জমা হবে। লভ্যাংশ বণ্টনের সম্পূর্ণ বিবরণী আপনার ড্যাশবোর্ডে থাকবে।"
        : "Realized profits from commercial sales and crop harvests are distributed quarterly or at project maturity directly into your registered bank account with complete audit statements.",
      cat: "RETURNS",
    },
    {
      q: isBangla ? "বিনিয়োগের প্রমাণ হিসেবে কী পাব?" : "What official proof of investment do I receive?",
      a: isBangla
        ? "পেমেন্ট নিশ্চিত হওয়ার সাথে সাথে ডাটাবেস আপনাকে অদ্বিতীয় সিকোয়েনশিয়াল লট নম্বর বরাদ্দ করবে এবং আপনার ডকুমেন্ট ভল্টে SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশযুক্ত অফিসিয়াল ডিজিটাল শেয়ার সার্টিফিকেট ইস্যু হবে।"
        : "Upon payment clearance, the platform assigns unique sequential lot numbers (e.g. LOT-075) and issues an authoritative digital Share Certificate with SHA-256 cryptographic verification.",
      cat: "DOCS",
    },
  ];

  const filtered = faqs.filter(
    (f) =>
      f.q.toLowerCase().includes(search.toLowerCase()) ||
      f.a.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Header Banner */}
      <div className="text-center space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <HelpCircle className="w-3.5 h-3.5" />
          <span>{isBangla ? "সাধারণ প্রশ্নোত্তর" : "Frequently Asked Questions"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "সচরাচর জিজ্ঞাসিত প্রশ্নাবলী" : "Everything You Need to Know"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "শেয়ার বুকিং, সিটি ব্যাংক এসক্রো নিরাপত্তা ও মুনাফা বণ্টন সংক্রান্ত প্রয়োজনীয় উত্তরসমূহ।"
            : "Direct answers to questions regarding share limits, bank escrow safety, and profit distribution."}
        </p>
      </div>

      {/* 2. Compact Search Input */}
      <div className="relative max-w-xl mx-auto">
        <Search className="w-4 h-4 text-slate-400 absolute left-4 top-3.5" />
        <input
          type="text"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder={isBangla ? "প্রশ্ন খুঁজুন (যেমন: এসক্রো, শেয়ার, মুনাফা)..." : "Search questions..."}
          className="w-full pl-11 pr-4 py-3 rounded-2xl bg-white border border-slate-200/90 focus:outline-none focus:border-[#0066FF] focus:ring-2 focus:ring-[#0066FF]/10 text-slate-900 text-xs sm:text-sm font-medium shadow-card transition-all"
        />
      </div>

      {/* 3. Compact Accordion List */}
      <div className="space-y-3">
        {filtered.map((faq, idx) => {
          const isOpen = openIdx === idx;
          return (
            <div
              key={idx}
              className={`rounded-2xl border transition-all overflow-hidden ${
                isOpen
                  ? "bg-white border-[#0066FF]/30 shadow-md ring-1 ring-[#0066FF]/10"
                  : "bg-white border-slate-200/90 shadow-2xs hover:border-slate-300"
              }`}
            >
              <button
                type="button"
                onClick={() => setOpenIdx(isOpen ? null : idx)}
                className="w-full p-4 sm:p-5 text-left flex items-center justify-between gap-4 cursor-pointer"
              >
                <span className="font-extrabold text-xs sm:text-sm text-[#0A2540] flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-[#0066FF] shrink-0" />
                  <span>{faq.q}</span>
                </span>
                <span className="w-7 h-7 rounded-xl bg-slate-50 text-slate-500 flex items-center justify-center shrink-0">
                  {isOpen ? <ChevronUp className="w-4 h-4 text-[#0066FF]" /> : <ChevronDown className="w-4 h-4" />}
                </span>
              </button>

              {isOpen && (
                <div className="px-5 pb-5 pt-1 text-xs sm:text-sm text-slate-600 leading-relaxed font-normal border-t border-slate-100 bg-[#F8FAFC]/50">
                  <p>{faq.a}</p>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
