"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Building2, Copy, Check, Upload, X, ShieldCheck, ArrowRight, Image as ImageIcon } from "lucide-react";

interface BankTransferModalProps {
  shares: number;
  totalAmount: number;
  onClose: () => void;
  onSubmit: (data: { depositBankName: string; depositorName: string; paymentReference: string; receiptImageUrl: string }) => void;
}

export default function BankTransferModal({
  shares,
  totalAmount,
  onClose,
  onSubmit,
}: BankTransferModalProps) {
  const { isBangla, user } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [depositorName, setDepositorName] = useState(user?.full_name || "");
  const [bankName, setBankName] = useState("The City Bank PLC");
  const [slipRef, setSlipRef] = useState("");
  const [receiptImage, setReceiptImage] = useState<string | null>(null);

  const copyToClipboard = (text: string, key: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(key);
    setTimeout(() => setCopiedKey(null), 2000);
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const url = URL.createObjectURL(file);
      setReceiptImage(url);
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!slipRef) {
      alert("Please enter bank deposit slip reference.");
      return;
    }
    onSubmit({
      depositBankName: bankName,
      depositorName,
      paymentReference: slipRef,
      receiptImageUrl: receiptImage || "https://vault.swapnojatri.com/receipts/sample_slip.jpg",
    });
  };

  return (
    <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 overflow-y-auto">
      <div className="bg-white rounded-3xl border border-slate-200 shadow-2xl max-w-lg w-full overflow-hidden my-8 animate-in fade-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="bg-slate-900 text-white p-6 relative">
          <button
            onClick={onClose}
            className="absolute top-4 right-4 p-1.5 rounded-full bg-white/10 hover:bg-white/20 text-white cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
          <div className="space-y-1">
            <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-emerald-500/20 text-emerald-400 text-[10px] font-bold">
              <Building2 className="w-3.5 h-3.5" /> {isBangla ? "ব্যাংক ডিপোজিট ও এসক্রো" : "BANK DEPOSIT & ESCROW"}
            </div>
            <h3 className="text-xl font-bold">
              {isBangla ? "ব্যাংক ট্রান্সফার ও ডিপোজিট স্লিপ আপলোড" : "Bank Transfer & Deposit Slip Upload"}
            </h3>
            <p className="text-xs text-slate-400">
              {isBangla
                ? `${formatBDT(totalAmount, { isBangla })} ট্রান্সফার করুন এবং জমার রসিদ আপলোড করুন`
                : `Transfer ${formatBDT(totalAmount, { isBangla })} & upload your deposit slip`}
            </p>
          </div>
        </div>

        {/* Form Body */}
        <form onSubmit={handleSubmit} className="p-6 space-y-6">
          {/* Company Bank Card */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 space-y-2 text-xs">
            <div className="flex items-center justify-between pb-2 border-b border-slate-200">
              <span className="font-bold text-slate-900">
                {isBangla ? "সিটি ব্যাংক এসক্রো হিসাব" : "City Bank Escrow Account"}
              </span>
              <span className="font-mono text-brand-forest font-black">1402-9988-7710-1</span>
            </div>
            <div className="flex items-center justify-between text-[11px] text-slate-500">
              <span>{isBangla ? "রাউটিং: ২২৫২৭৫৩৫৭ • গুলশান-১ শাখা" : "Routing: 225275357 • Gulshan-1 Branch"}</span>
              <button
                type="button"
                onClick={() => copyToClipboard("1402998877101", "acc")}
                className="font-bold text-brand-forest hover:underline cursor-pointer"
              >
                {copiedKey === "acc"
                  ? isBangla ? "কপি হয়েছে!" : "Copied!"
                  : isBangla ? "নাম্বার কপি করুন" : "Copy Number"}
              </button>
            </div>
          </div>

          {/* Form Inputs */}
          <div className="space-y-4 text-xs">
            <div>
              <label className="font-bold text-slate-700 block mb-1">
                {isBangla ? "জমাদানকারীর পূর্ণ নাম" : "Depositor Full Name"}
              </label>
              <input
                type="text"
                required
                value={depositorName}
                onChange={(e) => setDepositorName(e.target.value)}
                placeholder={isBangla ? "যেমন: মাশকুরুল আলম অহি" : "e.g. Mashkurul Alam Ohi"}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="font-bold text-slate-700 block mb-1">
                  {isBangla ? "জমার ব্যাংক" : "Deposit Bank"}
                </label>
                <input
                  type="text"
                  required
                  value={bankName}
                  onChange={(e) => setBankName(e.target.value)}
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
                />
              </div>
              <div>
                <label className="font-bold text-slate-700 block mb-1">
                  {isBangla ? "স্লিপ / ট্রানজেকশন রেফারেন্স নং" : "Slip / Txn Ref #"}
                </label>
                <input
                  type="text"
                  required
                  value={slipRef}
                  onChange={(e) => setSlipRef(e.target.value)}
                  placeholder="e.g. DEP-CB-98214"
                  className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none font-mono"
                />
              </div>
            </div>

            {/* Receipt Image Upload Box */}
            <div>
              <label className="font-bold text-slate-700 block mb-1">
                {isBangla ? "জমার রসিদের ছবি আপলোড করুন" : "Upload Deposit Receipt Photo"}
              </label>
              <div className="p-4 border-2 border-dashed border-slate-200 rounded-2xl text-center space-y-2 hover:border-brand-forest transition-colors relative">
                {receiptImage ? (
                  <div className="space-y-2">
                    <img src={receiptImage} alt="Deposit Slip" className="h-32 mx-auto rounded-lg object-cover border" />
                    <span className="text-[11px] text-emerald-600 font-semibold block">
                      {isBangla ? "ছবি সফলভাবে সংযুক্ত হয়েছে" : "Photo attached successfully"}
                    </span>
                  </div>
                ) : (
                  <>
                    <Upload className="w-8 h-8 text-slate-400 mx-auto" />
                    <span className="text-xs font-semibold text-slate-600 block">
                      {isBangla ? "ব্যাংক ডিপোজিট স্লিপের ছবি নির্বাচন করতে ক্লিক করুন" : "Click to upload bank deposit slip photo"}
                    </span>
                    <span className="text-[10px] text-slate-400 block">
                      {isBangla ? "পিএনজি, জেপিজি সর্বোচ্চ ১০ মেগাবাইট" : "PNG, JPG up to 10MB"}
                    </span>
                  </>
                )}
                <input
                  type="file"
                  accept="image/*"
                  onChange={handleFileChange}
                  className="absolute inset-0 opacity-0 cursor-pointer"
                />
              </div>
            </div>
          </div>

          {/* Submit */}
          <button
            type="submit"
            className="w-full py-4 rounded-xl bg-slate-900 text-white font-bold text-sm hover:bg-slate-800 shadow-lg flex items-center justify-center gap-2 transition-all cursor-pointer"
          >
            <span>
              {isBangla ? "যাচাইয়ের জন্য স্লিপ জমা দিন" : "Submit Slip for Admin Verification"}
            </span>
            <ArrowRight className="w-4 h-4 text-emerald-400" />
          </button>
        </form>
      </div>
    </div>
  );
}
