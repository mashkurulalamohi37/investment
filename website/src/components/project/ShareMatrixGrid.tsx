"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Users, ArrowRight, PieChart, Sparkles, CheckCircle2, Award, Layers } from "lucide-react";

interface ShareAllocationProps {
  totalShares?: number;
  allocatedShares?: number;
  userOwnedShares?: number;
  pricePerShare?: number;
}

export default function ShareMatrixGrid({
  totalShares = 100,
  allocatedShares = 74,
  userOwnedShares = 4,
  pricePerShare = 25500,
}: ShareAllocationProps) {
  const { isBangla, isAuthenticated } = useAuth();

  const otherAllocated = allocatedShares - userOwnedShares;
  const availableShares = totalShares - allocatedShares;

  const allocatedPercent = (allocatedShares / totalShares) * 100;
  const userPercent = (userOwnedShares / totalShares) * 100;
  const availablePercent = (availableShares / totalShares) * 100;

  const totalFund = totalShares * pricePerShare;
  const collectedFund = allocatedShares * pricePerShare;
  const userFund = userOwnedShares * pricePerShare;
  const availableFund = availableShares * pricePerShare;

  return (
    <div className="bg-white rounded-3xl border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all p-6 sm:p-10 space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-6 border-b border-slate-100">
        <div className="space-y-1.5">
          <div className="flex items-center gap-2">
            <span className="px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-brand-light text-brand-emerald">
              {isBangla ? "শেয়ার বণ্টন প্রগ্রেস" : "Share Allocation Tracker"}
            </span>
            <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 flex items-center gap-1.5">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
              {isBangla ? "লাইভ" : "LIVE"}
            </span>
          </div>

          <h3 className="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
            {isBangla ? "ল্যান্ডভেস্ট ১০০ শেয়ার বণ্টন ও তহবিল প্রগ্রেস" : "LandVest 100 Share Allocation Progress"}
          </h3>
          <p className="text-xs sm:text-sm text-slate-500 font-normal">
            {isBangla
              ? "মোট ১০০টি নির্দিষ্ট শেয়ারের রিয়েল-টাইম সাবস্ক্রিপশন ও তহবিল বরাদ্দের বিবরণী"
              : "Real-time subscription progress and capital clearing breakdown across 100 fixed shares"}
          </p>
        </div>

        <Link
          href={isAuthenticated ? "/dashboard/investments/new" : "/login?redirect=/dashboard/investments/new"}
          className="self-start sm:self-auto px-6 py-3.5 rounded-full bg-brand-emerald hover:bg-brand-forest text-white text-xs sm:text-sm font-extrabold shadow-lg shadow-brand-emerald/25 transition-all flex items-center gap-2 group"
        >
          <span>{isBangla ? "অনলাইনে শেয়ার বুক করুন" : "Subscribe Shares"}</span>
          <ArrowRight className="w-4 h-4 text-cyan-light transition-transform group-hover:translate-x-1" />
        </Link>
      </div>

      {/* 4 KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {/* Card 1: Total Target */}
        <div className="p-5 rounded-3xl bg-slate-50/90 border border-slate-200/90 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between text-slate-500 text-xs font-semibold">
            <span>{isBangla ? "মোট শেয়ার সংখ্যা" : "Total Project Shares"}</span>
            <div className="w-8 h-8 rounded-xl bg-slate-200/70 text-slate-700 flex items-center justify-center">
              <Layers className="w-4 h-4" />
            </div>
          </div>
          <div className="space-y-0.5">
            <span className="text-2xl font-black text-slate-900 font-mono block">
              {isBangla ? "১০০টি ভাগ" : `${totalShares} Units`}
            </span>
            <span className="text-xs text-slate-500 font-medium block">
              {isBangla ? "মোট লক্ষ্য: " : "Target: "}
              <strong className="text-slate-800 font-mono">{formatBDT(totalFund, { isBangla })}</strong>
            </span>
          </div>
        </div>

        {/* Card 2: Subscribed / Collected */}
        <div className="p-5 rounded-3xl bg-blue-50/50 border border-blue-100 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between text-brand-emerald text-xs font-semibold">
            <span>{isBangla ? "সংগৃহীত ও বরাদ্দকৃত" : "Subscribed / Allocated"}</span>
            <div className="w-8 h-8 rounded-xl bg-brand-light text-brand-emerald flex items-center justify-center">
              <Users className="w-4 h-4" />
            </div>
          </div>
          <div className="space-y-0.5">
            <span className="text-2xl font-black text-brand-emerald font-mono block">
              {isBangla ? `৭৪টি ভাগ (${allocatedPercent.toFixed(0)}%)` : `${allocatedShares} Units (${allocatedPercent.toFixed(0)}%)`}
            </span>
            <span className="text-xs text-slate-500 font-medium block">
              {isBangla ? "সংগৃহীত: " : "Collected: "}
              <strong className="text-slate-800 font-mono">{formatBDT(collectedFund, { isBangla })}</strong>
            </span>
          </div>
        </div>

        {/* Card 3: User Active Equity */}
        <div className="p-5 rounded-3xl bg-cyan-tint/30 border border-cyan/20 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between text-cyan-dark text-xs font-semibold">
            <span>{isBangla ? "আপনার পোর্টফোলিও" : "Your Active Shares"}</span>
            <div className="w-8 h-8 rounded-xl bg-cyan-tint text-cyan-dark flex items-center justify-center">
              <Sparkles className="w-4 h-4" />
            </div>
          </div>
          <div className="space-y-0.5">
            <span className="text-2xl font-black text-cyan-dark font-mono block">
              {isBangla ? `৪টি শেয়ার (${userPercent.toFixed(1)}%)` : `${userOwnedShares} Units (${userPercent.toFixed(1)}%)`}
            </span>
            <span className="text-xs text-slate-500 font-medium block">
              {isBangla ? "আপনার বিনিয়োগ: " : "Invested: "}
              <strong className="text-slate-800 font-mono">{formatBDT(userFund, { isBangla })}</strong>
            </span>
          </div>
        </div>

        {/* Card 4: Available to Invest */}
        <div className="p-5 rounded-3xl bg-emerald-50/60 border border-emerald-200/80 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between text-emerald-800 text-xs font-semibold">
            <span>{isBangla ? "অবশিষ্ট উন্মুক্ত শেয়ার" : "Available to Join"}</span>
            <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-700 flex items-center justify-center">
              <CheckCircle2 className="w-4 h-4" />
            </div>
          </div>
          <div className="space-y-0.5">
            <span className="text-2xl font-black text-emerald-700 font-mono block">
              {isBangla ? `২৬টি ভাগ (${availablePercent.toFixed(0)}%)` : `${availableShares} Units (${availablePercent.toFixed(0)}%)`}
            </span>
            <span className="text-xs text-slate-500 font-medium block">
              {isBangla ? "অবশিষ্ট মূল্য: " : "Remaining: "}
              <strong className="text-slate-800 font-mono">{formatBDT(availableFund, { isBangla })}</strong>
            </span>
          </div>
        </div>
      </div>

      {/* Progress Bar Container */}
      <div className="space-y-4 bg-slate-50/90 p-6 sm:p-7 rounded-3xl border border-slate-200/90">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 text-xs font-bold text-slate-700">
          <span>
            {isBangla
              ? `তহবিল সংগ্রহের সার্বিক অগ্রগতি: ৭৪ / ১০০ শেয়ার (৭৪% সম্পন্ন)`
              : `Overall Capital Allocation Progress: 74 / 100 Shares (74% Complete)`}
          </span>
          <span className="font-mono text-brand-emerald">
            {formatBDT(collectedFund, { isBangla })} / {formatBDT(totalFund, { isBangla })}
          </span>
        </div>

        {/* Multi-Segment Track Bar */}
        <div className="h-4 rounded-full bg-slate-200/70 overflow-hidden flex border border-slate-300/60 p-0.5">
          {/* Other Allocated */}
          <div
            className="h-full bg-brand-forest rounded-l-full transition-all duration-700"
            style={{ width: `${(otherAllocated / totalShares) * 100}%` }}
            title={isBangla ? `অন্যান্য বরাদ্দকৃত: ${otherAllocated}টি শেয়ার` : `Allocated: ${otherAllocated} shares`}
          />
          {/* User Owned */}
          <div
            className="h-full bg-cyan transition-all duration-700"
            style={{ width: `${userPercent}%` }}
            title={isBangla ? `আপনার শেয়ার: ${userOwnedShares}টি` : `Your Shares: ${userOwnedShares}`}
          />
          {/* Available */}
          <div
            className="h-full bg-transparent rounded-r-full"
            style={{ width: `${availablePercent}%` }}
            title={isBangla ? `উন্মুক্ত: ${availableShares}টি শেয়ার` : `Remaining: ${availableShares} shares`}
          />
        </div>

        {/* Legend */}
        <div className="flex flex-wrap items-center justify-between gap-4 pt-1 text-xs text-slate-600 font-medium">
          <div className="flex items-center gap-4">
            <span className="flex items-center gap-1.5">
              <span className="w-3 h-3 rounded-full bg-brand-forest" />
              <span>{isBangla ? `অন্যান্য বরাদ্দকৃত (${otherAllocated} ভাগ)` : `Allocated (${otherAllocated})`}</span>
            </span>
            <span className="flex items-center gap-1.5">
              <span className="w-3 h-3 rounded-full bg-cyan" />
              <span>{isBangla ? `আপনার শেয়ার (${userOwnedShares} ভাগ)` : `Your Shares (${userOwnedShares})`}</span>
            </span>
            <span className="flex items-center gap-1.5">
              <span className="w-3 h-3 rounded-full border border-slate-400 bg-white" />
              <span>{isBangla ? `উন্মুক্ত (${availableShares} ভাগ)` : `Available (${availableShares})`}</span>
            </span>
          </div>

          <span className="text-[11px] text-slate-400 font-mono">
            {isBangla ? "* প্রতি শেয়ার ৳২৫,৫০০ • সর্বোচ্চ ৪টি শেয়ার সীমা" : "* ৳25,500/share • 4 shares investor limit"}
          </span>
        </div>
      </div>
    </div>
  );
}
