"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Coins,
  TrendingUp,
  Layers,
  ArrowRight,
  ShieldCheck,
  FileCheck2,
  Clock,
  PlusCircle,
  Award,
  Sparkles,
  Receipt,
  CheckCircle2,
  ExternalLink,
} from "lucide-react";

export default function DashboardOverviewPage() {
  const { user, isBangla } = useAuth();

  const portfolio = {
    totalInvested: 102000,
    activeShares: 4,
    totalProfitReceived: 10000,
    activeProjects: 1,
    assignedLots: ["LOT-041", "LOT-042", "LOT-043", "LOT-044"],
  };

  const recentTransactions = [
    {
      id: "txn-1",
      ref: "EPS-TXN-9820194",
      title: isBangla ? "ল্যান্ডভেস্ট ১০০ (৪টি শেয়ার সাবস্ক্রিপশন)" : "LandVest 100 (4 Shares Subscription)",
      date: "2026-08-15",
      amount: 102000,
      status: "COMPLETED",
      lots: "LOT-041 to LOT-044",
    },
    {
      id: "txn-2",
      ref: "DIV-2026-Q2-01",
      title: isBangla ? "বাণিজ্যিক লভ্যাংশ বণ্টন (কিউ২ ২০২৬)" : "Quarterly Commercial Dividend (Q2 2026)",
      date: "2026-08-28",
      amount: 10000,
      status: "PAID",
      lots: isBangla ? "৪টি শেয়ার পে-আউট" : "4 Shares Payout",
    },
  ];

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* 1. Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "৪টি সক্রিয় শেয়ার লট" : "4 ACTIVE LOTS"}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 flex items-center gap-1">
              <ShieldCheck className="w-3 h-3 text-emerald-600" />
              <span>{isBangla ? "কেওয়াইসি ভেরিফাইড" : "KYC VERIFIED"}</span>
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? `স্বাগতম, ${user?.full_name || "মাশকুরুল আলম"}` : `Welcome, ${user?.full_name || "Mashkurul Alam"}`}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "আপনার পোর্টফোলিও মূল্যায়ন, সক্রিয় শেয়ার লট ও লভ্যাংশ বিবরণী"
              : "Summary of your portfolio valuation, active share lots, and dividend receipts"}
          </p>
        </div>

        <Link
          href="/dashboard/investments/new"
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-3.5 h-3.5 text-white" />
          <span>{isBangla ? "নতুন শেয়ার বুক করুন" : "Book New Shares"}</span>
        </Link>
      </div>

      {/* 2. 4 Sleek Metric KPI Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
        {/* Total Invested */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500">
              {isBangla ? "মোট বিনিয়োগ" : "Total Invested"}
            </span>
            <div className="w-7 h-7 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold">
              <Coins className="w-3.5 h-3.5" />
            </div>
          </div>
          <div>
            <span className="text-lg sm:text-xl font-black text-slate-900 block">
              {formatBDT(portfolio.totalInvested, { isBangla })}
            </span>
            <span className="text-[11px] text-slate-500 font-medium block">
              {isBangla ? "৪টি সক্রিয় শেয়ার" : "4 Active Shares"}
            </span>
          </div>
        </div>

        {/* Active Shares */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-semibold uppercase tracking-wider text-[#0066FF]">
              {isBangla ? "সক্রিয় শেয়ার সংখ্যা" : "Subscribed Shares"}
            </span>
            <div className="w-7 h-7 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold">
              <Layers className="w-3.5 h-3.5" />
            </div>
          </div>
          <div>
            <span className="text-lg sm:text-xl font-black text-[#0066FF] block">
              {isBangla ? "৪ টি ভাগ" : `${portfolio.activeShares} Units`}
            </span>
            <span className="text-[11px] text-blue-600 font-bold block">
              {isBangla ? "৪.০% প্রকল্পের মালিকানা" : "4.0% Equity Stake"}
            </span>
          </div>
        </div>

        {/* Total Profits Received */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-semibold uppercase tracking-wider text-emerald-700">
              {isBangla ? "মোট অর্জিত লভ্যাংশ" : "Profits Received"}
            </span>
            <div className="w-7 h-7 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center font-bold">
              <TrendingUp className="w-3.5 h-3.5" />
            </div>
          </div>
          <div>
            <span className="text-lg sm:text-xl font-black text-emerald-700 block">
              {formatBDT(portfolio.totalProfitReceived, { isBangla })}
            </span>
            <span className="text-[11px] text-emerald-700 font-medium block">
              {isBangla ? "সরাসরি ব্যাংক জমা" : "Deposited to Bank"}
            </span>
          </div>
        </div>

        {/* Active Projects */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500">
              {isBangla ? "সক্রিয় প্রজেক্ট" : "Active Project"}
            </span>
            <div className="w-7 h-7 rounded-lg bg-slate-100 text-slate-700 flex items-center justify-center font-bold">
              <Award className="w-3.5 h-3.5" />
            </div>
          </div>
          <div>
            <span className="text-lg sm:text-xl font-black text-slate-900 block">
              LandVest 100
            </span>
            <span className="text-[11px] text-slate-500 font-medium block">
              {isBangla ? "বসিলা, ঢাকা" : "Bosila, Dhaka"}
            </span>
          </div>
        </div>
      </div>

      {/* 3. Action Grid: Share Lot Portfolio & Transactions */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Allocated Share Lots Card */}
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3">
          <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
            <h3 className="font-bold text-slate-900 text-sm sm:text-base flex items-center gap-2">
              <Award className="w-4 h-4 text-[#0066FF]" />
              <span>{isBangla ? "বরাদ্দকৃত শেয়ার লট বিবরণী" : "Allocated Share Lots"}</span>
            </h3>
            <Link href="/dashboard/investments" className="text-xs font-bold text-[#0066FF] hover:underline">
              {isBangla ? "বিস্তারিত পোর্টফোলিও →" : "Portfolio →"}
            </Link>
          </div>

          <div className="space-y-2.5">
            <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/90 space-y-2">
              <div className="flex items-center justify-between text-xs">
                <span className="font-bold text-slate-900">LandVest 100 (Savar, Dhaka)</span>
                <span className="text-[#0066FF] font-bold">{formatBDT(102000, { isBangla })}</span>
              </div>
              <div className="flex flex-wrap gap-1.5 pt-1">
                {portfolio.assignedLots.map((lot) => (
                  <span
                    key={lot}
                    className="px-2.5 py-1 rounded-lg bg-white border border-slate-200 font-mono font-bold text-slate-800 text-xs shadow-2xs"
                  >
                    {lot}
                  </span>
                ))}
              </div>
            </div>

            <div className="flex items-center justify-between p-2.5 rounded-xl bg-blue-50/60 border border-blue-100 text-xs">
              <span className="text-slate-600 font-medium">
                {isBangla ? "ডিজিটাল সিকিউরিটি সনদ:" : "Security Certificate:"}
              </span>
              <span className="font-mono text-[#0066FF] font-bold">CERT-LV100-0041</span>
            </div>
          </div>
        </div>

        {/* Recent Ledger History */}
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3">
          <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
            <h3 className="font-bold text-slate-900 text-sm sm:text-base flex items-center gap-2">
              <Clock className="w-4 h-4 text-[#0066FF]" />
              <span>{isBangla ? "সাম্প্রতিক লেনদেন ও লভ্যাংশ খতিয়ান" : "Recent Activity & Payouts"}</span>
            </h3>
            <Link href="/dashboard/distributions" className="text-xs font-bold text-[#0066FF] hover:underline">
              {isBangla ? "সকল লেনদেন →" : "View All →"}
            </Link>
          </div>

          <div className="space-y-2 text-xs">
            {recentTransactions.map((txn) => (
              <div
                key={txn.id}
                className="p-2.5 rounded-xl bg-slate-50 border border-slate-200/90 flex items-center justify-between gap-2"
              >
                <div>
                  <span className="font-bold text-slate-900 block text-xs">{txn.title}</span>
                  <span className="text-slate-500 text-[11px] font-mono">{txn.ref} • {txn.date}</span>
                </div>
                <div className="text-right shrink-0">
                  <span className="font-bold text-[#0066FF] block text-xs sm:text-sm">
                    {formatBDT(txn.amount, { isBangla })}
                  </span>
                  <span className="inline-block text-[10px] px-1.5 py-0.2 rounded font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
                    {txn.status}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
