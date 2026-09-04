"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { initiateEpsSession } from "@/lib/api/payments";
import { ShieldCheck, CreditCard, CheckCircle2, ArrowRight, X, Loader2 } from "lucide-react";

interface EpsCheckoutModalProps {
  shares: number;
  totalAmount: number;
  onClose: () => void;
  onSuccess: (txnRef: string, lotNumbers: string[]) => void;
}

export default function EpsCheckoutModal({
  shares,
  totalAmount,
  onClose,
  onSuccess,
}: EpsCheckoutModalProps) {
  const { isBangla, user } = useAuth();
  const [selectedChannel, setSelectedChannel] = useState<"bKash" | "Nagad" | "Rocket" | "Cards" | "NetBanking">("bKash");
  const [loading, setLoading] = useState(false);

  const handlePayNow = async () => {
    setLoading(true);
    try {
      // Simulate/Initiate EPS gateway session
      setTimeout(() => {
        const txnId = `EPS-${selectedChannel.toUpperCase()}-${Date.now().toString().slice(-6)}`;
        const allocatedLots = Array.from({ length: shares }, (_, i) => `LOT-${String(74 + i + 1).padStart(3, "0")}`);
        onSuccess(txnId, allocatedLots);
      }, 1500);
    } catch (e) {
      console.error("EPS checkout failed", e);
      setLoading(false);
    }
  };

  const channels = [
    { id: "bKash", name: "bKash", desc: "Instant MFS Payment", icon: "🔴" },
    { id: "Nagad", name: "Nagad", desc: "Instant MFS Payment", icon: "🟠" },
    { id: "Rocket", name: "Rocket", desc: "DBBL Mobile Banking", icon: "🟣" },
    { id: "Cards", name: "Visa / Mastercard", desc: "Debit & Credit Cards", icon: "💳" },
    { id: "NetBanking", name: "Internet Banking", desc: "Citytouch, BRAC, EBL", icon: "🏛️" },
  ];

  return (
    <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4">
      <div className="bg-white rounded-3xl border border-slate-200 shadow-2xl max-w-lg w-full overflow-hidden animate-in fade-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="bg-[#0A2540] text-white p-6 relative">
          <button
            onClick={onClose}
            className="absolute top-4 right-4 p-1.5 rounded-full bg-white/10 hover:bg-white/20 text-white cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
          <div className="space-y-1">
            <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-[#0066FF]/20 text-cyan-light text-[10px] font-bold">
              <ShieldCheck className="w-3.5 h-3.5 text-[#00B4D8]" />
              <span>{isBangla ? "EPS গেটওয়ে সুরক্ষিত" : "EPS GATEWAY SECURED"}</span>
            </div>
            <h3 className="text-xl font-bold">
              {isBangla ? "EPS অনলাইন পেমেন্ট গেটওয়ে" : "EPS Payment Gateway Checkout"}
            </h3>
            <p className="text-xs text-slate-300">
              LandVest 100 • {isBangla ? `${shares}টি শেয়ার সাবস্ক্রিপশন` : `${shares} Share${shares > 1 ? "s" : ""} Subscription`}
            </p>
          </div>
        </div>

        {/* Body */}
        <div className="p-6 space-y-6">
          {/* Amount Badge */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 flex items-center justify-between">
            <div>
              <span className="text-xs text-slate-500 block">
                {isBangla ? "মোট পরিশোধযোগ্য পরিমাণ:" : "Total Payable Amount:"}
              </span>
              <span className="text-xl font-black text-[#0066FF] font-mono">
                {formatBDT(totalAmount, { isBangla })}
              </span>
            </div>
            <span className="text-xs font-bold text-slate-700 bg-white px-3 py-1.5 rounded-lg border border-slate-200">
              {shares} × {isBangla ? "৳ ২৫,৫০০" : "৳ 25,500"}
            </span>
          </div>

          {/* Payment Channel Options */}
          <div className="space-y-2.5">
            <label className="text-xs font-bold text-slate-700 block">
              {isBangla ? "পেমেন্ট মাধ্যম বেছে নিন:" : "Choose Payment Method:"}
            </label>
            <div className="space-y-2">
              {channels.map((ch) => {
                const isSelected = selectedChannel === ch.id;
                return (
                  <button
                    key={ch.id}
                    type="button"
                    onClick={() => setSelectedChannel(ch.id as any)}
                    className={`w-full p-3.5 rounded-xl border text-left flex items-center justify-between transition-all cursor-pointer ${
                      isSelected
                        ? "bg-blue-50/70 border-[#0066FF] ring-1 ring-[#0066FF] shadow-sm"
                        : "bg-white border-slate-200 hover:bg-slate-50"
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <span className="text-xl">{ch.icon}</span>
                      <div>
                        <span className="font-bold text-sm text-slate-900 block">{ch.name}</span>
                        <span className="text-[11px] text-slate-500">
                          {isBangla ? "তাৎক্ষণিক নিরাপদ পেমেন্ট" : ch.desc}
                        </span>
                      </div>
                    </div>
                    {isSelected && <CheckCircle2 className="w-5 h-5 text-[#0066FF]" />}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Action Button */}
          <button
            onClick={handlePayNow}
            disabled={loading}
            className="w-full py-4 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-sm shadow-lg shadow-[#0066FF]/20 flex items-center justify-center gap-2 transition-all cursor-pointer"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin text-cyan-light" />
                <span>{isBangla ? "EPS গেটওয়েতে সংযোগ হচ্ছে..." : "Processing via EPS Gateway..."}</span>
              </>
            ) : (
              <>
                <span>
                  {isBangla
                    ? `${selectedChannel} দিয়ে ${formatBDT(totalAmount, { isBangla })} পরিশোধ করুন`
                    : `Pay ${formatBDT(totalAmount, { isBangla })} via ${selectedChannel}`}
                </span>
                <ArrowRight className="w-4 h-4 text-cyan-200" />
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}
