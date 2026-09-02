"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldCheck, Info } from "lucide-react";

interface ShareMatrixGridProps {
  totalShares?: number;
  allocatedShares?: number;
  userOwnedLots?: string[];
  onSelectLot?: (lotNumber: number) => void;
}

export default function ShareMatrixGrid({
  totalShares = 100,
  allocatedShares = 74,
  userOwnedLots = ["LOT-041", "LOT-042", "LOT-043", "LOT-044"],
  onSelectLot,
}: ShareMatrixGridProps) {
  const [hoveredLot, setHoveredLot] = useState<number | null>(null);
  const { isBangla } = useAuth();

  const userLotsSet = new Set(userOwnedLots);

  return (
    <div className="bg-white rounded-2xl border border-slate-200/90 shadow-card p-6 sm:p-8">
      {/* Matrix Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6 pb-4 border-b border-slate-100">
        <div>
          <h3 className="font-bold text-slate-900 text-base sm:text-lg flex items-center gap-2">
            <span>{isBangla ? "ল্যান্ডভেস্ট ১০০ শেয়ার লট ম্যাট্রিক্স" : "LandVest 100 Share Lot Matrix"}</span>
            <span className="px-2 py-0.5 rounded text-xs font-mono font-bold bg-brand-light text-brand-forest">
              10x10 Map
            </span>
          </h3>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "১০০টি সুনির্দিষ্ট শেয়ার লটের রিয়েল-টাইম বণ্টন ম্যাপ"
              : "Real-time visual map of all 100 sequential project share allocations"}
          </p>
        </div>

        {/* Legend */}
        <div className="flex flex-wrap items-center gap-3 text-xs">
          <div className="flex items-center gap-1.5">
            <div className="w-3.5 h-3.5 rounded bg-brand-forest" />
            <span className="text-slate-600">{isBangla ? "বরাদ্দকৃত (৭৪)" : "Allocated (74)"}</span>
          </div>
          <div className="flex items-center gap-1.5">
            <div className="w-3.5 h-3.5 rounded bg-gold shadow-sm" />
            <span className="text-slate-600 font-semibold text-slate-900">
              {isBangla ? "আপনার লট (৪)" : "Your Lots (4)"}
            </span>
          </div>
          <div className="flex items-center gap-1.5">
            <div className="w-3.5 h-3.5 rounded bg-slate-100 border border-slate-300" />
            <span className="text-slate-600">{isBangla ? "উন্মুক্ত (২৬)" : "Available (26)"}</span>
          </div>
        </div>
      </div>

      {/* 10x10 Matrix Grid */}
      <div className="grid grid-cols-10 gap-1.5 sm:gap-2 p-3 sm:p-4 rounded-xl bg-canvas-light border border-slate-200/80">
        {Array.from({ length: totalShares }, (_, i) => {
          const lotNum = i + 1;
          const lotStr = `LOT-${String(lotNum).padStart(3, "0")}`;
          const isUserOwned = userLotsSet.has(lotStr);
          const isAllocated = lotNum <= allocatedShares && !isUserOwned;
          const isAvailable = lotNum > allocatedShares;

          return (
            <div
              key={lotNum}
              onMouseEnter={() => setHoveredLot(lotNum)}
              onMouseLeave={() => setHoveredLot(null)}
              onClick={() => isAvailable && onSelectLot && onSelectLot(lotNum)}
              className={`aspect-square rounded-md flex items-center justify-center font-mono text-[9px] sm:text-[11px] font-bold transition-all relative cursor-pointer ${
                isUserOwned
                  ? "bg-gold text-slate-950 ring-2 ring-gold-light ring-offset-1 shadow-goldGlow z-10 scale-105"
                  : isAllocated
                  ? "bg-brand-forest text-white/90"
                  : "bg-white text-slate-700 border border-slate-300 hover:border-brand-emerald hover:bg-brand-light hover:text-brand-forest"
              }`}
              title={`${lotStr} - ${isUserOwned ? "Owned by You" : isAllocated ? "Allocated" : "Available to Invest"}`}
            >
              {lotNum}
            </div>
          );
        })}
      </div>

      {/* Hover Information Banner */}
      <div className="mt-4 p-3 rounded-lg bg-slate-50 border border-slate-200 flex items-center justify-between text-xs">
        <div className="flex items-center gap-2 text-slate-600">
          <Info className="w-4 h-4 text-brand-forest" />
          <span>
            {hoveredLot
              ? `${isBangla ? "নির্বাচিত লট:" : "Selected:"} LOT-${String(hoveredLot).padStart(3, "0")} • ${
                  userLotsSet.has(`LOT-${String(hoveredLot).padStart(3, "0")}`)
                    ? isBangla
                      ? "আপনার সক্রিয় শেয়ার"
                      : "Verified in Your Portfolio"
                    : hoveredLot <= allocatedShares
                    ? isBangla
                      ? "অন্য বিনিয়োগকারী কর্তৃক সংরক্ষিত"
                      : "Allocated to Verified Investor"
                    : isBangla
                    ? "বিনিয়োগের জন্য উন্মুক্ত (৳ ২৫,৫০০)"
                    : "Available for Instant Subscription (৳ 25,500)"
                }`
              : isBangla
              ? "যেকোনো লটের ওপর কার্সর রেখে বিস্তারিত অবস্থা দেখুন"
              : "Hover over any lot square to view allocation metadata"}
          </span>
        </div>
        <span className="font-mono font-bold text-brand-forest">
          {allocatedShares} / {totalShares} {isBangla ? "সম্পন্ন" : "Shares"}
        </span>
      </div>
    </div>
  );
}
