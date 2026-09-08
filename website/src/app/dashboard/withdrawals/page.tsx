"use client";

import React, { useState, useEffect } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ArrowUpRight,
  ShieldCheck,
  Building2,
  Clock,
  CheckCircle2,
  XCircle,
  AlertCircle,
  Wallet,
  Smartphone,
  Plus,
} from "lucide-react";

interface WithdrawalItem {
  id: string;
  type: "DIVIDEND" | "CAPITAL_EXIT";
  amount: number;
  fee: number;
  netAmount: number;
  payoutChannel: "BANK_TRANSFER" | "BKASH" | "NAGAD" | "ROCKET";
  bankName?: string;
  accountNumber?: string;
  mfsNumber?: string;
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "REJECTED" | "CANCELLED";
  transactionRef?: string;
  adminFeedback?: string;
  createdAt: string;
}

export default function WithdrawalsPage() {
  const { isBangla } = useAuth();
  const [withdrawals, setWithdrawals] = useState<WithdrawalItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [showModal, setShowModal] = useState(false);

  // Form State
  const [type, setType] = useState<"DIVIDEND" | "CAPITAL_EXIT">("DIVIDEND");
  const [amount, setAmount] = useState<string>("");
  const [channel, setChannel] = useState<"BANK_TRANSFER" | "BKASH" | "NAGAD">("BANK_TRANSFER");
  const [mfsNumber, setMfsNumber] = useState("01711-000000");
  const [userNote, setUserNote] = useState("");
  const [formError, setFormError] = useState<string | null>(null);

  const availableProfit = 10000;
  const availableCapital = 102000;
  const maxAvailable = type === "DIVIDEND" ? availableProfit : availableCapital;

  const fetchWithdrawals = async () => {
    try {
      setLoading(true);
      const res = await fetch("/api/withdrawals");
      const json = await res.json();
      if (json.success) {
        setWithdrawals(json.data || []);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchWithdrawals();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const num = Number(amount);
    if (!num || num <= 0) {
      setFormError(isBangla ? "একটি সঠিক টাকার অংক লিখুন" : "Enter a valid amount");
      return;
    }
    if (num > maxAvailable) {
      setFormError(
        isBangla
          ? `পর্যাপ্ত ব্যালেন্স নেই। সর্বোচ্চ প্রাপ্যতা ${formatBDT(maxAvailable, { isBangla })}`
          : `Insufficient funds. Max available: ${formatBDT(maxAvailable, { isBangla: false })}`
      );
      return;
    }

    setSubmitting(true);
    setFormError(null);
    try {
      const res = await fetch("/api/withdrawals", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          type,
          amount: num,
          payoutChannel: channel,
          mfsNumber: channel !== "BANK_TRANSFER" ? mfsNumber : undefined,
          userNote,
        }),
      });
      const data = await res.json();
      if (data.success) {
        setShowModal(false);
        setAmount("");
        setUserNote("");
        fetchWithdrawals();
      } else {
        setFormError(data.message || "Failed to submit request");
      }
    } catch (err) {
      setFormError("Network error occurred");
    } finally {
      setSubmitting(false);
    }
  };

  const totalWithdrawn = withdrawals
    .filter((w) => w.status === "COMPLETED")
    .reduce((sum, w) => sum + w.amount, 0);

  const pendingAmount = withdrawals
    .filter((w) => w.status === "PENDING" || w.status === "PROCESSING")
    .reduce((sum, w) => sum + w.amount, 0);

  return (
    <div className="space-y-5 font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-blue-50 text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "তহবিল নিষ্পত্তি ও খতিয়ান" : "FUNDS SETTLEMENT"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "তহবিল উত্তোলন ও প্রস্থান অনুরোধ" : "Fund Withdrawals & Settlements"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "অর্জিত মুনাফা বা মূলধন সরাসরি আপনার ব্যাংক অথবা বিকাশ/নগদে উত্তোলনের অনুরোধ পাঠান"
              : "Request dividend payouts or capital exits to your verified bank or mobile wallet"}
          </p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <Plus className="w-4 h-4 text-white" />
          <span>{isBangla ? "নতুন উত্তোলন অনুরোধ" : "Request Withdrawal"}</span>
        </button>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 sm:gap-4">
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "উত্তোলনযোগ্য লভ্যাংশ" : "Available Dividend Profit"}
          </span>
          <span className="text-xl sm:text-2xl font-black text-[#0066FF] block">
            {formatBDT(availableProfit, { isBangla })}
          </span>
          <span className="text-[11px] text-emerald-600 block font-medium">
            {isBangla ? "০% প্রসেসিং ফি • ১-২ দিনে জমা" : "0% fee • Disbursed in 1-2 days"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-slate-500 block">
            {isBangla ? "মোট উত্তোলিত অর্থ" : "Total Disbursed"}
          </span>
          <span className="text-xl sm:text-2xl font-black text-emerald-700 block">
            {formatBDT(totalWithdrawn, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "ব্যাংক একাউন্টে ক্লিয়ারেন্স সম্পন্ন" : "Cleared to bank account"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5 flex flex-col justify-between">
          <span className="text-[11px] font-semibold uppercase tracking-wider text-amber-600 block">
            {isBangla ? "অপেক্ষমান উত্তোলন" : "Pending Processing"}
          </span>
          <span className="text-xl sm:text-2xl font-black text-amber-700 block">
            {formatBDT(pendingAmount, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "কমপ্লায়েন্স অডিট পর্যালোচনাধীন" : "Under compliance review"}
          </span>
        </div>
      </div>

      {/* Withdrawals List Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="p-4 border-b border-slate-200 flex items-center justify-between">
          <h2 className="text-sm font-bold text-slate-900">
            {isBangla ? "উত্তোলন খতিয়ান ও ট্র্যাকিং" : "Withdrawals Ledger & Tracking"}
          </h2>
          <span className="text-xs text-slate-500">
            {withdrawals.length} {isBangla ? "টি রেকর্ড" : "records"}
          </span>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-4">{isBangla ? "ধরন ও আইডি" : "Type / ID"}</th>
                <th className="py-3 px-4">{isBangla ? "পরিমাণ" : "Amount"}</th>
                <th className="py-3 px-4">{isBangla ? "মাধ্যম / একাউন্ট" : "Destination"}</th>
                <th className="py-3 px-4">{isBangla ? "তারিখ" : "Date"}</th>
                <th className="py-3 px-4">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
                <th className="py-3 px-4">{isBangla ? "রেফারেন্স" : "Reference"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                <tr>
                  <td colSpan={6} className="text-center py-8 text-slate-400">
                    Loading records...
                  </td>
                </tr>
              ) : withdrawals.length === 0 ? (
                <tr>
                  <td colSpan={6} className="text-center py-8 text-slate-400">
                    {isBangla ? "কোনো উত্তোলন রেকর্ড পাওয়া যায়নি" : "No withdrawal records found"}
                  </td>
                </tr>
              ) : (
                withdrawals.map((w) => (
                  <tr key={w.id} className="hover:bg-slate-50/60 transition-colors">
                    <td className="py-3 px-4">
                      <div className="font-bold text-slate-900">
                        {w.type === "DIVIDEND" ? (isBangla ? "লভ্যাংশ উত্তোলন" : "Dividend") : (isBangla ? "মূলধন প্রত্যাহার" : "Capital Exit")}
                      </div>
                      <div className="text-[10px] font-mono text-slate-400">{w.id}</div>
                    </td>
                    <td className="py-3 px-4">
                      <span className="font-black text-slate-900 text-sm">
                        {formatBDT(w.amount, { isBangla })}
                      </span>
                    </td>
                    <td className="py-3 px-4">
                      <div className="font-medium text-slate-800">
                        {w.payoutChannel === "BANK_TRANSFER" ? "City Bank PLC" : w.payoutChannel}
                      </div>
                      <div className="text-[10px] text-slate-400">
                        {w.accountNumber || w.mfsNumber || "Verified Account"}
                      </div>
                    </td>
                    <td className="py-3 px-4 text-slate-600">
                      {new Date(w.createdAt).toLocaleDateString()}
                    </td>
                    <td className="py-3 px-4">
                      <span
                        className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-[10px] font-bold ${
                          w.status === "COMPLETED"
                            ? "bg-emerald-50 text-emerald-700 border border-emerald-200"
                            : w.status === "PENDING"
                            ? "bg-amber-50 text-amber-700 border border-amber-200"
                            : "bg-red-50 text-red-700 border border-red-200"
                        }`}
                      >
                        {w.status === "COMPLETED" && <CheckCircle2 className="w-3 h-3" />}
                        {w.status === "PENDING" && <Clock className="w-3 h-3" />}
                        {w.status === "REJECTED" && <XCircle className="w-3 h-3" />}
                        <span>
                          {w.status === "COMPLETED"
                            ? isBangla ? "পরিশোধিত" : "Settled"
                            : w.status === "PENDING"
                            ? isBangla ? "পর্যালোচনাধীন" : "Pending"
                            : isBangla ? "প্রত্যাখ্যাত" : "Declined"}
                        </span>
                      </span>
                    </td>
                    <td className="py-3 px-4 font-mono text-[11px] text-blue-600">
                      {w.transactionRef || "—"}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal / Dialog for New Withdrawal Request */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-xs p-4">
          <div className="bg-white rounded-2xl max-w-md w-full p-5 sm:p-6 shadow-xl space-y-4">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <h2 className="text-base font-bold text-slate-900">
                {isBangla ? "তহবিল উত্তোলনের অনুরোধ" : "Request Fund Withdrawal"}
              </h2>
              <button
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-600 cursor-pointer text-lg font-bold"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSubmit} className="space-y-4 text-xs">
              {/* Type Switcher */}
              <div className="grid grid-cols-2 gap-2 p-1 bg-slate-100 rounded-xl">
                <button
                  type="button"
                  onClick={() => setType("DIVIDEND")}
                  className={`py-2 text-xs font-bold rounded-lg transition-all cursor-pointer ${
                    type === "DIVIDEND" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600"
                  }`}
                >
                  {isBangla ? "লভ্যাংশ উত্তোলন" : "Dividend Payout"}
                </button>
                <button
                  type="button"
                  onClick={() => setType("CAPITAL_EXIT")}
                  className={`py-2 text-xs font-bold rounded-lg transition-all cursor-pointer ${
                    type === "CAPITAL_EXIT" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600"
                  }`}
                >
                  {isBangla ? "মূলধন প্রত্যাহার" : "Capital Exit"}
                </button>
              </div>

              {/* Available Balance Box */}
              <div className="p-3 rounded-xl bg-blue-50 border border-blue-100 flex items-center justify-between">
                <div>
                  <span className="text-[10px] text-blue-600 font-semibold block">
                    {type === "DIVIDEND"
                      ? isBangla ? "উত্তোলনযোগ্য অবশিষ্ট লভ্যাংশ:" : "Available Profit:"
                      : isBangla ? "বিনিয়োগকৃত মোট মূলধন:" : "Total Capital:"}
                  </span>
                  <span className="text-base font-black text-blue-900 font-mono">
                    {formatBDT(maxAvailable, { isBangla })}
                  </span>
                </div>
                <button
                  type="button"
                  onClick={() => setAmount(String(maxAvailable))}
                  className="px-2.5 py-1 text-[11px] font-bold text-[#0066FF] bg-white rounded-lg border border-blue-200 cursor-pointer"
                >
                  {isBangla ? "পুরোটা তুলুন" : "Max"}
                </button>
              </div>

              {/* Amount Input */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "টাকার পরিমাণ (BDT) *" : "Withdrawal Amount (BDT) *"}
                </label>
                <input
                  type="number"
                  required
                  placeholder="e.g. 5000"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  className="w-full px-3 py-2 text-sm font-bold border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>

              {/* Destination Selector */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "টাকা গ্রহণের মাধ্যম *" : "Payout Channel *"}
                </label>
                <div className="grid grid-cols-3 gap-2">
                  <button
                    type="button"
                    onClick={() => setChannel("BANK_TRANSFER")}
                    className={`py-2 px-1 text-[11px] font-bold rounded-xl border flex flex-col items-center gap-1 cursor-pointer ${
                      channel === "BANK_TRANSFER"
                        ? "border-[#0066FF] bg-blue-50/50 text-[#0066FF]"
                        : "border-slate-200 text-slate-600"
                    }`}
                  >
                    <Building2 className="w-3.5 h-3.5" />
                    <span>{isBangla ? "ব্যাংক" : "Bank"}</span>
                  </button>
                  <button
                    type="button"
                    onClick={() => setChannel("BKASH")}
                    className={`py-2 px-1 text-[11px] font-bold rounded-xl border flex flex-col items-center gap-1 cursor-pointer ${
                      channel === "BKASH"
                        ? "border-[#0066FF] bg-blue-50/50 text-[#0066FF]"
                        : "border-slate-200 text-slate-600"
                    }`}
                  >
                    <Smartphone className="w-3.5 h-3.5" />
                    <span>bKash</span>
                  </button>
                  <button
                    type="button"
                    onClick={() => setChannel("NAGAD")}
                    className={`py-2 px-1 text-[11px] font-bold rounded-xl border flex flex-col items-center gap-1 cursor-pointer ${
                      channel === "NAGAD"
                        ? "border-[#0066FF] bg-blue-50/50 text-[#0066FF]"
                        : "border-slate-200 text-slate-600"
                    }`}
                  >
                    <Wallet className="w-3.5 h-3.5" />
                    <span>Nagad</span>
                  </button>
                </div>
              </div>

              {channel === "BANK_TRANSFER" ? (
                <div className="p-2.5 rounded-xl bg-slate-50 border border-slate-200 text-[11px] text-slate-600 space-y-0.5">
                  <div className="font-bold text-slate-800 flex items-center gap-1">
                    <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                    <span>The City Bank Limited (A/C: ****2001)</span>
                  </div>
                  <div>Branch: Uttara Branch, Dhaka | Routing: 225275394</div>
                </div>
              ) : (
                <div className="space-y-1">
                  <label className="font-bold text-slate-700 block">
                    {isBangla ? "মোবাইল ওয়ালেট নাম্বার *" : "Mobile Wallet Number *"}
                  </label>
                  <input
                    type="text"
                    required
                    value={mfsNumber}
                    onChange={(e) => setMfsNumber(e.target.value)}
                    className="w-full px-3 py-2 text-xs border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
                  />
                </div>
              )}

              {/* Note */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "মন্তব্য (ঐচ্ছিক)" : "Note (Optional)"}
                </label>
                <input
                  type="text"
                  placeholder={isBangla ? "কোনো বিশেষ অনুরোধ..." : "Special instructions..."}
                  value={userNote}
                  onChange={(e) => setUserNote(e.target.value)}
                  className="w-full px-3 py-2 text-xs border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>

              {formError && (
                <div className="p-2.5 rounded-xl bg-red-50 border border-red-200 text-red-700 text-xs font-medium">
                  {formError}
                </div>
              )}

              <button
                type="submit"
                disabled={submitting}
                className="w-full py-2.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm transition-all cursor-pointer disabled:opacity-50"
              >
                {submitting
                  ? isBangla ? "অনুরোধ পাঠানো হচ্ছে..." : "Submitting..."
                  : isBangla ? "অনুরোধ জমা দিন" : "Confirm Withdrawal"}
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
