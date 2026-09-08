"use client";

import React, { useState, useEffect } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Clock,
  CheckCircle2,
  XCircle,
  Building2,
  Smartphone,
  Check,
  X,
  Search,
  RefreshCw,
} from "lucide-react";

interface AdminWithdrawal {
  id: string;
  userId: string;
  userName: string;
  projectId?: string;
  projectName?: string;
  projectNameBn?: string;
  type: "DIVIDEND" | "CAPITAL_EXIT";
  amount: number;
  fee: number;
  netAmount: number;
  payoutChannel: "BANK_TRANSFER" | "BKASH" | "NAGAD" | "ROCKET";
  bankName?: string;
  accountHolderName?: string;
  accountNumber?: string;
  branchName?: string;
  routingNumber?: string;
  mfsNumber?: string;
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "REJECTED" | "CANCELLED";
  userNote?: string;
  adminFeedback?: string;
  transactionRef?: string;
  createdAt: string;
  processedAt?: string;
}

export default function AdminWithdrawalsPage() {
  const { isBangla } = useAuth();
  const [withdrawals, setWithdrawals] = useState<AdminWithdrawal[]>([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState<"ALL" | "PENDING" | "COMPLETED" | "REJECTED">("ALL");
  const [search, setSearch] = useState("");
  const [actionModal, setActionModal] = useState<{
    item: AdminWithdrawal;
    action: "APPROVE" | "REJECT";
  } | null>(null);

  const [trxRef, setTrxRef] = useState("");
  const [adminNote, setAdminNote] = useState("");
  const [updating, setUpdating] = useState(false);

  const fetchWithdrawals = async () => {
    try {
      setLoading(true);
      const res = await fetch("/api/admin/withdrawals");
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

  const handleActionSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!actionModal) return;

    setUpdating(true);
    try {
      const res = await fetch("/api/admin/withdrawals", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id: actionModal.item.id,
          action: actionModal.action,
          transactionRef: trxRef.trim() || undefined,
          adminFeedback: adminNote.trim() || undefined,
        }),
      });
      const data = await res.json();
      if (data.success) {
        setActionModal(null);
        setTrxRef("");
        setAdminNote("");
        fetchWithdrawals();
      } else {
        alert(data.message || "Failed to update status");
      }
    } catch (err) {
      alert("Network error");
    } finally {
      setUpdating(false);
    }
  };

  const filtered = withdrawals.filter((w) => {
    if (filter === "PENDING" && w.status !== "PENDING" && w.status !== "PROCESSING") return false;
    if (filter === "COMPLETED" && w.status !== "COMPLETED") return false;
    if (filter === "REJECTED" && w.status !== "REJECTED") return false;
    if (search.trim()) {
      const q = search.toLowerCase();
      return (
        w.userName.toLowerCase().includes(q) ||
        w.id.toLowerCase().includes(q) ||
        (w.accountNumber && w.accountNumber.includes(q))
      );
    }
    return true;
  });

  const pendingCount = withdrawals.filter((w) => w.status === "PENDING").length;
  const totalDisbursed = withdrawals
    .filter((w) => w.status === "COMPLETED")
    .reduce((sum, w) => sum + w.amount, 0);

  return (
    <div className="space-y-5 font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-amber-50 text-amber-700 border border-amber-200">
              {isBangla ? "ট্রেজারি ও নিষ্পত্তি" : "TREASURY & DISBURSEMENT"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "উত্তোলন অনুমোদন কিউ" : "Withdrawal Approvals Queue"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "শেয়ারহোল্ডারদের লভ্যাংশ ও মূলধন প্রত্যাহারের আবেদন যাচাই ও ব্যাংক EFT/NPSB অনুমোদন"
              : "Review and settle shareholder dividend and capital liquidation requests"}
          </p>
        </div>

        <button
          onClick={fetchWithdrawals}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold border border-slate-200 transition-all cursor-pointer"
        >
          <RefreshCw className={`w-3.5 h-3.5 ${loading ? "animate-spin" : ""}`} />
          <span>{isBangla ? "রিফ্রেশ" : "Refresh Queue"}</span>
        </button>
      </div>

      {/* KPI Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1">
          <span className="text-[11px] font-semibold text-amber-600 uppercase tracking-wider block">
            {isBangla ? "অপেক্ষমান আবেদন" : "Pending Approvals"}
          </span>
          <span className="text-2xl font-black text-amber-700 font-mono block">{pendingCount}</span>
          <span className="text-[11px] text-slate-500 block">
            {isBangla ? "যাচাই ও নিষ্পত্তির অপেক্ষায়" : "Awaiting compliance signoff"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1">
          <span className="text-[11px] font-semibold text-emerald-600 uppercase tracking-wider block">
            {isBangla ? "মোট পরিশোধিত তহবিল" : "Total Disbursed"}
          </span>
          <span className="text-2xl font-black text-emerald-700 font-mono block">
            {formatBDT(totalDisbursed, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block">
            {isBangla ? "সিটি ব্যাংক এসক্রো ক্লিয়ারেন্স" : "City Bank Escrow Cleared"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1">
          <span className="text-[11px] font-semibold text-[#0066FF] uppercase tracking-wider block">
            {isBangla ? "সর্বমোট আবেদন সংখ্যা" : "Total Applications"}
          </span>
          <span className="text-2xl font-black text-[#0066FF] font-mono block">{withdrawals.length}</span>
          <span className="text-[11px] text-slate-500 block">
            {isBangla ? "বাৎসরিক নিষ্পন্ন খতিয়ান" : "Lifetime requests logged"}
          </span>
        </div>
      </div>

      {/* Filter and Search Bar */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3">
        <div className="flex items-center gap-1.5 p-1 bg-slate-100 rounded-xl max-w-sm">
          {(["ALL", "PENDING", "COMPLETED", "REJECTED"] as const).map((f) => (
            <button
              key={f}
              onClick={() => setFilter(f)}
              className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all cursor-pointer ${
                filter === f ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
              }`}
            >
              {f === "ALL"
                ? isBangla ? "সকল" : "All"
                : f === "PENDING"
                ? isBangla ? "অপেক্ষমান" : "Pending"
                : f === "COMPLETED"
                ? isBangla ? "অনুমোদিত" : "Disbursed"
                : isBangla ? "প্রত্যাখ্যাত" : "Declined"}
            </button>
          ))}
        </div>

        <div className="relative max-w-xs w-full">
          <Search className="w-3.5 h-3.5 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
          <input
            type="text"
            placeholder={isBangla ? "নাম বা আইডি খুঁজুন..." : "Search investor or ID..."}
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-8 pr-3 py-1.5 text-xs bg-white border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
          />
        </div>
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-4">{isBangla ? "বিনিয়োগকারী" : "Investor"}</th>
                <th className="py-3 px-4">{isBangla ? "উত্তোলন প্রকার" : "Type"}</th>
                <th className="py-3 px-4">{isBangla ? "পরিমাণ" : "Amount"}</th>
                <th className="py-3 px-4">{isBangla ? "পেমেন্ট মাধ্যম" : "Destination"}</th>
                <th className="py-3 px-4">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
                <th className="py-3 px-4">{isBangla ? "অ্যাকশন" : "Action"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                <tr>
                  <td colSpan={6} className="text-center py-8 text-slate-400">
                    Loading queue...
                  </td>
                </tr>
              ) : filtered.length === 0 ? (
                <tr>
                  <td colSpan={6} className="text-center py-8 text-slate-400">
                    {isBangla ? "কোনো আবেদন পাওয়া যায়নি" : "No requests found"}
                  </td>
                </tr>
              ) : (
                filtered.map((w) => (
                  <tr key={w.id} className="hover:bg-slate-50/60 transition-colors">
                    <td className="py-3.5 px-4">
                      <div className="font-bold text-slate-900">{w.userName}</div>
                      <div className="text-[10px] text-slate-400 font-mono">{w.userId}</div>
                    </td>
                    <td className="py-3.5 px-4">
                      <span className="font-semibold text-slate-700">
                        {w.type === "DIVIDEND"
                          ? isBangla ? "লভ্যাংশ" : "Dividend"
                          : isBangla ? "মূলধন প্রস্থান" : "Capital Exit"}
                      </span>
                    </td>
                    <td className="py-3.5 px-4">
                      <span className="font-black text-slate-900 font-mono text-sm">
                        {formatBDT(w.amount, { isBangla })}
                      </span>
                    </td>
                    <td className="py-3.5 px-4">
                      <div className="font-medium text-slate-800">
                        {w.payoutChannel === "BANK_TRANSFER" ? w.bankName || "The City Bank Limited" : w.payoutChannel}
                      </div>
                      <div className="text-[10px] text-slate-400 font-mono">
                        {w.accountNumber || w.mfsNumber}
                      </div>
                    </td>
                    <td className="py-3.5 px-4">
                      <span
                        className={`inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold ${
                          w.status === "COMPLETED"
                            ? "bg-emerald-50 text-emerald-700 border border-emerald-200"
                            : w.status === "PENDING"
                            ? "bg-amber-50 text-amber-700 border border-amber-200"
                            : "bg-red-50 text-red-700 border border-red-200"
                        }`}
                      >
                        {w.status === "COMPLETED" ? "Settled" : w.status === "PENDING" ? "Pending" : "Declined"}
                      </span>
                    </td>
                    <td className="py-3.5 px-4">
                      {w.status === "PENDING" ? (
                        <div className="flex items-center gap-2">
                          <button
                            onClick={() => {
                              setActionModal({ item: w, action: "APPROVE" });
                              setTrxRef(`CBL-EFT-${Date.now().toString().substring(5)}`);
                            }}
                            className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-[11px] cursor-pointer"
                          >
                            <Check className="w-3 h-3" />
                            <span>{isBangla ? "অনুমোদন" : "Approve"}</span>
                          </button>
                          <button
                            onClick={() => {
                              setActionModal({ item: w, action: "REJECT" });
                              setTrxRef("");
                            }}
                            className="inline-flex items-center gap-1 px-2 py-1 rounded-lg border border-red-300 text-red-600 hover:bg-red-50 font-bold text-[11px] cursor-pointer"
                          >
                            <X className="w-3 h-3" />
                            <span>{isBangla ? "প্রত্যাখ্যান" : "Decline"}</span>
                          </button>
                        </div>
                      ) : (
                        <span className="text-[11px] font-mono text-slate-400">
                          {w.transactionRef || "—"}
                        </span>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Approve/Reject Modal */}
      {actionModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-xs p-4">
          <div className="bg-white rounded-2xl max-w-md w-full p-5 shadow-xl space-y-4">
            <h2 className="text-base font-bold text-slate-900 border-b border-slate-100 pb-2">
              {actionModal.action === "APPROVE"
                ? isBangla ? "উত্তোলন অনুমোদন ও নিষ্পত্তি" : "Disburse Withdrawal Settlement"
                : isBangla ? "উত্তোলন আবেদন বাতিল" : "Decline Withdrawal Request"}
            </h2>

            <form onSubmit={handleActionSubmit} className="space-y-3 text-xs">
              <div className="p-3 bg-slate-50 rounded-xl space-y-1">
                <div className="font-bold text-slate-800">{actionModal.item.userName}</div>
                <div className="text-slate-500 font-mono">
                  Amount: {formatBDT(actionModal.item.amount, { isBangla })} ({actionModal.item.type})
                </div>
                <div className="text-slate-500">
                  Channel: {actionModal.item.accountNumber ? `${actionModal.item.bankName || "Bank"} (${actionModal.item.accountNumber})` : (actionModal.item.mfsNumber || actionModal.item.payoutChannel)}
                </div>
              </div>

              {actionModal.action === "APPROVE" ? (
                <div className="space-y-1">
                  <label className="font-bold text-slate-700 block">
                    {isBangla ? "ব্যাংক EFTN / Trx রেফারেন্স *" : "Bank Clearing / Trx Reference *"}
                  </label>
                  <input
                    type="text"
                    required
                    value={trxRef}
                    onChange={(e) => setTrxRef(e.target.value)}
                    placeholder="e.g. CBL-EFT-994821"
                    className="w-full px-3 py-2 text-xs border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
                  />
                </div>
              ) : null}

              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {actionModal.action === "APPROVE"
                    ? isBangla ? "অ্যাডমিন মন্তব্য (ঐচ্ছিক)" : "Disbursement Note (Optional)"
                    : isBangla ? "বাতিলের কারণ *" : "Reason for Declining *"}
                </label>
                <textarea
                  required={actionModal.action === "REJECT"}
                  rows={2}
                  value={adminNote}
                  onChange={(e) => setAdminNote(e.target.value)}
                  placeholder={
                    actionModal.action === "APPROVE"
                      ? "Disbursed via BEFTN clearing..."
                      : "State specific reason..."
                  }
                  className="w-full px-3 py-2 text-xs border border-slate-200 rounded-xl focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>

              <div className="flex items-center justify-end gap-2 pt-2">
                <button
                  type="button"
                  onClick={() => setActionModal(null)}
                  className="px-4 py-2 rounded-xl text-slate-600 font-bold hover:bg-slate-100 cursor-pointer"
                >
                  {isBangla ? "বাতিল" : "Cancel"}
                </button>
                <button
                  type="submit"
                  disabled={updating}
                  className={`px-4 py-2 rounded-xl font-bold text-white shadow-xs cursor-pointer ${
                    actionModal.action === "APPROVE"
                      ? "bg-emerald-600 hover:bg-emerald-700"
                      : "bg-red-600 hover:bg-red-700"
                  }`}
                >
                  {updating
                    ? isBangla ? "প্রক্রিয়াধীন..." : "Updating..."
                    : actionModal.action === "APPROVE"
                    ? isBangla ? "নিষ্পত্তি সম্পন্ন করুন" : "Confirm Settlement"
                    : isBangla ? "প্রত্যাখ্যান নিশ্চিত করুন" : "Confirm Decline"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
