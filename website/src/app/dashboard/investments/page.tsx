"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Coins, PlusCircle, ShieldCheck, Download, Award, CheckCircle2, FileText, ArrowUpRight } from "lucide-react";

export default function MyInvestmentsPage() {
  const { isBangla } = useAuth();

  const investments = [
    {
      id: "inv-lv100-01",
      investmentNo: "INV-2026-LV100-0041",
      projectName: "LandVest 100 (Savar, Dhaka)",
      projectName_bn: "ল্যান্ডভেস্ট ১০০ (সাভার, ঢাকা)",
      shares: 4,
      unitPrice: 25500,
      totalAmount: 102000,
      status: "ALLOCATED",
      lots: ["LOT-041", "LOT-042", "LOT-043", "LOT-044"],
      paymentMethod: "City Bank Escrow Clearing",
      paymentMethod_bn: "সিটি ব্যাংক এসক্রো ক্লিয়ারেন্স",
      date: "2026-08-15",
      deedRef: "Deed #4982/2026",
    },
  ];

  return (
    <div className="space-y-4 sm:space-y-5 font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "৪টি সক্রিয় শেয়ার লট" : "4 ACTIVE LOTS"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "আমার বিনিয়োগ ও শেয়ার লট" : "My Active Investments"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "আপনার বরাদ্দকৃত শেয়ার লট নম্বর ও ডিজিটাল মালিকানা সনদপত্র"
              : "List of your project allocations, lot identifiers, and certificates"}
          </p>
        </div>

        <Link
          href="/dashboard/investments/new"
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-3.5 h-3.5 text-white" />
          <span>{isBangla ? "নতুন শেয়ার ক্রয়" : "Invest in Shares"}</span>
        </Link>
      </div>

      {/* Investments List */}
      <div className="space-y-4">
        {investments.map((inv) => (
          <div
            key={inv.id}
            className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 space-y-4"
          >
            {/* Top Bar */}
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-100">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="font-mono text-xs font-bold text-[#0066FF] bg-blue-50 border border-blue-200/60 px-2 py-0.5 rounded-md">
                    {inv.investmentNo}
                  </span>
                  <span className="inline-flex items-center gap-1 text-[10px] font-bold text-emerald-800 bg-emerald-50 border border-emerald-200 px-2 py-0.5 rounded-full">
                    <CheckCircle2 className="w-3 h-3 text-emerald-600" />
                    <span>{isBangla ? "বরাদ্দকৃত" : inv.status}</span>
                  </span>
                </div>
                <h2 className="text-base sm:text-lg font-bold text-slate-900 tracking-tight">
                  {isBangla ? inv.projectName_bn || inv.projectName : inv.projectName}
                </h2>
              </div>

              <div className="text-left sm:text-right">
                <span className="text-[11px] text-slate-500 block font-semibold">
                  {isBangla ? "মোট বিনিয়োগ মূল্য:" : "Total Investment Value:"}
                </span>
                <span className="text-xl sm:text-2xl font-black text-[#0066FF] font-mono tracking-tight">
                  {formatBDT(inv.totalAmount, { isBangla })}
                </span>
              </div>
            </div>

            {/* Assigned Lots */}
            <div className="space-y-1.5">
              <span className="text-xs font-bold text-slate-900 flex items-center gap-1.5">
                <Award className="w-3.5 h-3.5 text-[#0066FF]" />
                <span>{isBangla ? "বরাদ্দকৃত শেয়ার লট সমূহ:" : "Assigned Share Lots:"}</span>
              </span>
              <div className="flex flex-wrap gap-1.5">
                {inv.lots.map((lot) => (
                  <span
                    key={lot}
                    className="px-2.5 py-1 rounded-lg bg-slate-50 border border-slate-200 text-slate-900 font-mono font-bold text-xs"
                  >
                    {lot}
                  </span>
                ))}
              </div>
            </div>

            {/* Details Grid */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 p-3 rounded-xl bg-slate-50 border border-slate-200 text-xs">
              <div>
                <span className="text-slate-500 block text-[11px] mb-0.5 font-medium">
                  {isBangla ? "শেয়ার সংখ্যা:" : "Shares Owned:"}
                </span>
                <span className="font-bold text-slate-900">
                  {inv.shares} {isBangla ? "টি শেয়ার" : "Shares"} ({formatBDT(inv.unitPrice, { isBangla })}/{isBangla ? "ভাগ" : "Share"})
                </span>
              </div>
              <div>
                <span className="text-slate-500 block text-[11px] mb-0.5 font-medium">
                  {isBangla ? "পেমেন্ট মেথড:" : "Payment Method:"}
                </span>
                <span className="font-bold text-slate-900">
                  {isBangla ? inv.paymentMethod_bn || inv.paymentMethod : inv.paymentMethod}
                </span>
              </div>
              <div>
                <span className="text-slate-500 block text-[11px] mb-0.5 font-medium">
                  {isBangla ? "সনদপত্র আইডি:" : "Certificate ID:"}
                </span>
                <span className="font-bold text-slate-900 font-mono text-xs">CERT-LV100-{inv.id.replace('inv-', '')}</span>
              </div>
              <div>
                <span className="text-slate-500 block text-[11px] mb-0.5 font-medium">
                  {isBangla ? "সাবস্ক্রিপশন তারিখ:" : "Subscription Date:"}
                </span>
                <span className="font-bold text-slate-900 font-mono text-xs">{inv.date}</span>
              </div>
            </div>

            {/* Action Bar */}
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2.5 pt-1">
              <span className="text-[11px] text-slate-500 flex items-center gap-1.5 font-medium">
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                <span>{isBangla ? "SHA-256 ডিজিটাল নিরাপত্তা সনদ সক্রিয়" : "SHA-256 Digital Certificate Active"}</span>
              </span>

              <button
                onClick={() =>
                  alert(
                    `Generating Official Share Certificate:\nInvestment: ${inv.investmentNo}\nProject: ${inv.projectName}\nLots: ${inv.lots.join(", ")}\n\nCertificate downloaded successfully.`
                  )
                }
                className="px-3.5 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] font-bold text-xs text-white flex items-center justify-center gap-2 shadow-xs shadow-[#0066FF]/20 transition-all cursor-pointer"
              >
                <Download className="w-3.5 h-3.5" />
                <span>{isBangla ? "শেয়ার সনদপত্র ডাউনলোড (PDF)" : "Download Share Certificate (PDF)"}</span>
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
