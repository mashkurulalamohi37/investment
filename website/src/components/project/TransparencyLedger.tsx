"use client";

import React from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldCheck, CheckCircle2, FileCheck, Landmark, Receipt } from "lucide-react";

export default function TransparencyLedger() {
  const { isBangla } = useAuth();

  const vouchers = [
    {
      no: "VCH-LV100-001",
      category: "LEGAL_REGISTRATION",
      title: isBangla ? "সাব-রেজিস্ট্রি দলিল নিবন্ধন ও স্ট্যাম্প ডিউটি" : "Sub-Registry Deed Stamp Duty & Registry",
      payee: isBangla ? "সাভার সাব-রেজিস্ট্রি অফিস" : "Savar Sub-Registry Revenue Office",
      amount: 450000,
      date: "2026-08-05",
      auditedBy: "Finance Directorate",
    },
    {
      no: "VCH-LV100-002",
      category: "LAND_PURCHASE",
      title: isBangla ? "মূল জমির বায়না ও অধিগ্রহণ পেমেন্ট (১ম কিস্তি)" : "Land Acquisition Tranche 1 Settlement",
      payee: isBangla ? "মূল জমির মালিক (সরাসরি পে-অর্ডার)" : "Land Owner (Pay-Order Clearing)",
      amount: 1250000,
      date: "2026-08-12",
      auditedBy: "Legal & Audit Team",
    },
    {
      no: "VCH-LV100-003",
      category: "DEVELOPMENT_FENCING",
      title: isBangla ? "জমির আরসিসি পিলার সীমানা প্রাচীর ও সাইট সাইনবোর্ড" : "RCC Pillar Demarcation & Site Development",
      payee: isBangla ? "প্রকৌশল ও নির্মাণ কন্ট্রাক্টর" : "Civil Demarcation Contractors",
      amount: 180000,
      date: "2026-08-20",
      auditedBy: "Site Inspection Team",
    },
    {
      no: "VCH-LV100-004",
      category: "SURVEY_DEMARCATION",
      title: isBangla ? "ডিজিটাল জিপিএস সার্ভে ও সীমানা জরিপ ফি" : "Digital GPS Survey & Land Demarcation",
      payee: isBangla ? "সার্টিফাইড ল্যান্ড সার্ভেয়ার" : "Govt Certified Cadastral Surveyor",
      amount: 45000,
      date: "2026-08-25",
      auditedBy: "Audit Directorate",
    },
  ];

  return (
    <div className="bg-white rounded-2xl border border-slate-200/90 shadow-card p-6 sm:p-8 space-y-8">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-100">
        <div>
          <h3 className="font-bold text-slate-900 text-base sm:text-lg flex items-center gap-2">
            <span>{isBangla ? "রিয়েল-টাইম ফান্ড লেজার ও ভাউচার হিসেব" : "Live Fund Ledger & Audited Vouchers"}</span>
            <span className="px-2 py-0.5 rounded text-xs font-bold bg-jade/10 text-jade-dark border border-jade/20">
              100% Audited
            </span>
          </h3>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "সংগৃহীত তহবিলের প্রতিটি খরচের অনুমোদিত ভাউচার ও পেয়ি বিবরণী"
              : "Complete transparent fund utilization ledger with verified bills and payee records"}
          </p>
        </div>
      </div>

      {/* 4-Metric Fund Utilization KPIs */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="p-4 rounded-xl bg-slate-50 border border-slate-200/80">
          <span className="text-xs text-slate-500 block mb-1">
            {isBangla ? "টার্গেট ফান্ড (১০০ শেয়ার):" : "Target Fund (100 Shares):"}
          </span>
          <span className="font-black text-slate-900 text-lg sm:text-xl font-mono">
            {formatBDT(2550000, { isBangla })}
          </span>
        </div>

        <div className="p-4 rounded-xl bg-brand-light border border-brand-emerald/20">
          <span className="text-xs text-brand-forest block mb-1">
            {isBangla ? "সংগৃহীত তহবিল (৭৪ শেয়ার):" : "Collected Capital (74 Shares):"}
          </span>
          <span className="font-black text-brand-forest text-lg sm:text-xl font-mono">
            {formatBDT(1887000, { isBangla })}
          </span>
        </div>

        <div className="p-4 rounded-xl bg-amber-50 border border-amber-200">
          <span className="text-xs text-amber-800 block mb-1">
            {isBangla ? "ব্যবহৃত তহবিল (ভাউচারসমূহ):" : "Utilized Funds (Audited):"}
          </span>
          <span className="font-black text-amber-900 text-lg sm:text-xl font-mono">
            {formatBDT(1925000, { isBangla })}
          </span>
        </div>

        <div className="p-4 rounded-xl bg-emerald-50 border border-emerald-200">
          <span className="text-xs text-emerald-800 block mb-1">
            {isBangla ? "এসক্রো অ্যাকাউন্ট ব্যালেন্স:" : "Escrow Account Balance:"}
          </span>
          <span className="font-black text-emerald-900 text-lg sm:text-xl font-mono">
            {formatBDT(625000, { isBangla })}
          </span>
        </div>
      </div>

      {/* Expense Vouchers Table */}
      <div className="space-y-3">
        <h4 className="font-bold text-sm text-slate-900 flex items-center gap-2">
          <Receipt className="w-4 h-4 text-gold" />
          <span>{isBangla ? "অনুমোদিত ব্যয় ভাউচার খতিয়ান" : "Approved Project Expense Vouchers"}</span>
        </h4>

        <div className="overflow-x-auto rounded-xl border border-slate-200">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold">
              <tr>
                <th className="py-3 px-4">{isBangla ? "ভাউচার নং" : "Voucher #"}</th>
                <th className="py-3 px-4">{isBangla ? "ব্যয়ের বিবরণী" : "Particulars / Purpose"}</th>
                <th className="py-3 px-4">{isBangla ? "প্রাপক (Payee)" : "Payee"}</th>
                <th className="py-3 px-4">{isBangla ? "তারিখ" : "Date"}</th>
                <th className="py-3 px-4 text-right">{isBangla ? "টাকার পরিমাণ" : "Amount"}</th>
                <th className="py-3 px-4 text-center">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {vouchers.map((vch) => (
                <tr key={vch.no} className="hover:bg-slate-50/80 transition-colors">
                  <td className="py-3 px-4 font-mono font-bold text-brand-forest">{vch.no}</td>
                  <td className="py-3 px-4 font-semibold text-slate-900">{vch.title}</td>
                  <td className="py-3 px-4 text-slate-600">{vch.payee}</td>
                  <td className="py-3 px-4 text-slate-500 font-mono">{vch.date}</td>
                  <td className="py-3 px-4 text-right font-mono font-bold text-slate-900">
                    {formatBDT(vch.amount, { isBangla })}
                  </td>
                  <td className="py-3 px-4 text-center">
                    <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                      <CheckCircle2 className="w-3 h-3" />
                      {isBangla ? "অনুমোদিত" : "Verified"}
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
