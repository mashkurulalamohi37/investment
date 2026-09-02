"use client";

import React from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { TrendingUp, ShieldCheck, CheckCircle2, Download, Building2 } from "lucide-react";

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
    },
  ];

  return (
    <div className="space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-200">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-slate-900">
            {isBangla ? "লভ্যাংশ ও আয় হিসেব" : "Dividend & Profit Distributions"}
          </h1>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "প্রকল্প থেকে অর্জিত মুনাফার প্রো-রাটা বণ্টন বিবরণী"
              : "Mathematical pro-rata dividend payout ledger and statements"}
          </p>
        </div>

        <button
          onClick={() => alert("Downloading Annual Dividend Statement (PDF)...")}
          className="inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-slate-100 text-slate-700 text-xs font-bold hover:bg-slate-200"
        >
          <Download className="w-4 h-4" />
          <span>Download Statement</span>
        </button>
      </div>

      {/* Metric Summary Card */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card">
          <span className="text-xs font-semibold text-slate-500 block">Total Profit Received</span>
          <span className="text-2xl font-black text-jade-dark font-mono block mt-1">
            {formatBDT(10000, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-400 block mt-1">Settled into bank account</span>
        </div>

        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card">
          <span className="text-xs font-semibold text-slate-500 block">Eligible Shares</span>
          <span className="text-2xl font-black text-slate-900 font-mono block mt-1">
            4 Shares
          </span>
          <span className="text-[11px] text-gold-dark font-mono font-bold block mt-1">
            LOT-041, LOT-042, LOT-043, LOT-044
          </span>
        </div>

        <div className="p-5 rounded-2xl bg-white border border-slate-200 shadow-card">
          <span className="text-xs font-semibold text-slate-500 block">Next Audit Settlement</span>
          <span className="text-2xl font-black text-slate-900 font-mono block mt-1">
            Q3 2026
          </span>
          <span className="text-[11px] text-slate-400 block mt-1">Scheduled Oct 2026</span>
        </div>
      </div>

      {/* Distributions Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-4">
        <h2 className="font-bold text-base text-slate-900">
          {isBangla ? "বণ্টনকৃত লভ্যাংশ খতিয়ান" : "Distribution Settlement History"}
        </h2>

        <div className="overflow-x-auto rounded-xl border border-slate-200">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold">
              <tr>
                <th className="py-3 px-4">Period / Project</th>
                <th className="py-3 px-4">Eligible Shares</th>
                <th className="py-3 px-4">Rate / Share</th>
                <th className="py-3 px-4 text-right">Total Net Payout</th>
                <th className="py-3 px-4">Payout Channel</th>
                <th className="py-3 px-4 text-center">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {distributions.map((d) => (
                <tr key={d.id} className="hover:bg-slate-50/80">
                  <td className="py-3 px-4 font-bold text-slate-900">{isBangla ? d.periodTitleBn : d.periodTitle}</td>
                  <td className="py-3 px-4 font-mono font-bold text-brand-forest">{d.eligibleShares} Shares</td>
                  <td className="py-3 px-4 font-mono">{formatBDT(d.perSharePayout, { isBangla })}</td>
                  <td className="py-3 px-4 text-right font-mono font-black text-jade-dark text-sm">
                    {formatBDT(d.totalGross, { isBangla })}
                  </td>
                  <td className="py-3 px-4 text-slate-500">{d.channel}</td>
                  <td className="py-3 px-4 text-center">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                      <CheckCircle2 className="w-3 h-3" />
                      {d.status}
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
