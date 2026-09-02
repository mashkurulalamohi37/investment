"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Receipt, PlusCircle, CheckCircle2, ShieldCheck, Download } from "lucide-react";

export default function AdminExpensesPage() {
  const { isBangla } = useAuth();

  const [vouchers, setVouchers] = useState([
    {
      no: "VCH-LV100-001",
      category: "LEGAL_REGISTRATION",
      title: "Sub-Registry Deed Stamp Duty & Registry",
      payee: "Savar Sub-Registry Revenue Office",
      amount: 450000,
      date: "2026-08-05",
      auditor: "Finance Directorate",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-002",
      category: "LAND_PURCHASE",
      title: "Land Acquisition Tranche 1 Settlement",
      payee: "Land Owner (Pay-Order Clearing)",
      amount: 1250000,
      date: "2026-08-12",
      auditor: "Legal & Audit Team",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-003",
      category: "DEVELOPMENT_FENCING",
      title: "RCC Pillar Demarcation & Site Development",
      payee: "Civil Demarcation Contractors",
      amount: 180000,
      date: "2026-08-20",
      auditor: "Site Inspection Team",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-004",
      category: "SURVEY_DEMARCATION",
      title: "Digital GPS Survey & Land Demarcation",
      payee: "Govt Certified Cadastral Surveyor",
      amount: 45000,
      date: "2026-08-25",
      auditor: "Audit Directorate",
      status: "AUDITED",
    },
  ]);

  const [showModal, setShowModal] = useState(false);
  const [title, setTitle] = useState("");
  const [payee, setPayee] = useState("");
  const [amount, setAmount] = useState("");
  const [category, setCategory] = useState("SITE_DEVELOPMENT");

  const handleAddVoucher = (e: React.FormEvent) => {
    e.preventDefault();
    const newVch = {
      no: `VCH-LV100-${String(vouchers.length + 1).padStart(3, "0")}`,
      category,
      title,
      payee,
      amount: parseFloat(amount) || 0,
      date: new Date().toISOString().split("T")[0],
      auditor: "Finance Directorate",
      status: "AUDITED",
    };
    setVouchers([newVch, ...vouchers]);
    setShowModal(false);
    setTitle("");
    setPayee("");
    setAmount("");
  };

  return (
    <div className="space-y-8">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-800">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-white">
            Project Expense Vouchers Ledger
          </h1>
          <p className="text-xs text-slate-400">
            Institutional ledger of all disbursements cleared from City Bank Escrow with payee records
          </p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-gold text-slate-950 font-bold text-xs hover:bg-gold-light"
        >
          <PlusCircle className="w-4 h-4" />
          <span>Record New Expense Voucher</span>
        </button>
      </div>

      {/* Vouchers Table */}
      <div className="bg-slate-900 rounded-2xl border border-slate-800 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-950 border-b border-slate-800 text-slate-400 font-bold">
              <tr>
                <th className="py-3.5 px-4">Voucher No</th>
                <th className="py-3.5 px-4">Purpose / Particulars</th>
                <th className="py-3.5 px-4">Payee</th>
                <th className="py-3.5 px-4">Date</th>
                <th className="py-3.5 px-4 text-right">Amount</th>
                <th className="py-3.5 px-4 text-center">Audit Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800 text-slate-300 font-medium">
              {vouchers.map((vch) => (
                <tr key={vch.no} className="hover:bg-slate-800/60">
                  <td className="py-3.5 px-4 font-mono font-bold text-gold">{vch.no}</td>
                  <td className="py-3.5 px-4 font-semibold text-white">{vch.title}</td>
                  <td className="py-3.5 px-4 text-slate-400">{vch.payee}</td>
                  <td className="py-3.5 px-4 font-mono text-slate-500">{vch.date}</td>
                  <td className="py-3.5 px-4 text-right font-mono font-bold text-white text-sm">
                    {formatBDT(vch.amount, { isBangla })}
                  </td>
                  <td className="py-3.5 px-4 text-center">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-950 text-emerald-400 border border-emerald-800">
                      <CheckCircle2 className="w-3 h-3" />
                      {vch.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* New Voucher Modal */}
      {showModal && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-slate-900 border border-slate-800 rounded-3xl max-w-md w-full p-6 space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-slate-800">
              <h3 className="font-bold text-white text-base">Record Project Expense</h3>
              <button onClick={() => setShowModal(false)} className="text-slate-400 hover:text-white">✕</button>
            </div>

            <form onSubmit={handleAddVoucher} className="space-y-4 text-xs">
              <div>
                <label className="font-bold text-slate-300 block mb-1">Expense Particulars / Title</label>
                <input
                  type="text"
                  required
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="e.g. Boundary wall construction materials"
                  className="w-full px-3.5 py-2.5 rounded-xl bg-slate-950 border border-slate-800 text-white text-sm focus:outline-none focus:border-gold"
                />
              </div>

              <div>
                <label className="font-bold text-slate-300 block mb-1">Payee Name</label>
                <input
                  type="text"
                  required
                  value={payee}
                  onChange={(e) => setPayee(e.target.value)}
                  placeholder="e.g. Contractor or Vendor name"
                  className="w-full px-3.5 py-2.5 rounded-xl bg-slate-950 border border-slate-800 text-white text-sm focus:outline-none focus:border-gold"
                />
              </div>

              <div>
                <label className="font-bold text-slate-300 block mb-1">Amount (BDT)</label>
                <input
                  type="number"
                  required
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  placeholder="e.g. 150000"
                  className="w-full px-3.5 py-2.5 rounded-xl bg-slate-950 border border-slate-800 text-white text-sm focus:outline-none focus:border-gold font-mono"
                />
              </div>

              <button
                type="submit"
                className="w-full py-3.5 rounded-xl bg-gold text-slate-950 font-bold text-xs hover:bg-gold-light transition-all"
              >
                Record Voucher & Update Ledger
              </button>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
