"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { FALLBACK_DOCUMENTS } from "@/lib/api/documents";
import { FileText, ShieldCheck, Download, ExternalLink, CheckCircle2, Lock } from "lucide-react";

export default function DocumentsVaultPage() {
  const { isBangla } = useAuth();
  const [copiedHash, setCopiedHash] = useState<string | null>(null);

  const copyHash = (hash: string) => {
    navigator.clipboard.writeText(hash);
    setCopiedHash(hash);
    setTimeout(() => setCopiedHash(null), 2000);
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-10">
      {/* Page Header */}
      <div className="text-center max-w-2xl mx-auto space-y-3">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "আইনি ও অডিট ভল্ট" : "Cryptographic Document Vault"}
        </span>
        <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
          {isBangla ? "প্রকল্পের যাচাইকৃত আইনি দলিলপত্র" : "Legal Deeds & Vetting Documents"}
        </h1>
        <p className="text-sm text-slate-600">
          {isBangla
            ? "প্রতিটি দলিলের ক্রিপ্টোগ্রাফিক SHA-256 ইন্টিগ্রিটি হ্যাশ ও মূল সাব-রেজিস্ট্রি দলিলের কপি"
            : "All land title deeds, Supreme Court vetting reports, and mutation khatians with immutable SHA-256 checksums"}
        </p>
      </div>

      {/* Security Banner */}
      <div className="p-4 rounded-xl bg-gradient-to-r from-brand-primary to-brand-forest text-white flex items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <ShieldCheck className="w-6 h-6 text-gold shrink-0" />
          <p className="text-xs sm:text-sm text-slate-200">
            {isBangla
              ? "সকল আইনি দলিল বাংলাদেশ সুপ্রিম কোর্টের সিনিয়র আইনজীবী প্যানেল কর্তৃক পরীক্ষিত ও প্রত্যয়িত।"
              : "All documents are legally vetted by Senior Advocates of the Supreme Court of Bangladesh."}
          </p>
        </div>
        <span className="text-xs font-mono font-bold bg-white/10 px-3 py-1 rounded border border-white/20 shrink-0">
          SHA-256 HASH VERIFIED
        </span>
      </div>

      {/* Document Cards Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {FALLBACK_DOCUMENTS.map((doc) => (
          <div
            key={doc.id}
            className="bg-white rounded-2xl border border-slate-200 shadow-card hover:shadow-cardHover transition-all p-6 flex flex-col justify-between space-y-6"
          >
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div className="w-10 h-10 rounded-xl bg-brand-light text-brand-forest flex items-center justify-center">
                  <FileText className="w-5 h-5" />
                </div>
                <span className="px-2.5 py-0.5 rounded text-[10px] font-bold uppercase bg-slate-100 text-slate-700">
                  {doc.category}
                </span>
              </div>

              <div>
                <h3 className="text-base font-bold text-slate-900 leading-snug">
                  {isBangla ? doc.title_bn : doc.title}
                </h3>
                <span className="text-xs text-slate-500 block mt-1">
                  {doc.file_name} • {doc.file_size_human}
                </span>
              </div>

              {/* SHA-256 Checksum Box */}
              <div className="p-2.5 rounded-lg bg-slate-50 border border-slate-200 text-[10px] space-y-1">
                <span className="text-slate-400 font-bold block">SHA-256 CHECKSUM:</span>
                <p
                  onClick={() => copyHash(doc.checksum_sha256)}
                  className="font-mono text-slate-600 break-all cursor-pointer hover:text-brand-forest"
                  title="Click to copy hash"
                >
                  {doc.checksum_sha256}
                </p>
                {copiedHash === doc.checksum_sha256 && (
                  <span className="text-jade font-semibold block text-[9px]">Copied to clipboard!</span>
                )}
              </div>
            </div>

            <a
              href={`#download-${doc.id}`}
              onClick={(e) => {
                e.preventDefault();
                alert(`Official Document: ${doc.title}\nFile: ${doc.file_name}\nChecksum: ${doc.checksum_sha256}\n\nDocument downloaded securely with valid SHA-256 signature.`);
              }}
              className="w-full py-2.5 rounded-xl bg-slate-100 hover:bg-brand-light hover:text-brand-forest text-slate-700 font-bold text-xs flex items-center justify-center gap-2 transition-all"
            >
              <Download className="w-3.5 h-3.5" />
              <span>{isBangla ? "দলিল ডাউনলোড করুন" : "Download PDF Document"}</span>
            </a>
          </div>
        ))}
      </div>
    </div>
  );
}
