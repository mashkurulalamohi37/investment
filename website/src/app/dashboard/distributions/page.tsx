"use client";

import React from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { TrendingUp, ShieldCheck, CheckCircle2, Download, Building2, Coins, Calendar } from "lucide-react";

export default function DistributionsPage() {
  const { isBangla } = useAuth();

  const distributions = [
    {
      id: "dist-01",
      periodTitle: "LandVest 100 — Q2 2026 Commercial Dividend",
      periodTitleBn: "ল্যান্ডভেস্ট ১০০ — কিউ২ ২০২৬ বাণিজ্যিক লভ্যাংশ",
      eligibleShares: 4,
      perSharePayout: 2500,
      totalGross: 10000,
      status: "PAID",
      paidAt: "2026-08-28",
      channel: "City Bank Direct Deposit (A/C: ****7710)",
      channelBn: "সিটি ব্যাংক সরাসরি জমা (A/C: ****৭৭১০)",
    },
  ];

  return (
    <div className="space-y-4 sm:space-y-5 font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "প্রো-রাটা ডিভিডেন্ড খতিয়ান" : "PRO-RATA LEDGER"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "লভ্যাংশ প্রাপ্তি ও আয় বিবরণী" : "Dividend & Profit Distributions"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "প্রকল্প থেকে অর্জিত মুনাফার প্রো-রাটা বণ্টন বিবরণী ও ব্যাংক জমা হিসেব"
              : "Mathematical pro-rata dividend payout ledger and settlement statements"}
          </p>
        </div>

        <button
          onClick={() => alert("Downloading Annual Dividend Statement (PDF)...")}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 text-xs font-bold border border-slate-200 transition-all cursor-pointer"
        >
          <Download className="w-3.5 h-3.5 text-[#0066FF]" />
          <span>{isBangla ? "স্টেটমেন্ট ডাউনলোড" : "Download Statement"}</span>
        </button>
      </div>

      {/* Mini Metric KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 sm:gap-4">
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "মোট অর্জিত মুনাফা" : "Total Profit Received"}
          </span>
          <span className="text-lg sm:text-xl font-black text-emerald-700 block">
            {formatBDT(10000, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "ব্যাংক হিসাবে সরাসরি জমা" : "Settled into bank account"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-[#0066FF] block">
            {isBangla ? "যোগ্য শেয়ার সংখ্যা" : "Eligible Shares"}
          </span>
          <span className="text-lg sm:text-xl font-black text-[#0066FF] block">
            {isBangla ? "৪টি শেয়ার লট" : "4 Shares (LOT-041-044)"}
          </span>
          <span className="text-[11px] text-blue-600 block font-semibold">
            {isBangla ? "৪.০% প্রকল্পের অংশীদারিত্ব" : "4.0% Pro-Rata Equity"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "পরবর্তী নিরীক্ষা ও বণ্টন" : "Next Audit Settlement"}
          </span>
          <span className="text-lg sm:text-xl font-black text-slate-900 block">
            Q3 2026
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "অক্টোবর ২০২৬ এ নির্ধারিত" : "Scheduled October 2026"}
          </span>
        </div>
      </div>

      {/* Distributions Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-3.5">{isBangla ? "বণ্টন সময়কাল ও প্রজেক্ট" : "Period / Project"}</th>
                <th className="py-3 px-3.5">{isBangla ? "যোগ্য শেয়ার" : "Eligible Shares"}</th>
                <th className="py-3 px-3.5">{isBangla ? "শেয়ার প্রতি রেট" : "Rate / Share"}</th>
                <th className="py-3 px-3.5">{isBangla ? "মোট পে-আউট" : "Total Net Payout"}</th>
                <th className="py-3 px-3.5">{isBangla ? "পেমেন্ট চ্যানেল" : "Payout Channel"}</th>
                <th className="py-3 px-3.5 text-right">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {distributions.map((d) => (
                <tr key={d.id} className="hover:bg-slate-50/70 transition-colors">
                  <td className="py-3.5 px-3.5 font-bold text-slate-900 text-xs">
                    {isBangla ? d.periodTitleBn : d.periodTitle}
                  </td>
                  <td className="py-3.5 px-3.5 font-bold text-[#0066FF] text-xs">
                    {d.eligibleShares} {isBangla ? "টি শেয়ার" : "Shares"}
                  </td>
                  <td className="py-3.5 px-3.5 text-slate-800 text-xs">
                    {formatBDT(d.perSharePayout, { isBangla })}
                  </td>
                  <td className="py-3.5 px-3.5 font-bold text-emerald-700 text-xs sm:text-sm">
                    {formatBDT(d.totalGross, { isBangla })}
                  </td>
                  <td className="py-3.5 px-3.5 text-slate-600 text-[11px]">
                    {isBangla ? d.channelBn : d.channel}
                  </td>
                  <td className="py-3.5 px-3.5 text-right">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                      <CheckCircle2 className="w-3 h-3 text-emerald-600" />
                      <span>{isBangla ? "পরিশোধিত" : d.status}</span>
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
