"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { useCms } from "@/lib/cms/useCms";
import { HelpCircle, ChevronDown, ChevronUp, Search } from "lucide-react";

export default function FAQPage() {
  const { isBangla } = useAuth();
  const { faq } = useCms();
  const [openIdx, setOpenIdx] = useState<number | null>(0);
  const [search, setSearch] = useState("");

  const items = (faq.items || []).filter((f) => f.active !== false);

  const filtered = items.filter((f) => {
    const q = isBangla ? f.qBn : f.q;
    const a = isBangla ? f.aBn : f.a;
    return (
      q.toLowerCase().includes(search.toLowerCase()) ||
      a.toLowerCase().includes(search.toLowerCase())
    );
  });

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Header Banner */}
      <div className="text-center space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <HelpCircle className="w-3.5 h-3.5" />
          <span>{isBangla ? faq.header.badgeBn || "সাধারণ প্রশ্নোত্তর" : faq.header.badge || "Frequently Asked Questions"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? faq.header.titleBn : faq.header.title}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla ? faq.header.subtitleBn : faq.header.subtitle}
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
        {filtered.map((item, idx) => {
          const isOpen = openIdx === idx;
          const questionText = isBangla ? item.qBn : item.q;
          const answerText = isBangla ? item.aBn : item.a;

          return (
            <div
              key={item.id || idx}
              className={`rounded-2xl border transition-all overflow-hidden ${
                isOpen
                  ? "bg-white border-[#0066FF]/30 shadow-md ring-1 ring-[#0066FF]/10"
                  : "bg-white border-slate-200/90 shadow-2xs hover:border-slate-300"
              }`}
            >
              <button
                type="button"
                onClick={() => setOpenIdx(isOpen ? null : idx)}
                className="w-full text-left p-4 sm:p-5 flex items-center justify-between gap-4"
              >
                <div className="flex items-center gap-3">
                  <span className="text-[10px] font-bold font-mono px-2 py-0.5 rounded bg-blue-50 text-[#0066FF] border border-blue-100 uppercase shrink-0">
                    {item.category}
                  </span>
                  <span className="font-extrabold text-[#0A2540] text-xs sm:text-sm">
                    {questionText}
                  </span>
                </div>
                <div className="text-slate-400 shrink-0">
                  {isOpen ? <ChevronUp className="w-4 h-4 text-[#0066FF]" /> : <ChevronDown className="w-4 h-4" />}
                </div>
              </button>

              {isOpen && (
                <div className="px-4 sm:px-5 pb-4 sm:pb-5 pt-1 text-xs text-slate-600 leading-relaxed border-t border-slate-100">
                  <p>{answerText}</p>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
