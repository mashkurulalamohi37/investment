"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  FileText,
  Download,
  ShieldCheck,
  CheckCircle2,
  Copy,
  Check,
  Sparkles,
  Lock,
  Layers,
  FileCheck2,
} from "lucide-react";

export default function DocumentsPage() {
  const { isBangla } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [downloadingId, setDownloadingId] = useState<string | null>(null);

  const copyHash = (hash: string, id: string) => {
    navigator.clipboard.writeText(hash);
    setCopiedKey(id);
    setTimeout(() => setCopiedKey(null), 2000);
  };

  const handleDownload = (id: string, name: string) => {
    setDownloadingId(id);
    setTimeout(() => {
      setDownloadingId(null);
      alert(
        isBangla
          ? `"${name}" এর অফিসিয়াল অডিট কপি ভল্ট থেকে প্রস্তুত হয়েছে।`
          : `Official audited document "${name}" prepared from vault.`
      );
    }, 800);
  };

  const docs = [
    {
      id: "doc-01",
      title: isBangla ? "ল্যান্ডভেস্ট ১০০ পার্টনারশিপ কাঠামো ও ডিড" : "LandVest 100 Partnership Deed & Framework",
      type: "PDF",
      size: "2.4 MB",
      date: "2026-08-01",
      hash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      category: isBangla ? "আইনি পার্টনারশিপ" : "Legal Deed",
    },
    {
      id: "doc-02",
      title: isBangla ? "সিটি ব্যাংক এসক্রো ক্লিয়ারিং এগ্রিমেন্ট" : "The City Bank PLC Escrow Trust Agreement",
      type: "PDF",
      size: "1.8 MB",
      date: "2026-08-05",
      hash: "8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4",
      category: isBangla ? "এসক্রো ট্রাস্ট" : "Escrow Trust",
    },
    {
      id: "doc-03",
      title: isBangla ? "ভাউচার অডিট রিপোর্ট ও রসিদ সংকলন" : "Audited Expense Vouchers & Disbursement Ledger",
      type: "PDF",
      size: "4.1 MB",
      date: "2026-08-28",
      hash: "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb",
      category: isBangla ? "অডিট লেজার" : "Audit Statement",
    },
    {
      id: "doc-04",
      title: isBangla ? "ডিজিটাল জিপিএস সার্ভে ও সীমানা জরিপ রিপোর্ট" : "Digital Cadastral GPS Survey & Site Demarcation",
      type: "PDF",
      size: "3.2 MB",
      date: "2026-08-25",
      hash: "fb8e20fc2e4c3f248c60c39bd652f3c1347298ab97b6b90723a12361b2e2d537",
      category: isBangla ? "সার্ভে ম্যাপ" : "Cadastral Survey",
    },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <FileCheck2 className="w-3.5 h-3.5" />
          <span>{isBangla ? "অফিসিয়াল ডকুমেন্ট ভল্ট" : "Official Cryptographic Vault"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "যাচাইকৃত নথি ও অডিট সার্টিফিকেট" : "Verified Documents & SHA-256 Vault"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "প্ল্যাটফর্মের প্রতিটি আইনি চুক্তি ও অডিট ভাউচার SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশ সহ সংরক্ষিত।"
            : "Every legal partnership deed and audited expense report stored with immutable SHA-256 checksums."}
        </p>
      </div>

      {/* 2. Compact 2-Col Documents Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-6">
        {docs.map((d) => (
          <div
            key={d.id}
            className="bg-white rounded-3xl border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all p-6 space-y-4 flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="px-3 py-1 rounded-full text-[10px] font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100">
                  {d.category}
                </span>
                <span className="text-xs font-mono font-semibold text-slate-500">{d.size} • {d.date}</span>
              </div>

              <h3 className="text-base font-extrabold text-[#0A2540]">
                {d.title}
              </h3>

              {/* SHA-256 Hash Box */}
              <div className="p-3 rounded-2xl bg-[#F8FAFC] border border-slate-200/80 flex items-center justify-between gap-2">
                <div className="overflow-hidden">
                  <span className="text-[9px] uppercase font-mono font-bold text-slate-400 block">
                    SHA-256 Checksum Hash
                  </span>
                  <span className="text-[11px] font-mono text-slate-600 truncate block">
                    {d.hash}
                  </span>
                </div>
                <button
                  type="button"
                  onClick={() => copyHash(d.hash, d.id)}
                  className="p-1.5 rounded-lg text-slate-400 hover:text-[#0066FF] hover:bg-white transition-all shrink-0 cursor-pointer"
                  title="Copy Hash"
                >
                  {copiedKey === d.id ? <Check className="w-4 h-4 text-emerald-600" /> : <Copy className="w-4 h-4" />}
                </button>
              </div>
            </div>

            <button
              type="button"
              disabled={downloadingId === d.id}
              onClick={() => handleDownload(d.id, d.title)}
              className="w-full py-3 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-extrabold shadow-sm transition-all flex items-center justify-center gap-2 cursor-pointer"
            >
              <Download className="w-3.5 h-3.5 text-[#00B4D8]" />
              <span>
                {downloadingId === d.id
                  ? isBangla ? "প্রস্তুত হচ্ছে..." : "Preparing..."
                  : isBangla ? "অফিসিয়াল কপি ডাউনলোড করুন" : "Download Verified Copy"}
              </span>
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
