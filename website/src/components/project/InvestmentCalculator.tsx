"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Calculator, ArrowRight, ShieldCheck, Sparkles, Check, TrendingUp } from "lucide-react";

interface InvestmentCalculatorProps {
  pricePerShare?: number;
  minShares?: number;
  maxShares?: number;
  targetRoiMin?: number;
  targetRoiMax?: number;
  onInvestClick?: (shares: number) => void;
}

export default function InvestmentCalculator({
  pricePerShare = 25500,
  minShares = 1,
  maxShares = 4,
  targetRoiMin = 18.5,
  targetRoiMax = 22.0,
  onInvestClick,
}: InvestmentCalculatorProps) {
  const [shares, setShares] = useState(1);
  const { isBangla, isAuthenticated } = useAuth();

  const totalAmount = shares * pricePerShare;
  const equitySharePercent = (shares / 100) * 100;
  const estimatedMinAnnualRoi = (totalAmount * targetRoiMin) / 100;
  const estimatedMaxAnnualRoi = (totalAmount * targetRoiMax) / 100;

  return (
    <div className="bg-white rounded-3xl border border-slate-200/90 shadow-2xl shadow-blue-950/5 p-6 sm:p-8 relative overflow-hidden">
      {/* Top Accent Gradient Bar */}
      <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-cyan via-brand-emerald to-blue-500" />

      {/* Header */}
      <div className="flex items-center justify-between mb-6 pb-4 border-b border-slate-100">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-2xl bg-brand-light text-brand-emerald flex items-center justify-center font-bold shadow-inner">
            <Calculator className="w-5 h-5" />
          </div>
          <div>
            <h3 className="font-extrabold text-slate-900 text-base sm:text-lg tracking-tight">
              {isBangla ? "বিনিয়োগ ও লভ্যাংশ ক্যালকুলেটর" : "Investment Calculator"}
            </h3>
            <p className="text-[11px] text-slate-500">
              {isBangla ? "ল্যান্ডভেস্ট ১০০ (১ থেকে ৪টি শেয়ার)" : "LandVest 100 (1 to 4 fixed units)"}
            </p>
          </div>
        </div>
        <span className="px-3 py-1 rounded-full text-[11px] font-mono font-bold bg-blue-50 text-blue-700 border border-blue-200">
          {formatBDT(pricePerShare, { isBangla })} / {isBangla ? "ভাগ" : "unit"}
        </span>
      </div>

      {/* Share Selector Stepper */}
      <div className="space-y-3 mb-6">
        <div className="flex items-center justify-between text-xs font-bold text-slate-700">
          <span>{isBangla ? "শেয়ারের সংখ্যা নির্বাচন করুন:" : "Select Number of Shares:"}</span>
          <span className="text-[11px] font-medium text-slate-500">
            {isBangla ? "সর্বোচ্চ ৪টি শেয়ারের লিমিট" : "Max 4 units limit"}
          </span>
        </div>

        {/* Quick Stepper Buttons */}
        <div className="grid grid-cols-4 gap-2.5">
          {[1, 2, 3, 4].map((num) => {
            const isSelected = shares === num;
            return (
              <button
                key={num}
                type="button"
                onClick={() => setShares(num)}
                className={`py-3 px-1 rounded-2xl font-bold text-sm transition-all flex flex-col items-center justify-center gap-0.5 border ${
                  isSelected
                    ? "bg-[#0066FF] text-white border-[#0066FF] shadow-lg shadow-blue-600/30 scale-[1.03]"
                    : "bg-slate-50 text-slate-700 border-slate-200/90 hover:bg-blue-50/60 hover:border-blue-400"
                }`}
              >
                <span className={isSelected ? "text-white font-extrabold" : "text-slate-800 font-bold"}>
                  {isBangla ? `${num} ভাগ` : `${num} Share${num > 1 ? "s" : ""}`}
                </span>
                <span className={`text-[11px] font-mono tracking-tight ${isSelected ? "text-white font-bold drop-shadow-sm" : "text-slate-600 font-semibold"}`}>
                  {formatBDT(num * pricePerShare, { isBangla, showSymbol: true })}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Financial Output Summary Matrix */}
      <div className="bg-slate-50/80 rounded-2xl p-5 border border-slate-200/90 space-y-3 mb-6">
        <div className="flex items-center justify-between pb-3 border-b border-slate-200/60">
          <span className="text-xs font-semibold text-slate-600">
            {isBangla ? "মোট বিনিয়োগের পরিমাণ:" : "Authoritative Investment Amount:"}
          </span>
          <span className="text-2xl font-black text-[#0066FF] font-mono tracking-tight">
            {formatBDT(totalAmount, { isBangla })}
          </span>
        </div>

        <div className="grid grid-cols-2 gap-4 pt-1 text-xs">
          <div>
            <span className="text-slate-500 block text-[11px] font-medium">
              {isBangla ? "প্রকল্পে ইকুইটি মালিকানা:" : "Project Equity Share:"}
            </span>
            <span className="font-extrabold text-slate-900 text-sm font-mono">
              {equitySharePercent.toFixed(1)}% {isBangla ? "অংশীদারিত্ব" : "of Total 100 Shares"}
            </span>
          </div>
          <div>
            <span className="text-slate-500 block text-[11px] font-medium">
              {isBangla ? "প্রত্যাশিত বার্ষিক রিটার্ন:" : "Projected Annual ROI:"}
            </span>
            <span className="font-extrabold text-emerald-700 text-sm font-mono">
              {targetRoiMin}% - {targetRoiMax}% ROI
            </span>
          </div>
        </div>

        <div className="bg-white rounded-xl p-3 border border-slate-200/80 flex items-center justify-between text-xs">
          <span className="text-slate-700 font-semibold">
            {isBangla ? "প্রত্যাশিত বার্ষিক লভ্যাংশ:" : "Est. Annual Return Range:"}
          </span>
          <span className="font-bold text-[#0066FF] font-mono text-xs">
            {formatBDT(estimatedMinAnnualRoi, { isBangla })} – {formatBDT(estimatedMaxAnnualRoi, { isBangla })}
          </span>
        </div>
      </div>

      {/* Call to Action Button */}
      {onInvestClick ? (
        <button
          onClick={() => onInvestClick(shares)}
          className="w-full py-4 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white font-extrabold text-sm flex items-center justify-center gap-2 shadow-lg shadow-blue-600/30 hover:shadow-blue-600/40 transition-all group"
        >
          <span>{isBangla ? "অনলাইনে শেয়ার বুক করুন" : `Proceed with ${shares} Share${shares > 1 ? "s" : ""}`}</span>
          <ArrowRight className="w-4 h-4 text-white transition-transform group-hover:translate-x-1" />
        </button>
      ) : (
        <Link
          href={isAuthenticated ? `/dashboard/investments/new?shares=${shares}` : `/login?redirect=/dashboard/investments/new?shares=${shares}`}
          className="w-full py-4 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white font-extrabold text-sm flex items-center justify-center gap-2 shadow-lg shadow-blue-600/30 hover:shadow-blue-600/40 transition-all group"
        >
          <span>{isBangla ? "বিনিয়োগ সম্পন্ন করতে এগিয়ে যান" : `Invest in ${shares} Share${shares > 1 ? "s" : ""} (${formatBDT(totalAmount, { isBangla })})`}</span>
          <ArrowRight className="w-4 h-4 text-white transition-transform group-hover:translate-x-1" />
        </Link>
      )}

      <p className="mt-3.5 text-[11px] text-center text-slate-500 flex items-center justify-center gap-1.5 font-medium">
        <ShieldCheck className="w-3.5 h-3.5 text-[#0066FF] shrink-0" />
        <span>{isBangla ? "দ্য সিটি ব্যাংক পিএলসি এসক্রো অ্যাকাউন্টে ১০০% সুরক্ষিত" : "100% Escrow Secured with The City Bank PLC"}</span>
      </p>
    </div>
  );
}
