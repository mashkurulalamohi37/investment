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
      investorName_bn: "ডাঃ তানভীর হাসান",
      phone: "+880 1819-223344",
      shares: 2,
      grossAmount: 51000,
      bankName: "The City Bank PLC",
      bankName_bn: "দ্য সিটি ব্যাংক পিএলসি",
      depositorName: "Dr. Tanvir Hasan",
      reference: "DEP-CITY-8910",
      submittedAt: "2026-09-02 11:20 AM",
      slipUrl: "https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600&q=80",
    },
    {
      id: "inv-p-02",
      investmentNo: "INV-2026-LV100-0077",
      investorName: "Nusrat Jahan",
      investorName_bn: "নুসরাত জাহান",
      phone: "+880 1711-998877",
      shares: 1,
      grossAmount: 25500,
      bankName: "The City Bank PLC",
      bankName_bn: "দ্য সিটি ব্যাংক পিএলসি",
      depositorName: "Nusrat Jahan",
      reference: "DEP-CITY-8914",
      submittedAt: "2026-09-02 01:15 PM",
      slipUrl: "https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=600&q=80",
    },
  ]);

  const [selectedSlip, setSelectedSlip] = useState<any | null>(null);
  const [successToast, setSuccessToast] = useState<string | null>(null);

  const handleApprove = (payment: any) => {
    const lots = payment.shares === 2 ? ["LOT-075", "LOT-076"] : ["LOT-077"];
    setPendingPayments((prev) => prev.filter((p) => p.id !== payment.id));
    setSelectedSlip(null);
    setSuccessToast(
      isBangla
        ? `পেমেন্ট ভেরিফাই সম্পন্ন ও শেয়ার বরাদ্দ করা হয়েছে: ${payment.investorName_bn || payment.investorName} (${lots.join(", ")})`
        : `Payment Verified & Shares Allocated: ${payment.investorName} (${lots.join(", ")})`
    );
    setTimeout(() => setSuccessToast(null), 4000);
  };

  const handleReject = (payment: any) => {
    setPendingPayments((prev) => prev.filter((p) => p.id !== payment.id));
    setSelectedSlip(null);
    setSuccessToast(
      isBangla
        ? `পেমেন্ট রেকর্ড বাতিল করা হয়েছে: ${payment.investorName_bn || payment.investorName}`
        : `Payment record rejected for ${payment.investorName}.`
    );
    setTimeout(() => setSuccessToast(null), 4000);
  };

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "এসক্রো ভেরিফিকেশন" : "ESCROW CLEARING"}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200">
              {pendingPayments.length} {isBangla ? "টি অপেক্ষমান" : "PENDING"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "ব্যাংক ডিপোজিট স্লিপ যাচাই কিউ" : "Bank Deposit Verification Queue"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "ইনভেস্টরদের ব্যাংক রসিদ যাচাই, সিটি ব্যাংক ট্রানজেকশন ম্যাচিং এবং ডিজিটাল শেয়ার বরাদ্দ"
              : "Inspect investor deposit receipts, match City Bank transactions, and execute atomic lot allocations"}
          </p>
        </div>
      </div>

      {successToast && (
        <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-bold flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          <span>{successToast}</span>
        </div>
      )}

      {/* Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-3.5">{isBangla ? "ইনভেস্টমেন্ট আইডি" : "Investment ID"}</th>
                <th className="py-3 px-3.5">{isBangla ? "ইনভেস্টর ও ফোন" : "Investor & Phone"}</th>
                <th className="py-3 px-3.5">{isBangla ? "শেয়ার ও পরিমাণ" : "Shares & Amount"}</th>
                <th className="py-3 px-3.5">{isBangla ? "ডিপোজিট রেফারেন্স" : "Deposit Reference"}</th>
                <th className="py-3 px-3.5">{isBangla ? "ব্যাংক স্লিপ" : "Bank Slip"}</th>
                <th className="py-3 px-3.5 text-right">{isBangla ? "অ্যাকশন" : "Actions"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {pendingPayments.length === 0 ? (
                <tr>
                  <td colSpan={6} className="py-10 text-center text-slate-400">
                    <CheckCircle2 className="w-7 h-7 text-emerald-500 mx-auto mb-1.5" />
                    <span className="text-sm font-bold text-slate-700 block">
                      {isBangla ? "সকল ব্যাংক ডিপোজিট স্লিপ অনুমোদিত!" : "All bank deposit slips reviewed!"}
                    </span>
                    <span className="text-xs text-slate-400">
                      {isBangla ? "বর্তমানে কোনো অপেক্ষমান স্লিপ নেই।" : "No pending verification items in queue."}
                    </span>
                  </td>
                </tr>
              ) : (
                pendingPayments.map((p) => (
                  <tr key={p.id} className="hover:bg-slate-50/70 transition-colors">
                    <td className="py-3.5 px-3.5 font-mono font-bold text-slate-900 text-xs">
                      {p.investmentNo}
                    </td>

                    <td className="py-3.5 px-3.5">
                      <span className="font-bold text-slate-900 block text-xs">
                        {isBangla ? p.investorName_bn || p.investorName : p.investorName}
                      </span>
                      <span className="text-slate-500 text-[11px]">{p.phone}</span>
                    </td>

                    <td className="py-3.5 px-3.5">
                      <span className="font-bold text-[#0066FF] text-xs sm:text-sm block">
                        {formatBDT(p.grossAmount, { isBangla })}
                      </span>
                      <span className="text-slate-500 text-[11px]">
                        {p.shares} {isBangla ? "টি শেয়ার" : p.shares > 1 ? "Shares" : "Share"}
                      </span>
                    </td>

                    <td className="py-3.5 px-3.5">
                      <span className="px-2 py-0.5 rounded bg-slate-100 border border-slate-200 font-mono font-bold text-slate-800 text-[11px] block w-fit">
                        {p.reference}
                      </span>
                      <span className="text-slate-400 text-[10px] block mt-0.5">{p.submittedAt}</span>
                    </td>

                    <td className="py-3.5 px-3.5">
                      <button
                        onClick={() => setSelectedSlip(p)}
                        className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-slate-100 hover:bg-slate-200 border border-slate-200 text-slate-700 font-bold text-[11px] transition-colors cursor-pointer"
                      >
                        <Eye className="w-3.5 h-3.5 text-[#0066FF]" />
                        <span>{isBangla ? "স্লিপ দেখুন" : "View Slip"}</span>
                      </button>
                    </td>

                    <td className="py-3.5 px-3.5 text-right">
                      <div className="inline-flex gap-1.5">
                        <button
                          onClick={() => handleApprove(p)}
                          className="px-3 py-1.5 rounded-lg bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs transition-colors shadow-xs cursor-pointer"
                        >
                          {isBangla ? "অনুমোদন" : "Approve"}
                        </button>
                        <button
                          onClick={() => handleReject(p)}
                          className="px-2.5 py-1.5 rounded-lg bg-red-50 hover:bg-red-100 text-red-700 font-bold text-xs border border-red-200 transition-colors cursor-pointer"
                        >
                          {isBangla ? "বাতিল" : "Reject"}
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* View Slip Modal */}
      {selectedSlip && (
        <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-white border border-slate-200 shadow-2xl rounded-2xl max-w-md w-full p-5 space-y-4">
            <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <CreditCard className="w-4 h-4 text-[#0066FF]" />
                <span>{isBangla ? "ব্যাংক ডিপোজিট রসিদ বিবরণী" : "Bank Deposit Receipt Details"}</span>
              </h3>
              <button
                onClick={() => setSelectedSlip(null)}
                className="text-slate-400 hover:text-slate-700 text-base font-bold cursor-pointer"
              >
                ✕
              </button>
            </div>

            <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/80 space-y-2 text-xs">
              <div className="flex justify-between">
                <span className="text-slate-500">{isBangla ? "জমাদানকারীর নাম:" : "Depositor:"}</span>
                <span className="font-bold text-slate-900">{selectedSlip.investorName}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">{isBangla ? "মোট জমা:" : "Deposit Amount:"}</span>
                <span className="font-bold text-[#0066FF]">
                  {formatBDT(selectedSlip.grossAmount, { isBangla })}
                </span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">{isBangla ? "এসক্রো ব্যাংক:" : "Escrow Bank:"}</span>
                <span className="font-bold text-slate-900">{selectedSlip.bankName}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-500">{isBangla ? "ট্রানজেকশন স্লিপ নং:" : "Slip Ref #:"}</span>
                <span className="font-mono font-bold text-slate-900">{selectedSlip.reference}</span>
              </div>
            </div>

            <div className="pt-2 flex items-center justify-end gap-2">
              <button
                onClick={() => handleReject(selectedSlip)}
                className="px-3.5 py-2 rounded-xl text-red-600 hover:bg-red-50 text-xs font-bold border border-red-200 cursor-pointer"
              >
                {isBangla ? "প্রত্যাখ্যান" : "Reject"}
              </button>
              <button
                onClick={() => handleApprove(selectedSlip)}
                className="px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold shadow-sm shadow-[#0066FF]/20 cursor-pointer"
              >
                {isBangla ? "যাচাই ও অনুমোদন করুন" : "Verify & Approve Shares"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
