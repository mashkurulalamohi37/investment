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
          <span>{isBangla ? `ধাপ ${step} / ৪` : `STEP ${step} OF 4`}</span>
          <span>
            {step === 1
              ? isBangla ? "শেয়ার নির্বাচন" : "Share Selection"
              : step === 2
              ? isBangla ? "বিনিয়োগকারী নিশ্চিতকরণ" : "Investor Confirmation"
              : step === 3
              ? isBangla ? "পেমেন্ট মাধ্যম" : "Payment Method"
              : isBangla ? "বরাদ্দ সম্পন্ন" : "Allocation Complete"}
          </span>
        </div>
        <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-[#0066FF] to-[#00B4D8] rounded-full transition-all duration-300"
            style={{ width: `${(step / 4) * 100}%` }}
          />
        </div>
      </div>

      {/* STEP 1: SHARE SELECTION */}
      {step === 1 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <span className="px-2.5 py-0.5 rounded text-[10px] font-bold bg-blue-50 text-[#0066FF]">
              {isBangla ? "প্রকল্প: ল্যান্ডভেস্ট ১০০" : "PROJECT: LANDVEST 100"}
            </span>
            <h2 className="text-2xl font-black text-slate-900">
              {isBangla ? "শেয়ারের সংখ্যা নির্বাচন করুন" : "Select Number of Shares"}
            </h2>
            <p className="text-xs text-slate-500">
              {isBangla
                ? "প্রতি শেয়ারের মূল্য ৳২৫,৫০০। একজন বিনিয়োগকারী সর্বোচ্চ ৪টি শেয়ার নিতে পারবেন।"
                : "Each share is fixed at ৳ 25,500. Maximum 4 shares per verified investor."}
            </p>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
            {[1, 2, 3, 4].map((num) => {
              const isSelected = shares === num;
              return (
                <button
                  key={num}
                  type="button"
                  onClick={() => setShares(num)}
                  className={`py-4 px-3 rounded-2xl border flex flex-col items-center justify-center gap-1 transition-all cursor-pointer ${
                    isSelected
                      ? "bg-[#0066FF] text-white border-[#0066FF] shadow-md shadow-[#0066FF]/25 scale-[1.02]"
                      : "bg-[#F8FAFC] text-[#0F172A] border-[#E2E8F0] hover:bg-[#EBF3FF]/70 hover:border-[#0066FF]/40"
                  }`}
                >
                  <span className="font-bold text-base">
                    {isBangla ? `${num} ভাগ` : `${num} Share${num > 1 ? "s" : ""}`}
                  </span>
                  <span className={`text-xs font-semibold ${isSelected ? "text-white/90" : "text-[#64748B]"}`}>
                    {formatBDT(num * pricePerShare, { isBangla })}
                  </span>
                </button>
              );
            })}
          </div>

          {/* Pricing Box */}
          <div className="p-4 rounded-xl bg-[#F8FAFC] border border-[#E2E8F0] flex items-center justify-between">
            <span className="text-xs sm:text-sm text-[#64748B] font-semibold">
              {isBangla ? "মোট প্রদেয় বিনিয়োগ:" : "Total Investment Payable:"}
            </span>
            <span className="text-2xl font-bold text-[#0066FF] tracking-tight">
              {formatBDT(totalAmount, { isBangla })}
            </span>
          </div>

          <button
            onClick={() => setStep(2)}
            className="w-full py-4 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-sm shadow-md shadow-[#0066FF]/25 flex items-center justify-center gap-2 transition-all cursor-pointer"
          >
            <span>{isBangla ? "পরবর্তী ধাপে নিশ্চিত করুন" : "Proceed to Confirmation"}</span>
            <ArrowRight className="w-4 h-4 text-cyan-200" />
          </button>
        </div>
      )}

      {/* STEP 2: INVESTOR CONFIRMATION */}
      {step === 2 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <h2 className="text-2xl font-black text-slate-900">
              {isBangla ? "বিনিয়োগ সারসংক্ষেপ পর্যালোচনা" : "Review Investment Summary"}
            </h2>
            <p className="text-xs text-slate-500">
              {isBangla
                ? "আপনার শেয়ার ও যৌথ মালিকানা বরাদ্দের বিবরণী যাচাই করুন।"
                : "Verify your investment order details and legal co-ownership assignment."}
            </p>
          </div>

          <div className="p-5 rounded-2xl bg-[#F8FAFC] border border-slate-200/80 space-y-3 text-xs">
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">{isBangla ? "বিনিয়োগকারীর নাম:" : "Investor Legal Name:"}</span>
              <span className="font-bold text-slate-900">{user?.full_name || (isBangla ? "তারিকুল ইসলাম" : "Tariqul Islam")}</span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">{isBangla ? "নির্বাচিত প্রকল্প:" : "Selected Project:"}</span>
              <span className="font-bold text-slate-900">LandVest 100 (LV100)</span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">{isBangla ? "সাবস্ক্রাইবকৃত শেয়ার:" : "Shares Subscribed:"}</span>
              <span className="font-bold text-slate-900 font-mono">
                {isBangla ? `${shares}টি ভাগ (${(shares / 100 * 100).toFixed(1)}% ইকুইটি)` : `${shares} Share${shares > 1 ? "s" : ""} (${(shares / 100 * 100).toFixed(1)}% Equity)`}
              </span>
            </div>
            <div className="flex justify-between pb-2 border-b border-slate-200/60">
              <span className="text-slate-500">{isBangla ? "মোট প্রদেয় মূল্য:" : "Total Price:"}</span>
              <span className="font-black text-[#0066FF] text-base font-mono">{formatBDT(totalAmount, { isBangla })}</span>
            </div>
            <div className="flex justify-between pt-1">
              <span className="text-slate-500">{isBangla ? "মুনাফা বণ্টন পদ্ধতি:" : "Profit-Sharing Model:"}</span>
              <span className="font-bold text-slate-900">{isBangla ? "প্রো-রাটা সরাসরি ব্যাংক বণ্টন" : "Direct Pro-Rata Distribution"}</span>
            </div>
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(1)}
              className="py-3.5 px-5 rounded-xl border border-slate-300 font-bold text-xs text-slate-700 hover:bg-slate-50 cursor-pointer"
            >
              {isBangla ? "পিছনে" : "Back"}
            </button>
            <button
              onClick={() => setStep(3)}
              className="flex-1 py-3.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-md shadow-[#0066FF]/25 flex items-center justify-center gap-2 cursor-pointer"
            >
              <span>{isBangla ? "পেমেন্ট মাধ্যম বেছে নিন" : "Confirm & Choose Payment"}</span>
              <ArrowRight className="w-4 h-4 text-cyan-200" />
            </button>
          </div>
        </div>
      )}

      {/* STEP 3: PAYMENT METHOD */}
      {step === 3 && (
        <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1">
            <h2 className="text-2xl font-black text-slate-900">
              {isBangla ? "পেমেন্ট মাধ্যম নির্বাচন করুন" : "Select Payment Method"}
            </h2>
            <p className="text-xs text-slate-500">
              {isBangla ? "মোট পরিশোধযোগ্য পরিমাণ: " : "Total Amount Payable: "}
              <span className="font-bold text-slate-900 font-mono">{formatBDT(totalAmount, { isBangla })}</span>
            </p>
          </div>

          <div className="space-y-3">
            {/* EPS Option */}
            <button
              type="button"
              onClick={() => setPaymentMethod("EPS")}
              className={`w-full p-5 rounded-2xl border text-left flex items-center justify-between transition-all cursor-pointer ${
                paymentMethod === "EPS"
                  ? "bg-blue-50/70 border-[#0066FF] ring-1 ring-[#0066FF] shadow-sm"
                  : "bg-white border-slate-200 hover:bg-slate-50"
              }`}
            >
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-[#0066FF]/10 text-[#0066FF]">
                    {isBangla ? "প্রস্তাবিত (তাৎক্ষণিক লট বরাদ্দ)" : "RECOMMENDED (INSTANT)"}
                  </span>
                </div>
                <h3 className="font-bold text-slate-900 text-base">
                  {isBangla ? "EPS অনলাইন পেমেন্ট গেটওয়ে" : "EPS Online Payment Gateway"}
                </h3>
                <p className="text-xs text-slate-500">
                  {isBangla
                    ? "বিকাশ, নগদ, রকেট, ভিসা / মাস্টারকার্ড ও ইন্টারনেট ব্যাংকিং দিয়ে মুহূর্তেই পেমেন্ট।"
                    : "bKash, Nagad, Rocket, Visa / Mastercard, and Internet Banking with instant lot allocation."}
                </p>
              </div>
              {paymentMethod === "EPS" && <CheckCircle2 className="w-5 h-5 text-[#0066FF] shrink-0" />}
            </button>

            {/* Bank Deposit Option */}
            <button
              type="button"
              onClick={() => setPaymentMethod("MANUAL_BANK")}
              className={`w-full p-5 rounded-2xl border text-left flex items-center justify-between transition-all cursor-pointer ${
                paymentMethod === "MANUAL_BANK"
                  ? "bg-blue-50/70 border-[#0066FF] ring-1 ring-[#0066FF] shadow-sm"
                  : "bg-white border-slate-200 hover:bg-slate-50"
              }`}
            >
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-slate-100 text-slate-700">
                    {isBangla ? "ব্যাংক এসক্রো" : "BANK ESCROW"}
                  </span>
                </div>
                <h3 className="font-bold text-slate-900 text-base">
                  {isBangla ? "ম্যানুয়াল ব্যাংক ট্রান্সফার ও স্লিপ আপলোড" : "Manual Bank Transfer / Deposit"}
                </h3>
                <p className="text-xs text-slate-500">
                  {isBangla
                    ? "সিটি ব্যাংক এসক্রো অ্যাকাউন্টে সরাসরি জমা দিয়ে স্লিপের ছবি আপলোড করুন।"
                    : "Transfer directly into City Bank PLC Escrow and upload your deposit slip photo for verification."}
                </p>
              </div>
              {paymentMethod === "MANUAL_BANK" && <CheckCircle2 className="w-5 h-5 text-[#0066FF] shrink-0" />}
            </button>
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(2)}
              className="py-3.5 px-5 rounded-xl border border-slate-300 font-bold text-xs text-slate-700 hover:bg-slate-50 cursor-pointer"
            >
              {isBangla ? "পিছনে" : "Back"}
            </button>
            <button
              onClick={() => (paymentMethod === "EPS" ? setShowEpsModal(true) : setShowBankModal(true))}
              className="flex-1 py-3.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-md shadow-[#0066FF]/25 flex items-center justify-center gap-2 cursor-pointer"
            >
              <span>
                {paymentMethod === "EPS"
                  ? isBangla ? "EPS গেটওয়ে চেকআউট খুলুন" : "Open EPS Checkout"
                  : isBangla ? "ব্যাংক স্লিপের বিবরণ দিন" : "Enter Deposit Slip Details"}
              </span>
              <ArrowRight className="w-4 h-4 text-cyan-200" />
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
              {completedTxn.isManualPending
                ? isBangla ? "পেমেন্ট পর্যালোচনায় রয়েছে" : "PAYMENT UNDER REVIEW"
                : isBangla ? "শেয়ার লট বরাদ্দ সম্পন্ন" : "SHARES ATOMICALLY ALLOCATED"}
            </span>
            <h2 className="text-2xl font-black text-slate-900">
              {completedTxn.isManualPending
                ? isBangla ? "ব্যাংক ডিপোজিট স্লিপ জমা হয়েছে!" : "Bank Deposit Slip Submitted!"
                : isBangla ? "বিনিয়োগ সফলভাবে সম্পন্ন হয়েছে!" : "Investment Successfully Completed!"}
            </h2>
            <p className="text-xs text-slate-500 leading-relaxed">
              {completedTxn.isManualPending
                ? isBangla
                  ? "আপনার ব্যাংক ডিপোজিট স্লিপ ফাইন্যান্স ডেস্কে যাচাইয়ের জন্য জমা হয়েছে। যাচাই শেষে শেয়ার লট লক হবে এবং সার্টিফিকেট ইস্যু হবে।"
                  : "Your bank deposit slip has been submitted to the finance desk. Once verified, your share lots will be locked and certificate issued."
                : isBangla
                  ? "EPS গেটওয়ের মাধ্যমে আপনার পেমেন্ট নিশ্চিত হয়েছে এবং স্বয়ংক্রিয়ভাবে সিকোয়েনশিয়াল শেয়ার লট নম্বর বরাদ্দ করা হয়েছে।"
                  : "Your payment was confirmed via EPS Gateway. The backend has assigned your sequential share lot numbers."}
            </p>
          </div>

          {/* Assigned Lots Pill */}
          <div className="p-4 rounded-2xl bg-blue-50 border border-blue-200 max-w-sm mx-auto space-y-1">
            <span className="text-[10px] font-bold text-[#0066FF] block">
              {isBangla ? "বরাদ্দকৃত লট নম্বরসমূহ" : "ASSIGNED LOT NUMBERS"}
            </span>
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
              className="w-full sm:w-auto px-6 py-3 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs"
            >
              {isBangla ? "আমার পোর্টফোলিও দেখুন" : "View My Investments"}
            </Link>
            <Link
              href="/dashboard"
              className="w-full sm:w-auto px-6 py-3 rounded-xl bg-slate-100 text-slate-700 font-bold text-xs hover:bg-slate-200"
            >
              {isBangla ? "ড্যাশবোর্ডে ফিরুন" : "Back to Dashboard"}
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
