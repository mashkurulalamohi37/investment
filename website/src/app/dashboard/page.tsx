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
      title: isBangla ? "ল্যান্ডভেস্ট ১০০ (৪টি শেয়ার - EPS পেমেন্ট)" : "LandVest 100 (4 Shares - EPS Gateway)",
      date: "2026-08-15",
      amount: 102000,
      status: "COMPLETED",
      lots: "LOT-041, LOT-042, LOT-043, LOT-044",
    },
    {
      id: "txn-2",
      ref: "DIV-2026-Q2-01",
      title: isBangla ? "বাণিজ্যিক লভ্যাংশ বণ্টন (Q2 2026)" : "Quarterly Commercial Dividend (Q2 2026)",
      date: "2026-08-28",
      amount: 10000,
      status: "PAID",
      lots: "4 Shares Payout",
    },
  ];

  return (
    <div className="space-y-8">
      {/* 1. Welcome & Quick CTA Banner */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-200">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-slate-900">
            {isBangla ? `স্বাগতম, ${user?.full_name || "বিনিয়োগকারী"}` : `Welcome back, ${user?.full_name || "Investor"}`}
          </h1>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "আপনার মোট পোর্টফোলিও মূল্যায়ন ও সক্রিয় শেয়ারের বিবরণী"
              : "Overview of your portfolio valuation, active share lots, and dividend earnings"}
          </p>
        </div>

        <Link
          href="/dashboard/investments/new"
          className="inline-flex items-center gap-2 px-5 py-3 rounded-xl bg-gradient-emerald text-white text-xs font-bold hover:opacity-95 shadow-md shadow-brand-forest/20 transition-all"
        >
          <PlusCircle className="w-4 h-4 text-gold" />
          <span>{isBangla ? "নতুন শেয়ার ক্রয় করুন" : "Invest in More Shares"}</span>
        </Link>
      </div>

      {/* 2. 4-KPI Metric Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-slate-500">
              {isBangla ? "মোট বিনিয়োগ" : "Total Invested"}
            </span>
            <div className="w-8 h-8 rounded-lg bg-brand-light text-brand-forest flex items-center justify-center">
              <Coins className="w-4 h-4" />
            </div>
          </div>
          <span className="text-xl sm:text-2xl font-black text-brand-forest font-mono block">
            {formatBDT(portfolio.totalInvested, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-400 block font-mono">4.0% Equity Share</span>
        </div>

        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-slate-500">
              {isBangla ? "সক্রিয় শেয়ার লট" : "Active Share Lots"}
            </span>
            <div className="w-8 h-8 rounded-lg bg-gold/15 text-gold flex items-center justify-center">
              <Award className="w-4 h-4" />
            </div>
          </div>
          <span className="text-xl sm:text-2xl font-black text-slate-900 font-mono block">
            {portfolio.activeShares} {isBangla ? "টি শেয়ার" : "Shares"}
          </span>
          <span className="text-[11px] text-gold-dark font-mono font-bold block">
            {portfolio.assignedLots.join(", ")}
          </span>
        </div>

        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-slate-500">
              {isBangla ? "অর্জিত মোট লভ্যাংশ" : "Total Profit Payouts"}
            </span>
            <div className="w-8 h-8 rounded-lg bg-jade/10 text-jade flex items-center justify-center">
              <TrendingUp className="w-4 h-4" />
            </div>
          </div>
          <span className="text-xl sm:text-2xl font-black text-jade-dark font-mono block">
            {formatBDT(portfolio.totalProfitReceived, { isBangla })}
          </span>
          <span className="text-[11px] text-jade block font-semibold">Verified Pro-Rata</span>
        </div>

        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-slate-500">
              {isBangla ? "সক্রিয় প্রকল্প" : "Active Projects"}
            </span>
            <div className="w-8 h-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center">
              <Layers className="w-4 h-4" />
            </div>
          </div>
          <span className="text-xl sm:text-2xl font-black text-slate-900 font-mono block">
            {portfolio.activeProjects} {isBangla ? "টি প্রকল্প" : "Project"}
          </span>
          <span className="text-[11px] text-slate-500 block">LandVest 100 (LV100)</span>
        </div>
      </div>

      {/* 3. Active Land Investment Highlight Card */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-100">
          <div>
            <div className="flex items-center gap-2">
              <span className="px-2.5 py-0.5 rounded text-[10px] font-bold bg-brand-light text-brand-forest">
                LANDVEST 100
              </span>
              <span className="px-2.5 py-0.5 rounded text-[10px] font-bold bg-emerald-100 text-emerald-800">
                ALLOCATED & VERIFIED
              </span>
            </div>
            <h2 className="text-xl font-bold text-slate-900 mt-1">
              LandVest 100 (Savar Washpur Mouza Plot 418)
            </h2>
          </div>

          <Link
            href="/dashboard/investments"
            className="text-xs font-bold text-brand-forest hover:text-brand-primary flex items-center gap-1"
          >
            <span>{isBangla ? "সকল বিনিয়োগ দেখুন" : "View Investment Details"}</span>
            <ArrowRight className="w-3.5 h-3.5" />
          </Link>
        </div>

        {/* Assigned Lots Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {portfolio.assignedLots.map((lot) => (
            <div
              key={lot}
              className="p-3.5 rounded-xl bg-gold-tint border border-gold/30 flex items-center justify-between"
            >
              <div>
                <span className="text-[10px] text-gold-dark font-semibold block">ASSIGNED LOT</span>
                <span className="font-mono font-black text-slate-900 text-sm">{lot}</span>
              </div>
              <ShieldCheck className="w-4 h-4 text-gold-dark" />
            </div>
          ))}
        </div>
      </div>

      {/* 4. Recent Transactions Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-4">
        <h3 className="font-bold text-slate-900 text-base">
          {isBangla ? "সাম্প্রতিক লেনদেন ও লভ্যাংশ খতিয়ান" : "Recent Transactions & Dividend Ledger"}
        </h3>

        <div className="overflow-x-auto rounded-xl border border-slate-200">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold">
              <tr>
                <th className="py-3 px-4">Reference</th>
                <th className="py-3 px-4">Particulars</th>
                <th className="py-3 px-4">Date</th>
                <th className="py-3 px-4 text-right">Amount</th>
                <th className="py-3 px-4 text-center">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {recentTransactions.map((txn) => (
                <tr key={txn.id} className="hover:bg-slate-50/80">
                  <td className="py-3 px-4 font-mono font-bold text-brand-forest">{txn.ref}</td>
                  <td className="py-3 px-4 font-semibold text-slate-900">{txn.title}</td>
                  <td className="py-3 px-4 text-slate-500 font-mono">{txn.date}</td>
                  <td className="py-3 px-4 text-right font-mono font-bold text-slate-900">
                    {formatBDT(txn.amount, { isBangla })}
                  </td>
                  <td className="py-3 px-4 text-center">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                      {txn.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
