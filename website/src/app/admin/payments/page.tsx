"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  CreditCard,
  CheckCircle2,
  XCircle,
  Eye,
  ShieldCheck,
  Building2,
  Clock,
  Award,
} from "lucide-react";

export default function AdminPaymentsVerificationPage() {
  const { isBangla } = useAuth();

  const [pendingPayments, setPendingPayments] = useState([
    {
      id: "inv-p-01",
      investmentNo: "INV-2026-LV100-0075",
      investorName: "Dr. Tanvir Hasan",
      phone: "+880 1819-223344",
      shares: 2,
      grossAmount: 51000,
      bankName: "The City Bank PLC",
      depositorName: "Dr. Tanvir Hasan",
      reference: "DEP-CITY-8910",
      submittedAt: "2026-09-02 11:20 AM",
      slipUrl: "https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600&q=80",
    },
    {
      id: "inv-p-02",
      investmentNo: "INV-2026-LV100-0077",
      investorName: "Nusrat Jahan",
      phone: "+880 1711-998877",
      shares: 1,
      grossAmount: 25500,
      bankName: "The City Bank PLC",
      depositorName: "Nusrat Jahan",
      reference: "DEP-CITY-8914",
      submittedAt: "2026-09-02 01:15 PM",
      slipUrl: "https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600&q=80",
    },
  ]);

  const [selectedSlip, setSelectedSlip] = useState<any | null>(null);
  const [successToast, setSuccessToast] = useState<string | null>(null);

  const handleApprove = (payment: any) => {
    // Generate sequential lots
    const lots = payment.shares === 2 ? ["LOT-075", "LOT-076"] : ["LOT-077"];
    setPendingPayments((prev) => prev.filter((p) => p.id !== payment.id));
    setSelectedSlip(null);
    setSuccessToast(`Payment Verified & Shares Atomically Allocated: ${payment.investorName} (${lots.join(", ")})`);
    setTimeout(() => setSuccessToast(null), 4000);
  };

  const handleReject = (payment: any) => {
    setPendingPayments((prev) => prev.filter((p) => p.id !== payment.id));
    setSelectedSlip(null);
    setSuccessToast(`Payment record rejected for ${payment.investorName}.`);
    setTimeout(() => setSuccessToast(null), 4000);
  };

  return (
    <div className="space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-800">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-white">
            Bank Deposit Verification Queue
          </h1>
          <p className="text-xs text-slate-400">
            Inspect investor deposit receipts, match City Bank transactions, and execute atomic lot allocations
          </p>
        </div>
        <span className="px-3 py-1 rounded-full text-xs font-mono font-bold bg-amber-500/20 text-amber-400">
          {pendingPayments.length} PENDING REVIEW
        </span>
      </div>

      {successToast && (
        <div className="p-4 rounded-xl bg-emerald-950/80 border border-emerald-800 text-emerald-300 text-xs font-bold flex items-center gap-2 animate-in fade-in">
          <CheckCircle2 className="w-4 h-4 text-jade shrink-0" />
          <span>{successToast}</span>
        </div>
      )}

      {pendingPayments.length === 0 ? (
        <div className="p-12 text-center bg-slate-900 border border-slate-800 rounded-3xl space-y-3">
          <CheckCircle2 className="w-12 h-12 text-jade mx-auto" />
          <h3 className="text-lg font-bold text-white">All Pending Slips Verified!</h3>
          <p className="text-xs text-slate-400">There are no pending bank deposits waiting in the verification queue.</p>
        </div>
      ) : (
        <div className="space-y-4">
          {pendingPayments.map((p) => (
            <div
              key={p.id}
              className="p-6 rounded-2xl bg-slate-900 border border-slate-800 flex flex-col lg:flex-row lg:items-center justify-between gap-6 hover:border-slate-700 transition-all"
            >
              <div className="space-y-2 flex-1">
                <div className="flex items-center gap-2">
                  <span className="font-mono text-xs font-bold text-gold bg-gold/10 px-2.5 py-0.5 rounded">
                    {p.investmentNo}
                  </span>
                  <span className="text-[10px] text-slate-400 flex items-center gap-1 font-mono">
                    <Clock className="w-3 h-3" /> {p.submittedAt}
                  </span>
                </div>

                <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-sm font-bold text-white">
                  <span>{p.investorName}</span>
                  <span className="text-xs font-normal text-slate-400 font-mono">{p.phone}</span>
                </div>

                <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 pt-2 text-xs">
                  <div>
                    <span className="text-slate-500 block">Shares Requested:</span>
                    <span className="text-white font-bold">{p.shares} Share{p.shares > 1 ? "s" : ""}</span>
                  </div>
                  <div>
                    <span className="text-slate-500 block">Total Amount:</span>
                    <span className="text-gold font-bold font-mono">{formatBDT(p.grossAmount, { isBangla })}</span>
                  </div>
                  <div>
                    <span className="text-slate-500 block">Bank Slip Ref:</span>
                    <span className="text-slate-300 font-mono font-bold">{p.reference}</span>
                  </div>
                </div>
              </div>

              {/* Action Buttons */}
              <div className="flex items-center gap-2.5 shrink-0">
                <button
                  type="button"
                  onClick={() => setSelectedSlip(p)}
                  className="px-4 py-2.5 rounded-xl bg-slate-800 text-white hover:bg-slate-700 text-xs font-bold flex items-center gap-1.5"
                >
                  <Eye className="w-3.5 h-3.5 text-gold" />
                  <span>Inspect Slip</span>
                </button>
                <button
                  type="button"
                  onClick={() => handleApprove(p)}
                  className="px-5 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white text-xs font-bold flex items-center gap-1.5 shadow-md"
                >
                  <CheckCircle2 className="w-3.5 h-3.5" />
                  <span>Approve & Allocate Lots</span>
                </button>
                <button
                  type="button"
                  onClick={() => handleReject(p)}
                  className="p-2.5 rounded-xl bg-red-950/60 hover:bg-red-900/80 text-red-400 text-xs font-bold"
                  title="Reject"
                >
                  <XCircle className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Slip Inspector Modal */}
      {selectedSlip && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-slate-900 border border-slate-800 rounded-3xl max-w-lg w-full p-6 space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-slate-800">
              <h3 className="font-bold text-white text-base">
                Deposit Receipt Slip Inspector
              </h3>
              <button
                onClick={() => setSelectedSlip(null)}
                className="text-slate-400 hover:text-white"
              >
                ✕
              </button>
            </div>

            <div className="space-y-3 text-xs">
              <div className="aspect-[4/3] rounded-xl overflow-hidden border border-slate-800 relative bg-slate-950">
                <img
                  src={selectedSlip.slipUrl}
                  alt="Deposit Slip Preview"
                  className="w-full h-full object-cover"
                />
              </div>

              <div className="p-3 rounded-xl bg-slate-950 border border-slate-800 space-y-1">
                <div className="flex justify-between">
                  <span className="text-slate-400">Investor:</span>
                  <span className="text-white font-bold">{selectedSlip.investorName}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-400">Amount:</span>
                  <span className="text-gold font-bold font-mono">{formatBDT(selectedSlip.grossAmount, { isBangla })}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-slate-400">Slip Reference:</span>
                  <span className="text-white font-mono">{selectedSlip.reference}</span>
                </div>
              </div>
            </div>

            <div className="flex gap-2 pt-2">
              <button
                onClick={() => handleApprove(selectedSlip)}
                className="flex-1 py-3 rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white font-bold text-xs flex items-center justify-center gap-1.5"
              >
                <CheckCircle2 className="w-4 h-4" />
                <span>Confirm & Allocate Sequential Lots</span>
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
