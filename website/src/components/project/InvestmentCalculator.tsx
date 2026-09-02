"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Calculator, ArrowRight, ShieldCheck, Sparkles, Check } from "lucide-react";

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
    <div className="bg-white rounded-2xl border border-slate-200/90 shadow-cardHover p-6 sm:p-8 relative overflow-hidden">
      {/* Decorative Gradient Pill */}
      <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-gold via-brand-emerald to-jade" />

      <div className="flex items-center justify-between mb-6 pb-4 border-b border-slate-100">
        <div className="flex items-center gap-2.5">
          <div className="w-9 h-9 rounded-xl bg-gold/10 text-gold-dark flex items-center justify-center font-bold">
            <Calculator className="w-5 h-5" />
          </div>
          <div>
            <h3 className="font-bold text-slate-900 text-base sm:text-lg">
              {isBangla ? "ইনভেস্টমেন্ট ও সম্ভাব্য লভ্যাংশ ক্যালকুলেটর" : "Investment & ROI Calculator"}
            </h3>
            <p className="text-xs text-slate-500">
              {isBangla ? "ল্যান্ডভেস্ট ১০০ (১ থেকে ৪টি শেয়ার নির্বাচন করুন)" : "LandVest 100 (Select 1 to 4 shares limit)"}
            </p>
          </div>
        </div>
        <span className="px-2.5 py-1 rounded-full text-xs font-bold bg-brand-light text-brand-forest">
          {isBangla ? "নির্ধারিত মূল্য" : "Fixed Pricing"}
        </span>
      </div>

      {/* Share Selector Stepper */}
      <div className="space-y-4 mb-6">
        <div className="flex items-center justify-between text-sm font-semibold text-slate-700">
          <span>{isBangla ? "শেয়ারের সংখ্যা নির্বাচন:" : "Select Number of Shares:"}</span>
          <span className="text-xs font-normal text-slate-500">
            {isBangla ? "বিনিয়োগকারী প্রতি সর্বোচ্চ ৪টি" : "Max 4 shares per investor"}
          </span>
        </div>

        {/* Quick Stepper Buttons */}
        <div className="grid grid-cols-4 gap-2.5 sm:gap-3">
          {[1, 2, 3, 4].map((num) => {
            const isSelected = shares === num;
            return (
              <button
                key={num}
                type="button"
                onClick={() => setShares(num)}
                className={`py-3 rounded-xl font-bold text-sm sm:text-base transition-all flex flex-col items-center justify-center gap-0.5 border ${
                  isSelected
                    ? "bg-brand-forest text-white border-brand-forest shadow-md shadow-brand-forest/20 scale-[1.02]"
                    : "bg-slate-50 text-slate-700 border-slate-200 hover:bg-slate-100 hover:border-slate-300"
                }`}
              >
                <span>{isBangla ? `${num}টি ভাগ` : `${num} Share${num > 1 ? "s" : ""}`}</span>
                <span className={`text-[10px] font-normal ${isSelected ? "text-gold" : "text-slate-500"}`}>
                  {formatBDT(num * pricePerShare, { isBangla, showSymbol: true })}
                </span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Financial Output Summary Matrix */}
      <div className="bg-canvas-light rounded-xl p-5 border border-slate-200/80 space-y-3 mb-6">
        <div className="flex items-center justify-between pb-3 border-b border-slate-200/60">
          <span className="text-xs font-medium text-slate-500">
            {isBangla ? "মোট বিনিয়োগের পরিমাণ:" : "Authoritative Total Investment:"}
          </span>
          <span className="text-xl sm:text-2xl font-black text-brand-forest">
            {formatBDT(totalAmount, { isBangla })}
          </span>
        </div>

        <div className="grid grid-cols-2 gap-3 pt-1 text-xs">
          <div>
            <span className="text-slate-500 block">
              {isBangla ? "প্রকল্পে ইকুইটি মালিকানা:" : "Project Equity Share:"}
            </span>
            <span className="font-bold text-slate-900 text-sm">
              {equitySharePercent.toFixed(1)}% {isBangla ? "মালিকানা" : "of Total 100 Shares"}
            </span>
          </div>
          <div>
            <span className="text-slate-500 block">
              {isBangla ? "প্রত্যাশিত বার্ষিক লভ্যাংশ:" : "Target Annual Projected Return:"}
            </span>
            <span className="font-bold text-jade-dark text-sm">
              {targetRoiMin}% - {targetRoiMax}% ROI
            </span>
          </div>
        </div>

        <div className="bg-white rounded-lg p-2.5 border border-slate-200/60 flex items-center justify-between text-xs">
          <span className="text-slate-600">
            {isBangla ? "প্রত্যাশিত বার্ষিক আয় (হিসাব):" : "Est. Annual Return Range:"}
          </span>
          <span className="font-bold text-gold-dark font-mono">
            {formatBDT(estimatedMinAnnualRoi, { isBangla })} – {formatBDT(estimatedMaxAnnualRoi, { isBangla })}
          </span>
        </div>
      </div>

      {/* Call to Action Button */}
      {onInvestClick ? (
        <button
          onClick={() => onInvestClick(shares)}
          className="w-full py-4 rounded-xl bg-gradient-emerald text-white font-bold text-base flex items-center justify-center gap-2 hover:opacity-95 shadow-lg shadow-brand-forest/20 transition-all"
        >
          <span>{isBangla ? "অনলাইনে শেয়ার বুক করুন" : `Proceed with ${shares} Share${shares > 1 ? "s" : ""}`}</span>
          <ArrowRight className="w-5 h-5 text-gold" />
        </button>
      ) : (
        <Link
          href={isAuthenticated ? `/dashboard/investments/new?shares=${shares}` : `/login?redirect=/dashboard/investments/new?shares=${shares}`}
          className="w-full py-4 rounded-xl bg-gradient-emerald text-white font-bold text-base flex items-center justify-center gap-2 hover:opacity-95 shadow-lg shadow-brand-forest/20 transition-all"
        >
          <span>{isBangla ? "বিনিয়োগ সম্পন্ন করতে এগিয়ে যান" : `Invest in ${shares} Share${shares > 1 ? "s" : ""} (${formatBDT(totalAmount, { isBangla })})`}</span>
          <ArrowRight className="w-5 h-5 text-gold" />
        </Link>
      )}

      <p className="mt-3 text-[11px] text-center text-slate-400 flex items-center justify-center gap-1.5">
        <ShieldCheck className="w-3.5 h-3.5 text-jade" />
        <span>{isBangla ? "সিটি ব্যাংক এসক্রো অ্যাকাউন্ট ও আইনি দলিল সুরক্ষিত" : "Protected by City Bank Escrow & Vetted Sub-Registry Deed"}</span>
      </p>
    </div>
  );
}
