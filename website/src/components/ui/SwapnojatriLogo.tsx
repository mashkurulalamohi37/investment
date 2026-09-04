"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";

interface SwapnojatriLogoProps {
  className?: string;
  size?: "sm" | "md" | "lg" | "xl";
  showText?: boolean;
}

export default function SwapnojatriLogo({
  className = "",
  size = "md",
  showText = true,
}: SwapnojatriLogoProps) {
  const { isBangla } = useAuth();

  const sizePx = {
    sm: 32,
    md: 44,
    lg: 56,
    xl: 80,
  };
  const px = sizePx[size] || 44;

  return (
    <div className={`flex items-center gap-3 ${className}`}>
      {/* Official Swapnojatri Suitcase + Flight Arrow Emblem */}
      <div
        className="shrink-0 relative flex items-center justify-center overflow-hidden"
        style={{ width: px, height: px, minWidth: px, minHeight: px, maxWidth: px, maxHeight: px }}
      >
        <img
          src="/swapnojatri_logo.svg"
          alt="স্বপ্নযাত্রী"
          width={px}
          height={px}
          style={{ width: px, height: px, objectFit: "contain" }}
          className="drop-shadow-md"
        />
      </div>

      {showText && (
        <div className="flex flex-col">
          <span className="font-black text-xl tracking-tight text-slate-900 leading-tight">
            {isBangla ? "স্বপ্নযাত্রী" : "Swapnojatri"}
          </span>
          <span className="text-[10px] font-bold text-sky-700 uppercase tracking-widest">
            {isBangla ? "ইনভেস্টমেন্ট প্ল্যাটফর্ম" : "Investment Platform"}
          </span>
        </div>
      )}
    </div>
  );
}
