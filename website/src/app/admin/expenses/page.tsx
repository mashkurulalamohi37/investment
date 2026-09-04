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
      category: "PROJECT_PARTNERSHIP",
      title: "Project Partnership Agreement Processing & Legal Notarization",
      title_bn: "প্রজেক্ট পার্টনারশিপ চুক্তি ও আইনগত নোটারাইজেশন ফি",
      payee: "Legal Directorate & Notary Registry",
      payee_bn: "আইনি অধিদপ্তর ও নোটারি রেজিস্ট্রি",
      amount: 450000,
      date: "2026-08-05",
      auditor: "Finance Directorate",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-002",
      category: "LAND_PURCHASE",
      title: "Land Acquisition Tranche 1 Settlement",
      title_bn: "জমি ক্রয়ের প্রথম কিস্তি পরিশোধ ও দলিল সম্পাদন",
      payee: "Land Owner (Pay-Order Clearing)",
      payee_bn: "জমির মূল মালিক (পে-অর্ডার ক্লিয়ারেন্স)",
      amount: 1250000,
      date: "2026-08-12",
      auditor: "Legal & Audit Team",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-003",
      category: "DEVELOPMENT_FENCING",
      title: "RCC Pillar Demarcation & Site Development",
      title_bn: "আরসিসি পিলার সীমানা প্রাচীর ও সাইট উন্নয়ন কাজ",
      payee: "Civil Demarcation Contractors",
      payee_bn: "সিভিল কন্ট্রাক্টরস লিমিটেড",
      amount: 180000,
      date: "2026-08-20",
      auditor: "Site Inspection Team",
      status: "AUDITED",
    },
    {
      no: "VCH-LV100-004",
      category: "SURVEY_DEMARCATION",
      title: "Digital GPS Survey & Demarcation",
      title_bn: "ডিজিটাল জিপিএস সার্ভে ও সরকারি ভূমি রেকর্ড যাচাই",
      payee: "Govt Certified Cadastral Surveyor",
      payee_bn: "সরকারি সনদপ্রাপ্ত সার্ভেয়ার",
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

  const totalExpenseSum = vouchers.reduce((acc, v) => acc + v.amount, 0);

  const handleAddVoucher = (e: React.FormEvent) => {
    e.preventDefault();
    const newVch = {
      no: `VCH-LV100-${String(vouchers.length + 1).padStart(3, "0")}`,
      category,
      title,
      title_bn: title,
      payee,
      payee_bn: payee,
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
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "এসক্রো অডিট লেজার" : "ESCROW AUDIT LEDGER"}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200">
              {isBangla ? `মোট খরচ: ${formatBDT(totalExpenseSum, { isBangla })}` : `Total: ${formatBDT(totalExpenseSum, { isBangla })}`}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "প্রজেক্ট ব্যয় ভাউচার ও নিরীক্ষিত লেজার" : "Project Expense Vouchers Ledger"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "সিটি ব্যাংক এসক্রো তহবিল ব্যবহারের প্রতি রশিদের আইটেমাইজড অডিট ও ভাউচার হিস্ট্রি"
              : "Maintain itemized audit trails for all City Bank Escrow fund utilization and payee disbursements"}
          </p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-4 h-4 text-white" />
          <span>{isBangla ? "নতুন ভাউচার এন্ট্রি করুন" : "Record New Expense Voucher"}</span>
        </button>
      </div>

      {/* Vouchers Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-3.5">{isBangla ? "ভাউচার নং" : "Voucher #"}</th>
                <th className="py-3 px-3.5">{isBangla ? "ব্যয়ের শিরোনাম ও বিবরণ" : "Expense Title & Description"}</th>
                <th className="py-3 px-3.5">{isBangla ? "প্রাপক / ভেন্ডর" : "Payee / Contractor"}</th>
                <th className="py-3 px-3.5">{isBangla ? "ব্যয়ের পরিমাণ" : "Amount (BDT)"}</th>
                <th className="py-3 px-3.5">{isBangla ? "তারিখ" : "Date"}</th>
                <th className="py-3 px-3.5 text-right">{isBangla ? "নিরীক্ষা স্ট্যাটাস" : "Audit Status"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {vouchers.map((v) => (
                <tr key={v.no} className="hover:bg-slate-50/70 transition-colors">
                  <td className="py-3.5 px-3.5 font-mono font-bold text-slate-900 text-xs">
                    {v.no}
                  </td>

                  <td className="py-3.5 px-3.5">
                    <span className="font-bold text-slate-900 block text-xs">
                      {isBangla ? v.title_bn || v.title : v.title}
                    </span>
                    <span className="text-slate-400 text-[10px] font-mono">{v.category}</span>
                  </td>

                  <td className="py-3.5 px-3.5 text-slate-800 text-xs">
                    {isBangla ? v.payee_bn || v.payee : v.payee}
                  </td>

                  <td className="py-3.5 px-3.5">
                    <span className="font-bold text-amber-700 text-xs sm:text-sm">
                      {formatBDT(v.amount, { isBangla })}
                    </span>
                  </td>

                  <td className="py-3.5 px-3.5 text-slate-600 font-mono text-[11px]">
                    {v.date}
                  </td>

                  <td className="py-3.5 px-3.5 text-right">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                      <ShieldCheck className="w-3 h-3 text-emerald-600" />
                      <span>{isBangla ? "নিরীক্ষিত" : "AUDITED"}</span>
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-white border border-slate-200 shadow-2xl rounded-2xl max-w-md w-full p-5 space-y-4">
            <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Receipt className="w-4 h-4 text-[#0066FF]" />
                <span>{isBangla ? "নতুন খরচের ভাউচার এন্ট্রি" : "Record Audited Expense Voucher"}</span>
              </h3>
              <button
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-700 text-base font-bold cursor-pointer"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleAddVoucher} className="space-y-3 text-xs font-semibold text-slate-700">
              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "খরচের বিবরণ / উদ্দেশ্য" : "Expense Description"}
                </label>
                <input
                  type="text"
                  required
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="e.g. Boundary Demarcation & Legal Vetting"
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                />
              </div>

              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "প্রাপক / প্রতিষ্ঠান" : "Payee / Contractor Name"}
                </label>
                <input
                  type="text"
                  required
                  value={payee}
                  onChange={(e) => setPayee(e.target.value)}
                  placeholder="e.g. Dhaka Registry Office"
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "মোট টাকা (BDT)" : "Amount (BDT)"}
                  </label>
                  <input
                    type="number"
                    required
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    placeholder="150000"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "ক্যাটাগরি" : "Expense Category"}
                  </label>
                  <select
                    value={category}
                    onChange={(e) => setCategory(e.target.value)}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  >
                    <option value="LAND_PURCHASE">{isBangla ? "জমি ক্রয়" : "Land Purchase"}</option>
                    <option value="LEGAL_NOTARIZATION">{isBangla ? "আইনি ও নোটারি" : "Legal & Notarization"}</option>
                    <option value="SITE_DEVELOPMENT">{isBangla ? "সাইট উন্নয়ন" : "Site Development"}</option>
                    <option value="SURVEY_RECORD">{isBangla ? "সার্ভে ও রেকর্ড" : "Survey & Demarcation"}</option>
                  </select>
                </div>
              </div>

              <div className="pt-2 flex items-center justify-end gap-2.5">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-4 py-2 rounded-xl text-slate-600 hover:bg-slate-100 text-xs font-bold"
                >
                  {isBangla ? "বাতিল" : "Cancel"}
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold shadow-sm shadow-[#0066FF]/20 cursor-pointer"
                >
                  {isBangla ? "ভাউচার যুক্ত করুন" : "Save Voucher"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
