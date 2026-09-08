"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { useCms } from "@/lib/cms/useCms";
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
  const { isBangla, isAuthenticated } = useAuth();
  const { documents: docsConfig } = useCms();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [downloadingId, setDownloadingId] = useState<string | null>(null);

  const copyHash = (hash: string, id: string) => {
    navigator.clipboard.writeText(hash);
    setCopiedKey(id);
    setTimeout(() => setCopiedKey(null), 2000);
  };

  const handleDownload = (id: string, name: string, url: string) => {
    setDownloadingId(id);
    setTimeout(() => {
      setDownloadingId(null);
      if (url && url.startsWith("http")) {
        window.open(url, "_blank");
      } else {
        alert(
          isBangla
            ? `"${name}" এর অফিসিয়াল অডিট কপি ভল্ট থেকে প্রস্তুত হয়েছে।`
            : `Official audited document "${name}" prepared from vault.`
        );
      }
    }, 600);
  };

  const docs = docsConfig.documents || [];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <FileCheck2 className="w-3.5 h-3.5" />
          <span>{isBangla ? docsConfig.header.badgeBn : docsConfig.header.badge}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? docsConfig.header.titleBn : docsConfig.header.title}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla ? docsConfig.header.subtitleBn : docsConfig.header.subtitle}
        </p>
      </div>

      {/* 2. Compact 2-Col Documents Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-6">
        {docs.map((d) => {
          const docTitle = isBangla ? d.titleBn || d.title : d.title;
          const isRestricted = d.visibility === "INVESTOR_ONLY" && !isAuthenticated;

          return (
            <div
              key={d.id}
              className="bg-white rounded-3xl border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all p-6 space-y-4 flex flex-col justify-between"
            >
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <span className="px-3 py-1 rounded-full text-[10px] font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100">
                    {isBangla ? d.categoryBn || d.category : d.category}
                  </span>
                  <div className="flex items-center gap-2">
                    {d.visibility === "INVESTOR_ONLY" && (
                      <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-amber-50 text-amber-700 border border-amber-200 flex items-center gap-1">
                        <Lock className="w-3 h-3" />
                        {isBangla ? "বিনিয়োগকারী" : "Investor Only"}
                      </span>
                    )}
                    <span className="text-xs font-mono font-semibold text-slate-500">{d.size} • {d.date}</span>
                  </div>
                </div>

                <h3 className="text-base font-extrabold text-[#0A2540]">
                  {docTitle}
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
                onClick={() => {
                  if (isRestricted) {
                    alert(isBangla ? "এই ডকুমেন্টটি দেখতে অনুগ্রহ করে বিনিয়োগকারী অ্যাকাউন্টে লগইন করুন।" : "Please log in to your investor account to access this legal deed.");
                    return;
                  }
                  handleDownload(d.id, docTitle, d.fileUrl);
                }}
                className={`w-full py-3 rounded-full text-xs font-extrabold shadow-sm transition-all flex items-center justify-center gap-2 cursor-pointer ${
                  isRestricted
                    ? "bg-slate-100 text-slate-500 hover:bg-slate-200"
                    : "bg-[#0066FF] hover:bg-[#0052CC] text-white"
                }`}
              >
                {isRestricted ? (
                  <>
                    <Lock className="w-3.5 h-3.5" />
                    <span>{isBangla ? "লগইন করে ডাউনলোড করুন" : "Investor Login Required"}</span>
                  </>
                ) : (
                  <>
                    <Download className="w-3.5 h-3.5 text-[#00B4D8]" />
                    <span>
                      {downloadingId === d.id
                        ? isBangla ? "প্রস্তুত হচ্ছে..." : "Preparing..."
                        : isBangla ? "অফিসিয়াল কপি ডাউনলোড করুন" : "Download Verified Copy"}
                    </span>
                  </>
                )}
              </button>
            </div>
          );
        })}
      </div>
    </div>
  );
}
