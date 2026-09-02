"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ShieldAlert,
  Coins,
  Users,
  Layers,
  ArrowRight,
  Clock,
  CheckCircle2,
  AlertTriangle,
  Receipt,
} from "lucide-react";

export default function AdminOverviewPage() {
  const { isBangla } = useAuth();

  const metrics = {
    totalRaised: 1887000,
    targetFund: 2550000,
    allocatedShares: 74,
    totalShares: 100,
    pendingPaymentsCount: 3,
    pendingKycCount: 5,
    escrowBalance: 625000,
    totalExpenses: 1925000,
  };

  return (
    <div className="space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-800">
        <div>
          <span className="px-2.5 py-0.5 rounded text-[10px] font-mono font-bold bg-gold/20 text-gold">
            LANDVEST 100 (LV100)
          </span>
          <h1 className="text-2xl sm:text-3xl font-black text-white mt-1">
            Executive Admin Control Center
          </h1>
          <p className="text-xs text-slate-400">
            Real-time project capital, share lot allocations, and pending compliance queues
          </p>
        </div>

        <Link
          href="/admin/payments"
          className="inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-gold text-slate-950 font-bold text-xs hover:bg-gold-light transition-all shadow-md"
        >
          <span>Review 3 Pending Bank Slips</span>
          <ArrowRight className="w-4 h-4" />
        </Link>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
        <div className="p-5 rounded-2xl bg-slate-900 border border-slate-800 space-y-2">
          <span className="text-xs font-semibold text-slate-400 block">Total Capital Raised</span>
          <span className="text-xl sm:text-2xl font-black text-gold font-mono block">
            {formatBDT(metrics.totalRaised, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-mono">
            74.0% of {formatBDT(metrics.targetFund, { isBangla })}
          </span>
        </div>

        <div className="p-5 rounded-2xl bg-slate-900 border border-slate-800 space-y-2">
          <span className="text-xs font-semibold text-slate-400 block">Share Lot Allocation</span>
          <span className="text-xl sm:text-2xl font-black text-white font-mono block">
            {metrics.allocatedShares} / {metrics.totalShares} Shares
          </span>
          <span className="text-[11px] text-jade block font-semibold">26 Shares Available</span>
        </div>

        <div className="p-5 rounded-2xl bg-slate-900 border border-slate-800 space-y-2">
          <span className="text-xs font-semibold text-slate-400 block">City Bank Escrow Balance</span>
          <span className="text-xl sm:text-2xl font-black text-jade font-mono block">
            {formatBDT(metrics.escrowBalance, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-mono">A/C: 1402-9988-7710-1</span>
        </div>

        <div className="p-5 rounded-2xl bg-slate-900 border border-slate-800 space-y-2">
          <span className="text-xs font-semibold text-slate-400 block">Audited Project Expenses</span>
          <span className="text-xl sm:text-2xl font-black text-amber-400 font-mono block">
            {formatBDT(metrics.totalExpenses, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-mono">4 Approved Vouchers</span>
        </div>
      </div>

      {/* Action Queues & Quick Operations */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Payment Review Queue Box */}
        <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800 space-y-4">
          <div className="flex items-center justify-between pb-3 border-b border-slate-800">
            <h3 className="font-bold text-white text-base flex items-center gap-2">
              <Clock className="w-4 h-4 text-gold" />
              <span>Pending Bank Slips Queue</span>
            </h3>
            <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-amber-500/20 text-amber-400">
              3 ACTION REQUIRED
            </span>
          </div>

          <div className="space-y-3 text-xs">
            <div className="p-3 rounded-xl bg-slate-800/80 border border-slate-700/80 flex items-center justify-between">
              <div>
                <span className="font-bold text-white block">Dr. Tanvir Hasan (2 Shares)</span>
                <span className="text-slate-400 font-mono text-[11px]">Slip #DEP-CITY-8910 • ৳ 51,000</span>
              </div>
              <Link
                href="/admin/payments"
                className="px-3 py-1.5 rounded-lg bg-gold text-slate-950 font-bold text-[11px] hover:bg-gold-light"
              >
                Inspect
              </Link>
            </div>

            <div className="p-3 rounded-xl bg-slate-800/80 border border-slate-700/80 flex items-center justify-between">
              <div>
                <span className="font-bold text-white block">Nusrat Jahan (1 Share)</span>
                <span className="text-slate-400 font-mono text-[11px]">Slip #DEP-CITY-8914 • ৳ 25,500</span>
              </div>
              <Link
                href="/admin/payments"
                className="px-3 py-1.5 rounded-lg bg-gold text-slate-950 font-bold text-[11px] hover:bg-gold-light"
              >
                Inspect
              </Link>
            </div>
          </div>
        </div>

        {/* Quick Voucher Entry Box */}
        <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800 space-y-4">
          <div className="flex items-center justify-between pb-3 border-b border-slate-800">
            <h3 className="font-bold text-white text-base flex items-center gap-2">
              <Receipt className="w-4 h-4 text-jade" />
              <span>Project Expense Management</span>
            </h3>
            <Link href="/admin/expenses" className="text-xs font-bold text-gold hover:underline">
              View All Vouchers →
            </Link>
          </div>

          <p className="text-xs text-slate-400 leading-relaxed">
            Record newly disbursed bills from the City Bank Escrow account for surveyor fees, registration duties, and boundary demarcation.
          </p>

          <Link
            href="/admin/expenses"
            className="w-full py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white text-xs font-bold flex items-center justify-center gap-2 transition-all"
          >
            <span>Open Expense Voucher Ledger</span>
            <ArrowRight className="w-4 h-4 text-gold" />
          </Link>
        </div>
      </div>
    </div>
  );
}
