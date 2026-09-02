"use client";

import React, { useState, Suspense } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { FALLBACK_LANDVEST_100 } from "@/lib/api/projects";
import EpsCheckoutModal from "@/components/payment/EpsCheckoutModal";
import BankTransferModal from "@/components/payment/BankTransferModal";
import {
  Coins,
  ShieldCheck,
  Building2,
  CheckCircle2,
  ArrowRight,
  ArrowLeft,
  Award,
  FileCheck2,
  Sparkles,
} from "lucide-react";

function InvestmentWizardForm() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const initialShares = parseInt(searchParams.get("shares") || "1", 10);

  const { isBangla, user } = useAuth();
  const project = FALLBACK_LANDVEST_100;

  const [step, setStep] = useState<1 | 2 | 3 | 4>(1);
  const [shares, setShares] = useState(initialShares >= 1 && initialShares <= 4 ? initialShares : 1);
  const [paymentMethod, setPaymentMethod] = useState<"EPS" | "MANUAL_BANK">("EPS");
  const [showEpsModal, setShowEpsModal] = useState(false);
  const [showBankModal, setShowBankModal] = useState(false);
  const [completedTxn, setCompletedTxn] = useState<{
    ref: string;
    lots: string[];
    isManualPending?: boolean;
  } | null>(null);

  const pricePerShare = 25500;
  const totalAmount = shares * pricePerShare;

  const handleEpsSuccess = (txnRef: string, lotNumbers: string[]) => {
    setShowEpsModal(false);
    setCompletedTxn({
      ref: txnRef,
      lots: lotNumbers,
      isManualPending: false,
    });
    setStep(4);
  };

  const handleBankSubmit = (data: any) => {
    setShowBankModal(false);
    setCompletedTxn({
      ref: data.paymentReference,
      lots: Array.from({ length: shares }, (_, i) => `LOT-${String(74 + i + 1).padStart(3, "0")}`),
      isManualPending: true,
    });
    setStep(4);
  };

  return (
    <div className="max-w-3xl mx-auto space-y-8 py-4">
      {/* Step Progress Bar */}
      <div className="bg-white p-4 sm:p-6 rounded-2xl border border-slate-200 shadow-sm">
        <div className="flex items-center justify-between text-xs font-bold text-slate-500 mb-3">
          <span>STEP {step} OF 4</span>
          <span>
            {step === 1
              ? "Share Selection"
              : step === 2
              ? "Investor Confirmation"
              : step === 3
              ? "Payment Method"
              : "Allocation Complete"}
          </span>
        </div>
        <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-emerald rounded-full transition-all duration-300"
            style={{ width: `${(step / 4) * 100}%` }}
          />
        </div>
      </div>

      {/* STEP 1: SHARE SELECTION */}
      {step === 1 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <span className="px-2.5 py-0.5 rounded text-[10px] font-bold bg-brand-light text-brand-forest">
              PROJECT: LANDVEST 100
            </span>
            <h2 className="text-2xl font-black text-slate-900">Select Number of Shares</h2>
            <p className="text-xs text-slate-500">
              Each share is fixed at ৳ 25,500. Maximum 4 shares per verified investor.
            </p>
          </div>

          <div className="grid grid-cols-4 gap-3">
            {[1, 2, 3, 4].map((num) => (
              <button
                key={num}
                type="button"
                onClick={() => setShares(num)}
                className={`py-4 rounded-2xl border flex flex-col items-center justify-center gap-1 transition-all ${
                  shares === num
                    ? "bg-brand-forest text-white border-brand-forest shadow-md shadow-brand-forest/20"
                    : "bg-slate-50 text-slate-700 border-slate-200 hover:bg-slate-100"
                }`}
              >
                <span className="font-bold text-base">{num} Share{num > 1 ? "s" : ""}</span>
                <span className={`text-[11px] ${shares === num ? "text-gold" : "text-slate-500"}`}>
                  {formatBDT(num * pricePerShare, { isBangla })}
                </span>
              </button>
            ))}
          </div>

          {/* Pricing Box */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 flex items-center justify-between">
            <span className="text-xs text-slate-600 font-semibold">Total Investment Payable:</span>
            <span className="text-2xl font-black text-brand-forest font-mono">
              {formatBDT(totalAmount, { isBangla })}
            </span>
          </div>

          <button
            onClick={() => setStep(2)}
            className="w-full py-4 rounded-xl bg-gradient-emerald text-white font-bold text-sm hover:opacity-95 shadow-lg shadow-brand-forest/20 flex items-center justify-center gap-2 transition-all"
          >
            <span>Proceed to Confirmation</span>
            <ArrowRight className="w-4 h-4 text-gold" />
          </button>
        </div>
      )}

      {/* STEP 2: INVESTOR CONFIRMATION */}
      {step === 2 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <h2 className="text-2xl font-black text-slate-900">Review Investment Summary</h2>
            <p className="text-xs text-slate-500">
              Verify your investment order details and legal co-ownership assignment.
            </p>
          </div>

          <div className="p-5 rounded-2xl bg-canvas-light border border-slate-200/80 space-y-3 text-xs">
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">Investor Legal Name:</span>
              <span className="font-bold text-slate-900">{user?.full_name || "Mashkurul Alam Ohi"}</span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">Selected Project:</span>
              <span className="font-bold text-slate-900">LandVest 100 (LV100)</span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">Shares Subscribed:</span>
              <span className="font-bold text-slate-900 font-mono">{shares} Share{shares > 1 ? "s" : ""} ({(shares / 100 * 100).toFixed(1)}% Project Equity)</span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">Total Price:</span>
              <span className="font-black text-brand-forest text-base font-mono">{formatBDT(totalAmount, { isBangla })}</span>
            </div>
            <div className="flex justify-between pt-1">
              <span className="text-slate-500">Title Deed Assignment:</span>
              <span className="font-bold text-slate-900 font-mono">Sub-Registry Deed #4982/2026</span>
            </div>
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(1)}
              className="py-3.5 px-5 rounded-xl border border-slate-300 font-bold text-xs text-slate-700 hover:bg-slate-50"
            >
              Back
            </button>
            <button
              onClick={() => setStep(3)}
              className="flex-1 py-3.5 rounded-xl bg-gradient-emerald text-white font-bold text-xs hover:opacity-95 shadow-md shadow-brand-forest/20 flex items-center justify-center gap-2"
            >
              <span>Confirm & Choose Payment</span>
              <ArrowRight className="w-4 h-4 text-gold" />
            </button>
          </div>
        </div>
      )}

      {/* STEP 3: PAYMENT METHOD */}
      {step === 3 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <h2 className="text-2xl font-black text-slate-900">Select Payment Method</h2>
            <p className="text-xs text-slate-500">
              Total Amount Payable: <span className="font-bold text-slate-900 font-mono">{formatBDT(totalAmount, { isBangla })}</span>
            </p>
          </div>

          <div className="space-y-3">
            {/* EPS Option */}
            <button
              type="button"
              onClick={() => setPaymentMethod("EPS")}
              className={`w-full p-5 rounded-2xl border text-left flex items-center justify-between transition-all ${
                paymentMethod === "EPS"
                  ? "bg-brand-light border-brand-forest ring-1 ring-brand-forest shadow-sm"
                  : "bg-white border-slate-200 hover:bg-slate-50"
              }`}
            >
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-gold/20 text-gold-dark">
                    RECOMMENDED (INSTANT)
                  </span>
                </div>
                <h3 className="font-bold text-slate-900 text-base">EPS Online Payment Gateway</h3>
                <p className="text-xs text-slate-500">
                  bKash, Nagad, Rocket, Visa / Mastercard, and Internet Banking with instant lot allocation.
                </p>
              </div>
              {paymentMethod === "EPS" && <CheckCircle2 className="w-5 h-5 text-brand-forest shrink-0" />}
            </button>

            {/* Bank Deposit Option */}
            <button
              type="button"
              onClick={() => setPaymentMethod("MANUAL_BANK")}
              className={`w-full p-5 rounded-2xl border text-left flex items-center justify-between transition-all ${
                paymentMethod === "MANUAL_BANK"
                  ? "bg-brand-light border-brand-forest ring-1 ring-brand-forest shadow-sm"
                  : "bg-white border-slate-200 hover:bg-slate-50"
              }`}
            >
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-slate-100 text-slate-700">
                    BANK ESCROW
                  </span>
                </div>
                <h3 className="font-bold text-slate-900 text-base">Manual Bank Transfer / Deposit</h3>
                <p className="text-xs text-slate-500">
                  Transfer directly into City Bank PLC Escrow and upload your deposit slip photo for verification.
                </p>
              </div>
              {paymentMethod === "MANUAL_BANK" && <CheckCircle2 className="w-5 h-5 text-brand-forest shrink-0" />}
            </button>
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(2)}
              className="py-3.5 px-5 rounded-xl border border-slate-300 font-bold text-xs text-slate-700 hover:bg-slate-50"
            >
              Back
            </button>
            <button
              onClick={() => (paymentMethod === "EPS" ? setShowEpsModal(true) : setShowBankModal(true))}
              className="flex-1 py-3.5 rounded-xl bg-gradient-emerald text-white font-bold text-xs hover:opacity-95 shadow-md shadow-brand-forest/20 flex items-center justify-center gap-2"
            >
              <span>{paymentMethod === "EPS" ? "Open EPS Checkout" : "Enter Deposit Slip Details"}</span>
              <ArrowRight className="w-4 h-4 text-gold" />
            </button>
          </div>
        </div>
      )}

      {/* STEP 4: SUCCESS / ALLOCATION CONFIRMATION */}
      {step === 4 && completedTxn && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-8 text-center space-y-6 animate-in fade-in zoom-in-95 duration-200">
          <div className="w-16 h-16 rounded-3xl bg-emerald-100 text-emerald-800 flex items-center justify-center mx-auto shadow-md">
            <Award className="w-8 h-8" />
          </div>

          <div className="space-y-2 max-w-md mx-auto">
            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-emerald-100 text-emerald-800">
              {completedTxn.isManualPending ? "PAYMENT UNDER REVIEW" : "SHARES ATOMICALLY ALLOCATED"}
            </span>
            <h2 className="text-2xl font-black text-slate-900">
              {completedTxn.isManualPending
                ? "Bank Deposit Slip Submitted!"
                : "Investment Successfully Completed!"}
            </h2>
            <p className="text-xs text-slate-500 leading-relaxed">
              {completedTxn.isManualPending
                ? "Your bank deposit slip has been submitted to the finance desk. Once verified, your share lots will be locked and certificate issued."
                : "Your payment was confirmed via EPS Gateway. The backend has assigned your sequential share lot numbers."}
            </p>
          </div>

          {/* Assigned Lots Pill */}
          <div className="p-4 rounded-2xl bg-gold-tint border border-gold/30 max-w-sm mx-auto space-y-1">
            <span className="text-[10px] font-bold text-gold-dark block">ASSIGNED LOT NUMBERS</span>
            <span className="font-mono font-black text-slate-900 text-lg">
              {completedTxn.lots.join(", ")}
            </span>
            <span className="text-[10px] text-slate-400 block font-mono">
              Txn Ref: {completedTxn.ref}
            </span>
          </div>

          <div className="flex flex-col sm:flex-row items-center justify-center gap-3 pt-2">
            <Link
              href="/dashboard/investments"
              className="w-full sm:w-auto px-6 py-3 rounded-xl bg-brand-forest text-white font-bold text-xs hover:bg-brand-primary"
            >
              View My Investments
            </Link>
            <Link
              href="/dashboard"
              className="w-full sm:w-auto px-6 py-3 rounded-xl bg-slate-100 text-slate-700 font-bold text-xs hover:bg-slate-200"
            >
              Back to Dashboard
            </Link>
          </div>
        </div>
      )}

      {/* EPS Modal */}
      {showEpsModal && (
        <EpsCheckoutModal
          shares={shares}
          totalAmount={totalAmount}
          onClose={() => setShowEpsModal(false)}
          onSuccess={handleEpsSuccess}
        />
      )}

      {/* Bank Modal */}
      {showBankModal && (
        <BankTransferModal
          shares={shares}
          totalAmount={totalAmount}
          onClose={() => setShowBankModal(false)}
          onSubmit={handleBankSubmit}
        />
      )}
    </div>
  );
}

export default function NewInvestmentWizardPage() {
  return (
    <Suspense fallback={<div className="p-8 text-center text-xs font-bold text-slate-400">Loading investment wizard...</div>}>
      <InvestmentWizardForm />
    </Suspense>
  );
}
