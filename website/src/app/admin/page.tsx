"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ShieldAlert,
  Coins,
  Users,
  Layers,
  ArrowRight,
  Clock,
  CheckCircle2,
  AlertTriangle,
  Receipt,
  TrendingUp,
  FileText,
  Building2,
  Sparkles,
  Award,
  ShieldCheck,
  Check,
} from "lucide-react";

export default function AdminOverviewPage() {
  const { isBangla } = useAuth();

  const metrics = {
    totalRaised: 1887000,
    targetFund: 2550000,
    allocatedShares: 74,
    totalShares: 100,
    pendingPaymentsCount: 2,
    pendingKycCount: 2,
    escrowBalance: 625000,
    totalExpenses: 1925000,
  };

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Compact Executive Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              LANDVEST 100 (LV100)
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 flex items-center gap-1">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
              {isBangla ? "অ্যাক্টিভ কনসোল" : "ACTIVE SUITE"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "এক্সিকিউটিভ অ্যাডমিন কন্ট্রোল সেন্টার" : "Executive Admin Control Center"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "রিয়েল-টাইম প্রজেক্ট মূলধন, শেয়ার বণ্টন, ব্যাংক যাচাইকরণ কিউ এবং অডিট লেজার"
              : "Real-time project capital, share allocations, payment verification queues, and audit ledger"}
          </p>
        </div>

        <Link
          href="/admin/payments"
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all"
        >
          <span>{isBangla ? "২টি পেন্ডিং ব্যাংক স্লিপ যাচাই করুন" : "Review 2 Pending Bank Slips"}</span>
          <ArrowRight className="w-3.5 h-3.5 text-white" />
        </Link>
      </div>

      {/* Sleek KPI Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
        {/* Card 1 */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "মোট সংগৃহীত মূলধন" : "Total Capital Raised"}
          </span>
          <span className="text-lg sm:text-xl font-black text-[#0066FF] block">
            {formatBDT(metrics.totalRaised, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            74.0% of {formatBDT(metrics.targetFund, { isBangla })}
          </span>
        </div>

        {/* Card 2 */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "শেয়ার বণ্টন অগ্রগতি" : "Share Allocation"}
          </span>
          <span className="text-lg sm:text-xl font-black text-slate-900 block">
            {metrics.allocatedShares} / {metrics.totalShares} {isBangla ? "ভাগ" : "Shares"}
          </span>
          <span className="text-[11px] text-emerald-700 block font-bold">
            {isBangla ? "২৬টি শেয়ার উন্মুক্ত" : "26 Shares Available"}
          </span>
        </div>

        {/* Card 3 */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "সিটি ব্যাংক এসক্রো ব্যালেন্স" : "City Bank Escrow Balance"}
          </span>
          <span className="text-lg sm:text-xl font-black text-blue-700 block">
            {formatBDT(metrics.escrowBalance, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            A/C: 1402-9988-7710-1
          </span>
        </div>

        {/* Card 4 */}
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "অডিটেড প্রকল্প খরচ" : "Audited Project Expenses"}
          </span>
          <span className="text-lg sm:text-xl font-black text-amber-700 block">
            {formatBDT(metrics.totalExpenses, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "৪টি অনুমোদিত ভাউচার" : "4 Approved Vouchers"}
          </span>
        </div>
      </div>

      {/* Action Queues & Quick Operations */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Payment Review Queue Box */}
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3">
          <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
            <h3 className="font-bold text-slate-900 text-sm sm:text-base flex items-center gap-2">
              <Clock className="w-4 h-4 text-[#0066FF]" />
              <span>{isBangla ? "পেন্ডিং ব্যাংক স্লিপ কিউ" : "Pending Bank Slips Queue"}</span>
            </h3>
            <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200">
              2 ACTION REQUIRED
            </span>
          </div>

          <div className="space-y-2.5 text-xs">
            <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/90 flex items-center justify-between gap-2">
              <div>
                <span className="font-bold text-slate-900 block text-xs sm:text-sm">
                  Dr. Tanvir Hasan (2 {isBangla ? "ভাগ" : "Shares"})
                </span>
                <span className="text-slate-500 text-[11px]">
                  Slip #DEP-CITY-8910 • {formatBDT(51000, { isBangla })}
                </span>
              </div>
              <Link
                href="/admin/payments"
                className="px-3 py-1.5 rounded-lg bg-[#0066FF] text-white font-bold text-xs hover:bg-[#0052CC] transition-colors shadow-xs shrink-0"
              >
                {isBangla ? "যাচাই করুন" : "Inspect"}
              </Link>
            </div>

            <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/90 flex items-center justify-between gap-2">
              <div>
                <span className="font-bold text-slate-900 block text-xs sm:text-sm">
                  Nusrat Jahan (1 {isBangla ? "ভাগ" : "Share"})
                </span>
                <span className="text-slate-500 text-[11px]">
                  Slip #DEP-CITY-8914 • {formatBDT(25500, { isBangla })}
                </span>
              </div>
              <Link
                href="/admin/payments"
                className="px-3 py-1.5 rounded-lg bg-[#0066FF] text-white font-bold text-xs hover:bg-[#0052CC] transition-colors shadow-xs shrink-0"
              >
                {isBangla ? "যাচাই করুন" : "Inspect"}
              </Link>
            </div>
          </div>
        </div>

        {/* Quick Operations & Navigation Hub */}
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3">
          <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
            <h3 className="font-bold text-slate-900 text-sm sm:text-base flex items-center gap-2">
              <Layers className="w-4 h-4 text-[#0066FF]" />
              <span>{isBangla ? "কুইক অপারেশনাল হাব" : "Quick Operational Hub"}</span>
            </h3>
            <Link href="/admin/projects" className="text-xs font-bold text-[#0066FF] hover:underline">
              {isBangla ? "প্রজেক্ট তালিকা →" : "Projects →"}
            </Link>
          </div>

          <div className="grid grid-cols-2 gap-2.5 text-xs">
            <Link
              href="/admin/projects"
              className="p-2.5 rounded-xl bg-slate-50 border border-slate-200 hover:border-[#0066FF] hover:bg-blue-50/40 transition-all space-y-0.5"
            >
              <span className="font-bold text-slate-900 block text-xs">
                {isBangla ? "প্রজেক্ট স্পেকট্রাম" : "Project Spectrum"}
              </span>
              <span className="text-[10px] text-slate-500 block leading-tight">
                {isBangla ? "নতুন প্রজেক্ট ও আপডেট" : "Manage & launch projects"}
              </span>
            </Link>

            <Link
              href="/admin/users"
              className="p-2.5 rounded-xl bg-slate-50 border border-slate-200 hover:border-[#0066FF] hover:bg-blue-50/40 transition-all space-y-0.5"
            >
              <span className="font-bold text-slate-900 block text-xs">
                {isBangla ? "ইনভেস্টর ও কেওয়াইসি" : "Investors & KYC"}
              </span>
              <span className="text-[10px] text-slate-500 block leading-tight">
                {isBangla ? "এনআইডি ও নমিনি যাচাই" : "Verify Smart NID & Nominees"}
              </span>
            </Link>

            <Link
              href="/admin/distributions"
              className="p-2.5 rounded-xl bg-slate-50 border border-slate-200 hover:border-[#0066FF] hover:bg-blue-50/40 transition-all space-y-0.5"
            >
              <span className="font-bold text-slate-900 block text-xs">
                {isBangla ? "লভ্যাংশ বণ্টন" : "Profit Distribution"}
              </span>
              <span className="text-[10px] text-slate-500 block leading-tight">
                {isBangla ? "ডিভিডেন্ড ঘোষণা ও প্রদান" : "Declare & disburse dividends"}
              </span>
            </Link>

            <Link
              href="/admin/expenses"
              className="p-2.5 rounded-xl bg-slate-50 border border-slate-200 hover:border-[#0066FF] hover:bg-blue-50/40 transition-all space-y-0.5"
            >
              <span className="font-bold text-slate-900 block text-xs">
                {isBangla ? "খরচের ভাউচার লেজার" : "Expense Vouchers"}
              </span>
              <span className="text-[10px] text-slate-500 block leading-tight">
                {isBangla ? "বিল ও রশিদ এন্ট্রি" : "Record audited bills"}
              </span>
            </Link>
          </div>

          <Link
            href="/admin/reports"
            className="w-full py-2 px-3 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 text-xs font-bold flex items-center justify-center gap-2 transition-all border border-slate-200"
          >
            <FileText className="w-3.5 h-3.5 text-[#0066FF]" />
            <span>{isBangla ? "আর্থিক স্টেটমেন্ট তৈরি ও এক্সপোর্ট করুন" : "Generate & Export Financial Statements"}</span>
          </Link>
        </div>
      </div>
    </div>
  );
}
