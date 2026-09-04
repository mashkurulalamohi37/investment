"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ShieldCheck,
  CheckCircle2,
  FileCheck,
  Building2,
  Receipt,
  Target,
  Coins,
  TrendingDown,
  ArrowUpRight,
  Download,
  Eye,
  X,
} from "lucide-react";

export default function TransparencyLedger() {
  const { isBangla } = useAuth();
  const [selectedVoucher, setSelectedVoucher] = useState<any | null>(null);

  const vouchers = [
    {
      no: "VCH-LV100-001",
      category: "PROJECT_AGREEMENT",
      title: isBangla ? "প্রকল্প পার্টনারশিপ চুক্তি ও প্রাতিষ্ঠানিক প্রসেসিং" : "Project Partnership Agreement & Processing",
      payee: isBangla ? "প্রকল্প অপারেশন ও প্রশাসনিক তহবিল" : "Project Operations & Administrative Fund",
      amount: 450000,
      date: "2026-08-05",
      auditedBy: isBangla ? "অর্থ ও অডিট পরিদপ্তর" : "Finance & Audit Directorate",
      bankRef: "CITY-TXN-098124",
      remarks: isBangla ? "আইনি পার্টনারশিপ ডিড ও নোটারি স্ট্যাম্প ফি পরিশোধ।" : "Legal partnership deed and notary stamp execution.",
    },
    {
      no: "VCH-LV100-002",
      category: "LAND_PURCHASE",
      title: isBangla ? "মূল জমির বায়না ও অধিগ্রহণ পেমেন্ট (১ম কিস্তি)" : "Land Acquisition Tranche 1 Settlement",
      payee: isBangla ? "মূল জমির মালিক (সরাসরি পে-অর্ডার)" : "Land Owner (Pay-Order Clearing)",
      amount: 1250000,
      date: "2026-08-12",
      auditedBy: isBangla ? "লিগ্যাল ও অডিট টিম" : "Legal & Audit Team",
      bankRef: "CITY-PO-8871029",
      remarks: isBangla ? "ওয়াশপুর জমির নিবন্ধিত বায়না চুক্তি ও প্রথম কিস্তির পে-অর্ডার।" : "Washpur prime land registered bayna settlement tranche 1.",
    },
    {
      no: "VCH-LV100-003",
      category: "DEVELOPMENT_FENCING",
      title: isBangla ? "জমির আরসিসি পিলার সীমানা প্রাচীর ও সাইট সাইনবোর্ড" : "RCC Pillar Demarcation & Site Development",
      payee: isBangla ? "প্রকৌশল ও নির্মাণ কন্ট্রাক্টর" : "Civil Demarcation Contractors",
      amount: 180000,
      date: "2026-08-20",
      auditedBy: isBangla ? "সাইট পরিদর্শন টিম" : "Site Inspection Team",
      bankRef: "CITY-EFT-441092",
      remarks: isBangla ? "সাইটের চারপাশে আরসিসি পিলার ও সীমানা তারের বেড়া নির্মাণ।" : "RCC demarcation boundary pillars and project signboard.",
    },
    {
      no: "VCH-LV100-004",
      category: "SURVEY_DEMARCATION",
      title: isBangla ? "ডিজিটাল জিপিএস সার্ভে ও সীমানা জরিপ ফি" : "Digital GPS Survey & Land Demarcation",
      payee: isBangla ? "সার্টিফাইড ল্যান্ড সার্ভেয়ার" : "Govt Certified Cadastral Surveyor",
      amount: 45000,
      date: "2026-08-25",
      auditedBy: isBangla ? "অডিট পরিদপ্তর" : "Audit Directorate",
      bankRef: "CITY-NPSB-55291",
      remarks: isBangla ? "সরকারি ডিজিটাল জিওডেটিক জিপিএস জরিপ ও সীমানা ম্যাপ চূড়ান্তকরণ।" : "Cadastral GPS topographic demarcation and land map finalization.",
    },
  ];

  return (
    <div className="bg-white rounded-3xl border border-slate-200/90 shadow-card p-6 sm:p-8 space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-5 border-b border-slate-100">
        <div>
          <div className="flex items-center gap-2.5">
            <h3 className="font-extrabold text-slate-900 text-lg sm:text-xl tracking-tight">
              {isBangla ? "রিয়েল-টাইম ফান্ড লেজার ও ভাউচার হিসেব" : "Live Fund Ledger & Audited Vouchers"}
            </h3>
            <span className="px-2.5 py-0.5 rounded-full text-xs font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
              100% Audited
            </span>
          </div>
          <p className="text-xs sm:text-sm text-slate-500 mt-0.5">
            {isBangla
              ? "সংগৃহীত তহবিলের প্রতিটি খরচের অনুমোদিত ভাউচার, অডিট কপি ও পেয়ি বিবরণী"
              : "Complete transparent fund accounting with verified vendor receipts and escrow clearing"}
          </p>
        </div>

        <div className="flex items-center gap-2">
          <span className="text-[11px] font-mono text-slate-400 bg-slate-50 px-3 py-1.5 rounded-full border border-slate-200">
            Escrow: The City Bank PLC
          </span>
        </div>
      </div>

      {/* 4-Metric Fund Utilization KPIs — Ultra-Refined */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-5">
        {/* Card 1: Target Fund */}
        <div className="p-5 rounded-3xl bg-slate-50/90 border border-slate-200/90 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-slate-500">
              {isBangla ? "টার্গেট ফান্ড (১০০ শেয়ার)" : "Target Fund (100 Units)"}
            </span>
            <div className="w-8 h-8 rounded-xl bg-slate-200/70 text-slate-700 flex items-center justify-center">
              <Target className="w-4 h-4" />
            </div>
          </div>
          <div>
            <span className="text-xl sm:text-2xl font-black text-slate-900 font-mono block">
              {formatBDT(2550000, { isBangla })}
            </span>
            <span className="text-[11px] text-slate-400 font-medium block mt-0.5">
              {isBangla ? "১০০টি নির্দিষ্ট শেয়ার" : "Fixed 100 Shares"}
            </span>
          </div>
        </div>

        {/* Card 2: Collected Capital */}
        <div className="p-5 rounded-3xl bg-blue-50/50 border border-blue-100 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-brand-emerald">
              {isBangla ? "সংগৃহীত তহবিল (৭৪ শেয়ার)" : "Collected Capital (74%)"}
            </span>
            <div className="w-8 h-8 rounded-xl bg-brand-light text-brand-emerald flex items-center justify-center">
              <Coins className="w-4 h-4" />
            </div>
          </div>
          <div>
            <span className="text-xl sm:text-2xl font-black text-brand-emerald font-mono block">
              {formatBDT(1887000, { isBangla })}
            </span>
            <span className="text-[11px] text-brand-emerald/80 font-medium block mt-0.5">
              {isBangla ? "৭৪% শেয়ার সাবস্ক্রাইবড" : "74 Shares Subscribed"}
            </span>
          </div>
        </div>

        {/* Card 3: Utilized Funds */}
        <div className="p-5 rounded-3xl bg-cyan-tint/30 border border-cyan/20 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-cyan-dark">
              {isBangla ? "ব্যবহৃত তহবিল (ভাউচারসমূহ)" : "Utilized Funds (Audited)"}
            </span>
            <div className="w-8 h-8 rounded-xl bg-cyan-tint text-cyan-dark flex items-center justify-center">
              <Receipt className="w-4 h-4" />
            </div>
          </div>
          <div>
            <span className="text-xl sm:text-2xl font-black text-cyan-dark font-mono block">
              {formatBDT(1925000, { isBangla })}
            </span>
            <span className="text-[11px] text-cyan-dark/80 font-medium block mt-0.5">
              {isBangla ? "৪টি অডিটকৃত ভাউচার" : "4 Audited Vouchers"}
            </span>
          </div>
        </div>

        {/* Card 4: Escrow Balance */}
        <div className="p-5 rounded-3xl bg-emerald-50/60 border border-emerald-200/80 space-y-3 flex flex-col justify-between">
          <div className="flex items-center justify-between">
            <span className="text-xs font-semibold text-emerald-800">
              {isBangla ? "এসক্রো অ্যাকাউন্ট ব্যালেন্স" : "City Bank Escrow Balance"}
            </span>
            <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-700 flex items-center justify-center">
              <ShieldCheck className="w-4 h-4" />
            </div>
          </div>
          <div>
            <span className="text-xl sm:text-2xl font-black text-emerald-700 font-mono block">
              {formatBDT(625000, { isBangla })}
            </span>
            <span className="text-[11px] text-emerald-700/80 font-medium block mt-0.5">
              {isBangla ? "১০০% সুরক্ষিত তহবিল" : "100% Escrow Protected"}
            </span>
          </div>
        </div>
      </div>

      {/* Expense Vouchers Table */}
      <div className="space-y-4 pt-2">
        <div className="flex items-center justify-between">
          <h4 className="font-extrabold text-sm sm:text-base text-slate-900 flex items-center gap-2">
            <Receipt className="w-4 h-4 text-brand-emerald" />
            <span>{isBangla ? "অনুমোদিত ব্যয় ভাউচার খতিয়ান" : "Approved Project Expense Ledger"}</span>
          </h4>
          <span className="text-xs text-slate-400 font-medium">
            {isBangla ? "মোট ৪টি ভাউচার প্রদর্শিত" : "Showing 4 verified vouchers"}
          </span>
        </div>

        <div className="overflow-x-auto rounded-2xl border border-slate-200/90 shadow-sm">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50/90 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider">
              <tr>
                <th className="py-3.5 px-5">{isBangla ? "ভাউচার নং" : "Voucher #"}</th>
                <th className="py-3.5 px-5">{isBangla ? "ব্যয়ের বিবরণী" : "Particulars / Purpose"}</th>
                <th className="py-3.5 px-5">{isBangla ? "প্রাপক (Payee)" : "Payee"}</th>
                <th className="py-3.5 px-5">{isBangla ? "তারিখ" : "Date"}</th>
                <th className="py-3.5 px-5 text-right">{isBangla ? "টাকার পরিমাণ" : "Amount"}</th>
                <th className="py-3.5 px-5 text-center">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
                <th className="py-3.5 px-5 text-center">{isBangla ? "অডিট ভিউ" : "Audit"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {vouchers.map((vch) => (
                <tr key={vch.no} className="hover:bg-slate-50/80 transition-colors">
                  <td className="py-4 px-5 font-mono font-bold text-brand-emerald">
                    <span className="px-2 py-0.5 rounded-lg bg-blue-50 border border-blue-100">
                      {vch.no}
                    </span>
                  </td>
                  <td className="py-4 px-5 font-bold text-slate-900 text-xs sm:text-[13px]">{vch.title}</td>
                  <td className="py-4 px-5 text-slate-600">{vch.payee}</td>
                  <td className="py-4 px-5 text-slate-500 font-mono">{vch.date}</td>
                  <td className="py-4 px-5 text-right font-mono font-extrabold text-slate-900 text-sm">
                    {formatBDT(vch.amount, { isBangla })}
                  </td>
                  <td className="py-4 px-5 text-center">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                      <CheckCircle2 className="w-3 h-3 text-emerald-600" />
                      {isBangla ? "অনুমোদিত" : "Verified"}
                    </span>
                  </td>
                  <td className="py-4 px-5 text-center">
                    <button
                      onClick={() => setSelectedVoucher(vch)}
                      className="p-1.5 rounded-lg text-slate-400 hover:text-brand-emerald hover:bg-slate-100 transition-colors"
                      title={isBangla ? "ভাউচার স্লিপ দেখুন" : "View Voucher Audit Slip"}
                    >
                      <Eye className="w-4 h-4" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Voucher Detail Modal */}
      {selectedVoucher && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl max-w-lg w-full p-6 sm:p-8 space-y-6 shadow-2xl border border-slate-200 animate-in fade-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between pb-3 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <Receipt className="w-5 h-5 text-brand-emerald" />
                <h3 className="font-extrabold text-slate-900 text-base">
                  {isBangla ? "অফিসিয়াল অডিটকৃত ভাউচার স্লিপ" : "Official Audited Voucher Slip"}
                </h3>
              </div>
              <button
                onClick={() => setSelectedVoucher(null)}
                className="p-1 rounded-full text-slate-400 hover:bg-slate-100 hover:text-slate-700"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-3 text-xs">
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "ভাউচার নং:" : "Voucher No:"}</span>
                <span className="font-mono font-bold text-brand-emerald">{selectedVoucher.no}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "উদ্দেশ্য / বিবরণী:" : "Purpose / Title:"}</span>
                <span className="font-bold text-slate-900 text-right">{selectedVoucher.title}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "প্রাপক:" : "Payee:"}</span>
                <span className="font-medium text-slate-700">{selectedVoucher.payee}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "অডিটকৃত পরিমাণ:" : "Audited Amount:"}</span>
                <span className="font-mono font-black text-slate-900 text-sm">
                  {formatBDT(selectedVoucher.amount, { isBangla })}
                </span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "ব্যাংক রেফারেন্স:" : "Bank Settlement Ref:"}</span>
                <span className="font-mono text-slate-700">{selectedVoucher.bankRef}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-400">{isBangla ? "নিরীক্ষক:" : "Audited By:"}</span>
                <span className="font-semibold text-emerald-800">{selectedVoucher.auditedBy}</span>
              </div>
              <div className="pt-2 border-t border-slate-200/60">
                <span className="text-slate-400 block mb-0.5">{isBangla ? "মন্তব্য / বিবরণ:" : "Remarks / Details:"}</span>
                <span className="text-slate-600 font-normal">{selectedVoucher.remarks}</span>
              </div>
            </div>

            <button
              onClick={() => setSelectedVoucher(null)}
              className="w-full py-3 rounded-full bg-brand-emerald text-white font-bold text-xs hover:bg-brand-forest transition-all"
            >
              {isBangla ? "বন্ধ করুন" : "Close Slip"}
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
