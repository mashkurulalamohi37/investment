"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Coins, PlusCircle, ShieldCheck, Download, Award, CheckCircle2, FileText } from "lucide-react";

export default function MyInvestmentsPage() {
  const { isBangla } = useAuth();

  const investments = [
    {
      id: "inv-lv100-01",
      investmentNo: "INV-2026-LV100-0041",
      projectName: "LandVest 100 (Savar, Dhaka)",
      shares: 4,
      unitPrice: 25500,
      totalAmount: 102000,
      status: "ALLOCATED",
      lots: ["LOT-041", "LOT-042", "LOT-043", "LOT-044"],
      paymentMethod: "EPS (bKash Checkout)",
      date: "2026-08-15",
      deedRef: "Deed #4982/2026",
    },
  ];

  return (
    <div className="space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-200">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-slate-900">
            {isBangla ? "আমার বিনিয়োগ ও শেয়ার লট" : "My Active Investments"}
          </h1>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "আপনার বরাদ্দকৃত শেয়ার লট নম্বর ও সনদপত্র"
              : "List of your project allocations, lot identifiers, and certificates"}
          </p>
        </div>

        <Link
          href="/dashboard/investments/new"
          className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-gradient-emerald text-white text-xs font-bold hover:opacity-95 shadow-md shadow-brand-forest/20"
        >
          <PlusCircle className="w-4 h-4 text-gold" />
          <span>{isBangla ? "নতুন শেয়ার ক্রয়" : "Invest in Shares"}</span>
        </Link>
      </div>

      {/* Investments List */}
      <div className="space-y-6">
        {investments.map((inv) => (
          <div
            key={inv.id}
            className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6"
          >
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-100">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="font-mono text-xs font-bold text-brand-forest bg-brand-light px-2.5 py-0.5 rounded">
                    {inv.investmentNo}
                  </span>
                  <span className="inline-flex items-center gap-1 text-[10px] font-bold text-emerald-800 bg-emerald-100 px-2.5 py-0.5 rounded-full">
                    <CheckCircle2 className="w-3 h-3" />
                    {inv.status}
                  </span>
                </div>
                <h2 className="text-xl font-bold text-slate-900">{inv.projectName}</h2>
              </div>

              <div className="text-right">
                <span className="text-xs text-slate-400 block">Total Investment Value</span>
                <span className="text-2xl font-black text-brand-forest font-mono">
                  {formatBDT(inv.totalAmount, { isBangla })}
                </span>
              </div>
            </div>

            {/* Lot Allocation Badges */}
            <div className="space-y-2">
              <span className="text-xs font-bold text-slate-700 flex items-center gap-1.5">
                <Award className="w-4 h-4 text-gold" />
                <span>Assigned Share Lots:</span>
              </span>
              <div className="flex flex-wrap gap-2">
                {inv.lots.map((lot) => (
                  <span
                    key={lot}
                    className="px-3 py-1.5 rounded-xl bg-gold-tint border border-gold/40 text-slate-900 font-mono font-bold text-xs"
                  >
                    {lot}
                  </span>
                ))}
              </div>
            </div>

            {/* Details Grid */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 p-4 rounded-xl bg-canvas-light border border-slate-200/80 text-xs">
              <div>
                <span className="text-slate-400 block">Shares Owned:</span>
                <span className="font-bold text-slate-900">{inv.shares} Shares (৳ 25,500/ea)</span>
              </div>
              <div>
                <span className="text-slate-400 block">Payment Method:</span>
                <span className="font-bold text-slate-900">{inv.paymentMethod}</span>
              </div>
              <div>
                <span className="text-slate-400 block">Title Deed Ref:</span>
                <span className="font-bold text-slate-900 font-mono">{inv.deedRef}</span>
              </div>
              <div>
                <span className="text-slate-400 block">Subscription Date:</span>
                <span className="font-bold text-slate-900 font-mono">{inv.date}</span>
              </div>
            </div>

            {/* Action Bar */}
            <div className="flex items-center justify-between pt-2">
              <span className="text-xs text-slate-400 flex items-center gap-1">
                <ShieldCheck className="w-4 h-4 text-jade" />
                <span>SHA-256 Digital Certificate Active</span>
              </span>

              <button
                onClick={() =>
                  alert(
                    `Generating Official Share Certificate:\nInvestment: ${inv.investmentNo}\nProject: ${inv.projectName}\nLots: ${inv.lots.join(", ")}\n\nCertificate downloaded successfully.`
                  )
                }
                className="px-4 py-2 rounded-xl bg-slate-100 hover:bg-brand-light hover:text-brand-forest font-bold text-xs text-slate-700 flex items-center gap-2 transition-all"
              >
                <Download className="w-3.5 h-3.5" />
                <span>Download Share Certificate (PDF)</span>
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
