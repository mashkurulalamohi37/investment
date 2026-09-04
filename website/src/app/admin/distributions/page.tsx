"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  TrendingUp,
  PlusCircle,
  Coins,
  CheckCircle2,
  Calendar,
  Layers,
  ArrowRight,
  Download,
  Receipt,
  Sparkles,
} from "lucide-react";

export default function AdminDistributionsPage() {
  const { isBangla } = useAuth();

  const [distributions, setDistributions] = useState([
    {
      id: "dist-01",
      period: "H1 2026 Commercial Dividend",
      period_bn: "এইচ১ ২০২৬ বাণিজ্যিক লভ্যাংশ",
      project: "LandVest 100",
      project_bn: "ল্যান্ডভেস্ট ১০০",
      totalProfit: 250000,
      totalSharesEligible: 74,
      dividendPerShare: 2500,
      disbursedAt: "2026-08-28",
      status: "DISBURSED",
    },
    {
      id: "dist-02",
      period: "Q3 2026 Agro Harvest Interim Return",
      period_bn: "কিউ৩ ২০২৬ কৃষি ফসল বিক্রয় মুনাফা",
      project: "Smart Agro Farming (Season 1)",
      project_bn: "স্মার্ট এগ্রো ফার্মিং (সিজন ১)",
      totalProfit: 168000,
      totalSharesEligible: 42,
      dividendPerShare: 4000,
      disbursedAt: "2026-09-01",
      status: "DISBURSED",
    },
  ]);

  const [showModal, setShowModal] = useState(false);
  const [periodName, setPeriodName] = useState("");
  const [selectedProject, setSelectedProject] = useState("LandVest 100");
  const [totalPool, setTotalPool] = useState("");
  const [sharesCount, setSharesCount] = useState("74");

  const calcPerShare =
    parseFloat(totalPool) && parseInt(sharesCount, 10)
      ? (parseFloat(totalPool) / parseInt(sharesCount, 10)).toFixed(0)
      : "0";

  const handleDeclareDividend = (e: React.FormEvent) => {
    e.preventDefault();
    const newDist = {
      id: `dist-${Date.now()}`,
      period: periodName,
      period_bn: periodName,
      project: selectedProject,
      project_bn: selectedProject,
      totalProfit: parseFloat(totalPool) || 0,
      totalSharesEligible: parseInt(sharesCount, 10) || 74,
      dividendPerShare: parseFloat(calcPerShare) || 0,
      disbursedAt: new Date().toISOString().split("T")[0],
      status: "DISBURSED",
    };
    setDistributions([newDist, ...distributions]);
    setShowModal(false);
    setPeriodName("");
    setTotalPool("");
  };

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "প্রো-রাটা ডিভিডেন্ড ইঞ্জিন" : "PRO-RATA ENGINE"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "লভ্যাংশ ও মুনাফা বণ্টন ইঞ্জিন" : "Profit & Dividend Distribution Engine"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "মাইলস্টোন অর্জিত আয় ঘোষণা, প্রো-রাটা লভ্যাংশ হিসাব এবং সরাসরি ব্যাংক হিসাবে মুনাফা প্রদান"
              : "Declare milestone earnings, execute pro-rata dividend calculation, and disburse profits directly to investor accounts"}
          </p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-4 h-4 text-white" />
          <span>{isBangla ? "নতুন লভ্যাংশ ঘোষণা করুন" : "Declare New Distribution"}</span>
        </button>
      </div>

      {/* KPI Stats */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 sm:gap-4">
        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] uppercase tracking-wider text-slate-500 font-semibold block">
            {isBangla ? "মোট বণ্টিত মুনাফা" : "Total Profits Disbursed"}
          </span>
          <span className="text-lg sm:text-xl font-black text-emerald-700 block">
            {formatBDT(418000, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "২টি সফল বণ্টন চক্র" : "2 Completed Distribution Cycles"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] uppercase tracking-wider text-slate-500 font-semibold block">
            {isBangla ? "গড় শেয়ার প্রতি লভ্যাংশ" : "Average Dividend / Share"}
          </span>
          <span className="text-lg sm:text-xl font-black text-[#0066FF] block">
            {formatBDT(3250, { isBangla })}
          </span>
          <span className="text-[11px] text-slate-500 block font-medium">
            {isBangla ? "১০০% ব্যাংক ট্রান্সফারে জমা" : "100% Settled to Bank Accounts"}
          </span>
        </div>

        <div className="p-4 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-1.5">
          <span className="text-[11px] uppercase tracking-wider text-slate-500 font-semibold block">
            {isBangla ? "অংশগ্রহণকারী মোট শেয়ার" : "Participating Shares"}
          </span>
          <span className="text-lg sm:text-xl font-black text-slate-900 block">
            116 {isBangla ? "টি শেয়ার" : "Units Total"}
          </span>
          <span className="text-[11px] text-emerald-700 block font-bold">
            {isBangla ? "০% পেন্ডিং ডিসবার্সমেন্ট" : "0% Pending Disputes"}
          </span>
        </div>
      </div>

      {/* Distributions Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-3.5">{isBangla ? "বণ্টন বিবরণ ও সময়কাল" : "Period & Title"}</th>
                <th className="py-3 px-3.5">{isBangla ? "প্রজেক্ট" : "Project"}</th>
                <th className="py-3 px-3.5">{isBangla ? "মোট মুনাফা পুল" : "Total Profit Pool"}</th>
                <th className="py-3 px-3.5">{isBangla ? "শেয়ার প্রতি রিটার্ন" : "Dividend / Share"}</th>
                <th className="py-3 px-3.5">{isBangla ? "সেটেলমেন্ট তারিখ" : "Settlement Date"}</th>
                <th className="py-3 px-3.5 text-right">{isBangla ? "স্ট্যাটাস" : "Status"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {distributions.map((d) => (
                <tr key={d.id} className="hover:bg-slate-50/70 transition-colors">
                  <td className="py-3.5 px-3.5">
                    <span className="font-bold text-slate-900 block text-xs">
                      {isBangla ? d.period_bn || d.period : d.period}
                    </span>
                    <span className="text-slate-500 text-[11px]">
                      {d.totalSharesEligible} {isBangla ? "টি শেয়ার যোগ্য" : "Eligible Shares"}
                    </span>
                  </td>

                  <td className="py-3.5 px-3.5 font-semibold text-slate-800 text-xs">
                    {isBangla ? d.project_bn || d.project : d.project}
                  </td>

                  <td className="py-3.5 px-3.5">
                    <span className="font-bold text-emerald-700 text-xs sm:text-sm">
                      {formatBDT(d.totalProfit, { isBangla })}
                    </span>
                  </td>

                  <td className="py-3.5 px-3.5">
                    <span className="font-bold text-[#0066FF] text-xs sm:text-sm">
                      {formatBDT(d.dividendPerShare, { isBangla })}
                    </span>
                  </td>

                  <td className="py-3.5 px-3.5 text-slate-600 font-mono text-[11px]">
                    {d.disbursedAt}
                  </td>

                  <td className="py-3.5 px-3.5 text-right">
                    <span className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                      <CheckCircle2 className="w-3 h-3 text-emerald-600" />
                      <span>{isBangla ? "নিষ্পন্ন" : "DISBURSED"}</span>
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
                <TrendingUp className="w-4 h-4 text-[#0066FF]" />
                <span>{isBangla ? "নতুন মুনাফা বণ্টন ঘোষণা" : "Declare Milestone Dividend"}</span>
              </h3>
              <button
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-700 text-base font-bold cursor-pointer"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleDeclareDividend} className="space-y-3 text-xs font-semibold text-slate-700">
              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "বণ্টন শিরোনাম / সময়কাল" : "Distribution Title / Period"}
                </label>
                <input
                  type="text"
                  required
                  value={periodName}
                  onChange={(e) => setPeriodName(e.target.value)}
                  placeholder="e.g. Q4 2026 Agro Harvest Final Return"
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                />
              </div>

              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "সম্পর্কিত প্রজেক্ট" : "Applicable Project"}
                </label>
                <select
                  value={selectedProject}
                  onChange={(e) => setSelectedProject(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                >
                  <option value="LandVest 100">LandVest 100</option>
                  <option value="Smart Agro Farming (Season 1)">Smart Agro Farming (Season 1)</option>
                  <option value="Modern Dairy Project">Modern Dairy Project</option>
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "মোট মুনাফা পুল (BDT)" : "Total Net Profit (BDT)"}
                  </label>
                  <input
                    type="number"
                    required
                    value={totalPool}
                    onChange={(e) => setTotalPool(e.target.value)}
                    placeholder="250000"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "যোগ্য মোট শেয়ার" : "Eligible Shares"}
                  </label>
                  <input
                    type="number"
                    required
                    value={sharesCount}
                    onChange={(e) => setSharesCount(e.target.value)}
                    placeholder="74"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
              </div>

              {/* Live Calculation Preview */}
              <div className="p-3 rounded-xl bg-blue-50/70 border border-blue-100 flex items-center justify-between">
                <span className="text-slate-600 font-semibold">
                  {isBangla ? "শেয়ার প্রতি রিটার্ন:" : "Pro-Rata Return / Share:"}
                </span>
                <span className="text-base font-bold text-[#0066FF]">
                  {formatBDT(parseFloat(calcPerShare) || 0, { isBangla })}
                </span>
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
                  {isBangla ? "ডিভিডেন্ড প্রদান করুন" : "Execute & Disburse"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
