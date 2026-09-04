"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { FileText, Download, ShieldCheck, FileSpreadsheet, Calendar, CheckCircle2 } from "lucide-react";

export default function AdminReportsPage() {
  const { isBangla } = useAuth();
  const [downloadToast, setDownloadToast] = useState<string | null>(null);

  const reports = [
    {
      id: "rep-01",
      title: "Master Fund Utilization & Expense Ledger",
      title_bn: "তহবিল ব্যবহার ও নিরীক্ষিত ব্যয় ভাউচার বিবরণী",
      format: "PDF & CSV",
      period: "August 2026",
      period_bn: "আগস্ট ২০২৬",
      size: "3.4 MB",
      desc: "Complete itemized audit of all 4 project expenses, payee receipts, and remaining City Bank escrow balance.",
      desc_bn: "প্রকল্পের ৪টি খরচ, প্রাপ্তি রসিদ এবং সিটি ব্যাংক এসক্রো ব্যালেন্সের সমন্বিত নিরীক্ষা প্রতিবেদন।",
    },
    {
      id: "rep-02",
      title: "Investor Share Register & Pro-Rata Equity Ledger",
      title_bn: "বিনিয়োগকারী ও শেয়ার রেজিস্টার বিবরণী",
      format: "PDF Document",
      period: "Current Q3 2026",
      period_bn: "চলতি কিউ৩ ২০২৬",
      size: "2.1 MB",
      desc: "Official sequential share register detailing 74 allocated shares, investor NIDs, and digital certificate hashes.",
      desc_bn: "৭৪টি বরাদ্দকৃত শেয়ার, এনআইডি এবং ডিজিটাল সিকিউরিটি সার্টিফিকেট রেজিস্ট্রেশন তালিকা।",
    },
    {
      id: "rep-03",
      title: "Quarterly Dividend Disbursement Reconciliation Book",
      title_bn: "ত্রৈমাসিক লভ্যাংশ বণ্টন ও ব্যাংক সেটেলমেন্ট বই",
      format: "Excel / CSV",
      period: "H1 2026",
      period_bn: "এইচ১ ২০২৬",
      size: "1.8 MB",
      desc: "Mathematical breakdown of ৳2,50,000 net profit distribution across 74 participating investor accounts.",
      desc_bn: "৭৪ জন বিনিয়োগকারীর ব্যাংক অ্যাকাউন্টে বণ্টিত ৳ ২,৫০,০০০ নিট মুনাফার পূর্ণাঙ্গ বিবরণী।",
    },
    {
      id: "rep-04",
      title: "Annual Regulatory Tax & Escrow Statement",
      title_bn: "বার্ষিক নিয়ন্ত্রক কর ও এসক্রো ট্রাস্ট স্টেটমেন্ট",
      format: "Audited PDF",
      period: "FY 2025-2026",
      period_bn: "অর্থবছর ২০২৫-২০২৬",
      size: "4.2 MB",
      desc: "Chartered accountant verified tax statements, NBR compliance filings, and escrow trust certificates.",
      desc_bn: "চার্টার্ড অ্যাকাউন্ট্যান্ট দ্বারা নিরীক্ষিত ট্যাক্স বিবরণী, এনবিআর কমপ্লায়েন্স এবং ট্রাস্ট সার্টিফিকেট।",
    },
  ];

  const handleDownload = (rep: any) => {
    setDownloadToast(
      isBangla
        ? `অফিসিয়াল ${rep.title_bn || rep.title} (${rep.format}) প্রস্তুত হচ্ছে... ডাউনলোড সম্পন্ন!`
        : `Generating official ${rep.title} (${rep.format})... Download complete.`
    );
    setTimeout(() => setDownloadToast(null), 3500);
  };

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "৪টি অডিট ডকুমেন্ট" : "4 AUDIT DOCUMENTS"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "অডিট রিপোর্ট ও আর্থিক স্টেটমেন্ট এক্সপোর্ট" : "Audit Reports & Statement Exports"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "ক্রিপ্টোগ্রাফিক ভেরিফাইড আর্থিক লেজার, ইনভেস্টর রেজিস্ট্রি এবং ট্যাক্স স্টেটমেন্ট ডাউনলোড করুন"
              : "Generate and export cryptographically verified financial ledgers, investor registers, and tax statements"}
          </p>
        </div>
      </div>

      {downloadToast && (
        <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-bold flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          <span>{downloadToast}</span>
        </div>
      )}

      {/* Reports Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {reports.map((rep) => (
          <div
            key={rep.id}
            className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-4 flex flex-col justify-between"
          >
            <div className="space-y-2.5">
              <div className="flex items-center justify-between">
                <span className="px-2 py-0.5 rounded text-[11px] font-mono font-bold bg-slate-100 text-slate-800 border border-slate-200">
                  {rep.format}
                </span>
                <span className="text-[11px] text-slate-500 font-mono">
                  {isBangla ? rep.period_bn || rep.period : rep.period}
                </span>
              </div>

              <div>
                <h3 className="text-base font-bold text-slate-900">
                  {isBangla ? rep.title_bn || rep.title : rep.title}
                </h3>
                <p className="text-xs text-slate-500 mt-1 leading-relaxed">
                  {isBangla ? rep.desc_bn || rep.desc : rep.desc}
                </p>
              </div>

              <div className="pt-2 flex items-center gap-2 text-xs text-slate-400 font-mono">
                <span className="text-[11px]">Size: {rep.size}</span>
                <span>•</span>
                <span className="text-emerald-700 flex items-center gap-1 font-semibold text-[11px]">
                  <ShieldCheck className="w-3.5 h-3.5" />
                  {isBangla ? "যাচাইকৃত" : "Verified SHA-256"}
                </span>
              </div>
            </div>

            <button
              onClick={() => handleDownload(rep)}
              className="w-full py-2.5 px-3 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold flex items-center justify-center gap-2 transition-all shadow-xs cursor-pointer"
            >
              <Download className="w-3.5 h-3.5" />
              <span>{isBangla ? "স্টেটমেন্ট ডাউনলোড করুন" : "Download Verified Package"}</span>
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
