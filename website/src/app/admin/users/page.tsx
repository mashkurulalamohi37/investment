"use client";

import React, { useState } from "react";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Users,
  CheckCircle2,
  XCircle,
  ShieldCheck,
  Search,
  FileCheck,
  UserCheck,
  Phone,
  Mail,
  Award,
  CreditCard,
  Check,
  Filter,
} from "lucide-react";

export default function AdminUsersPage() {
  const { isBangla } = useAuth();
  const [searchQuery, setSearchQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState<"ALL" | "PENDING" | "VERIFIED">("ALL");

  const [investors, setInvestors] = useState([
    {
      id: "usr-001",
      name: "Mashkurul Alam Ohi",
      name_bn: "মাশকুরুল আলম ওহি",
      initials: "MO",
      phone: "+880 1712-345678",
      email: "ohi.invest@gmail.com",
      sharesOwned: 4,
      totalInvested: 102000,
      kycStatus: "VERIFIED",
      nidNumber: "7319-8201-9482",
      nomineeName: "Farhana Alam",
      nomineeName_bn: "ফারহানা আলম",
      nomineeRelation: "Sister",
      nomineeRelation_bn: "বোন",
      joinedDate: "2026-08-01",
    },
    {
      id: "usr-002",
      name: "Dr. Tanvir Hasan",
      name_bn: "ডাঃ তানভীর হাসান",
      initials: "TH",
      phone: "+880 1819-223344",
      email: "tanvir.hasan@medicare.bd",
      sharesOwned: 2,
      totalInvested: 51000,
      kycStatus: "PENDING",
      nidNumber: "5192-0192-8401",
      nomineeName: "Sadia Hasan",
      nomineeName_bn: "সাদিয়া হাসান",
      nomineeRelation: "Spouse",
      nomineeRelation_bn: "স্ত্রী",
      joinedDate: "2026-08-15",
    },
    {
      id: "usr-003",
      name: "Nusrat Jahan",
      name_bn: "নুসরাত জাহান",
      initials: "NJ",
      phone: "+880 1711-998877",
      email: "nusrat.jahan@fintech.bd",
      sharesOwned: 1,
      totalInvested: 25500,
      kycStatus: "PENDING",
      nidNumber: "9182-7391-0294",
      nomineeName: "Kazi Rafiqul",
      nomineeName_bn: "কাজী রফিকুল",
      nomineeRelation: "Father",
      nomineeRelation_bn: "পিতা",
      joinedDate: "2026-08-20",
    },
    {
      id: "usr-004",
      name: "Engr. Kamal Uddin",
      name_bn: "প্রকৌ. কামাল উদ্দিন",
      initials: "KU",
      phone: "+880 1912-778899",
      email: "kamal.engr@dhaka.net",
      sharesOwned: 3,
      totalInvested: 76500,
      kycStatus: "VERIFIED",
      nidNumber: "6291-0394-8172",
      nomineeName: "Tanzila Kamal",
      nomineeName_bn: "তানজিলা কামাল",
      nomineeRelation: "Daughter",
      nomineeRelation_bn: "কন্যা",
      joinedDate: "2026-08-22",
    },
  ]);

  const [toast, setToast] = useState<string | null>(null);

  const handleApproveKyc = (id: string, name: string) => {
    setInvestors((prev) =>
      prev.map((u) => (u.id === id ? { ...u, kycStatus: "VERIFIED" } : u))
    );
    setToast(
      isBangla
        ? `${name}-এর স্মার্ট এনআইডি কেওয়াইসি সফলভাবে যাচাই ও অনুমোদিত হয়েছে`
        : `Smart NID KYC verified and approved for ${name}`
    );
    setTimeout(() => setToast(null), 3000);
  };

  const handleRejectKyc = (id: string, name: string) => {
    setInvestors((prev) =>
      prev.map((u) => (u.id === id ? { ...u, kycStatus: "REJECTED" } : u))
    );
    setToast(
      isBangla
        ? `${name}-এর কেওয়াইসি আবেদন প্রত্যাখ্যান করা হয়েছে`
        : `KYC submission rejected for ${name}`
    );
    setTimeout(() => setToast(null), 3000);
  };

  const pendingCount = investors.filter((i) => i.kycStatus === "PENDING").length;
  const verifiedCount = investors.filter((i) => i.kycStatus === "VERIFIED").length;
  const totalInvestedSum = investors.reduce((acc, i) => acc + i.totalInvested, 0);

  const filtered = investors.filter((inv) => {
    const matchesSearch =
      inv.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      (inv.name_bn && inv.name_bn.includes(searchQuery)) ||
      inv.phone.includes(searchQuery) ||
      inv.nidNumber.includes(searchQuery);

    if (!matchesSearch) return false;
    if (statusFilter === "PENDING") return inv.kycStatus === "PENDING";
    if (statusFilter === "VERIFIED") return inv.kycStatus === "VERIFIED";
    return true;
  });

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? `মোট ${investors.length} জন রেজিস্টার্ড ইনভেস্টর` : `${investors.length} REGISTERED INVESTORS`}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-amber-50 text-amber-800 border border-amber-200">
              {pendingCount} {isBangla ? "টি অপেক্ষমান" : "PENDING"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "ইনভেস্টর রেজিস্ট্রি ও স্মার্ট কেওয়াইসি পোর্টাল" : "Investors & Smart KYC Registry"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "যাচাইকৃত অংশীদারদের তালিকা, এনআইডি ভেরিফিকেশন এবং মনোনীত নমিনি তথ্যাদি"
              : "Monitor verified investor profiles, Smart NID clearance, equity holdings, and nominee records"}
          </p>
        </div>

        {/* Search Bar */}
        <div className="relative w-full sm:w-64">
          <Search className="w-3.5 h-3.5 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
          <input
            type="text"
            placeholder={isBangla ? "নাম, ফোন বা এনআইডি..." : "Search name, phone, NID..."}
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-9 pr-3 py-2 rounded-xl bg-white border border-slate-200 text-xs text-slate-900 focus:outline-none focus:border-[#0066FF] shadow-2xs"
          />
        </div>
      </div>

      {toast && (
        <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-bold flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          <span>{toast}</span>
        </div>
      )}

      {/* Mini KPI Ribbon */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        <div className="p-3.5 rounded-xl bg-white border border-slate-200 shadow-2xs flex items-center justify-between">
          <div>
            <span className="text-[11px] text-slate-500 font-semibold block uppercase tracking-wider">
              {isBangla ? "মোট ইনভেস্টর সংখ্যা" : "Total Investors"}
            </span>
            <span className="text-lg font-black text-slate-900">
              {investors.length} {isBangla ? "জন" : "Members"}
            </span>
          </div>
          <div className="w-8 h-8 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold">
            <Users className="w-4 h-4" />
          </div>
        </div>

        <div className="p-3.5 rounded-xl bg-white border border-slate-200 shadow-2xs flex items-center justify-between">
          <div>
            <span className="text-[11px] text-slate-500 font-semibold block uppercase tracking-wider">
              {isBangla ? "মোট বিনিয়োগ পোর্টফোলিও" : "Active Portfolio Fund"}
            </span>
            <span className="text-lg font-black text-[#0066FF]">
              {formatBDT(totalInvestedSum, { isBangla })}
            </span>
          </div>
          <div className="w-8 h-8 rounded-lg bg-emerald-50 text-emerald-700 flex items-center justify-center font-bold">
            <ShieldCheck className="w-4 h-4" />
          </div>
        </div>

        <div className="p-3.5 rounded-xl bg-white border border-slate-200 shadow-2xs flex items-center justify-between">
          <div>
            <span className="text-[11px] text-slate-500 font-semibold block uppercase tracking-wider">
              {isBangla ? "কেওয়াইসি ভেরিফিকেশন" : "KYC Clearance"}
            </span>
            <span className="text-lg font-black text-amber-700">
              {pendingCount} {isBangla ? "টি অপেক্ষমান" : "Action Required"}
            </span>
          </div>
          <div className="w-8 h-8 rounded-lg bg-amber-50 text-amber-700 flex items-center justify-center font-bold">
            <UserCheck className="w-4 h-4" />
          </div>
        </div>
      </div>

      {/* Filter Tabs Bar */}
      <div className="flex items-center gap-2 pt-1">
        <button
          onClick={() => setStatusFilter("ALL")}
          className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all cursor-pointer ${
            statusFilter === "ALL"
              ? "bg-[#0066FF] text-white shadow-2xs"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? `সকল ইনভেস্টর (${investors.length})` : `All Investors (${investors.length})`}
        </button>
        <button
          onClick={() => setStatusFilter("PENDING")}
          className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all cursor-pointer ${
            statusFilter === "PENDING"
              ? "bg-amber-600 text-white shadow-2xs"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? `অপেক্ষমান কেওয়াইসি (${pendingCount})` : `Pending KYC (${pendingCount})`}
        </button>
        <button
          onClick={() => setStatusFilter("VERIFIED")}
          className={`px-3 py-1.5 rounded-lg text-xs font-bold transition-all cursor-pointer ${
            statusFilter === "VERIFIED"
              ? "bg-emerald-600 text-white shadow-2xs"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? `যাচাইকৃত (${verifiedCount})` : `Verified (${verifiedCount})`}
        </button>
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs">
            <thead className="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[11px]">
              <tr>
                <th className="py-3 px-3.5">{isBangla ? "ইনভেস্টরের নাম ও যোগাযোগ" : "Investor & Contact"}</th>
                <th className="py-3 px-3.5">{isBangla ? "স্মার্ট এনআইডি" : "Smart NID"}</th>
                <th className="py-3 px-3.5">{isBangla ? "শেয়ার ও মোট বিনিয়োগ" : "Shares & Holding"}</th>
                <th className="py-3 px-3.5">{isBangla ? "মনোনীত নমিনি" : "Nominee Details"}</th>
                <th className="py-3 px-3.5">{isBangla ? "কেওয়াইসি স্ট্যাটাস" : "KYC Status"}</th>
                <th className="py-3 px-3.5 text-right">{isBangla ? "অ্যাকশন" : "Actions"}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 font-medium text-slate-700">
              {filtered.map((inv) => (
                <tr key={inv.id} className="hover:bg-slate-50/70 transition-colors">
                  {/* Investor Details with Initial Avatar */}
                  <td className="py-3 px-3.5">
                    <div className="flex items-center gap-2.5">
                      <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-[#0066FF] to-[#00B4D8] text-white font-bold text-xs flex items-center justify-center shrink-0 shadow-2xs">
                        {inv.initials}
                      </div>
                      <div className="min-w-0">
                        <span className="font-bold text-slate-900 block text-xs truncate">
                          {isBangla ? inv.name_bn || inv.name : inv.name}
                        </span>
                        <div className="flex items-center gap-2 text-slate-500 text-[11px]">
                          <span>{inv.phone}</span>
                          <span className="text-slate-300">•</span>
                          <span className="text-slate-400 truncate max-w-[130px]">{inv.email}</span>
                        </div>
                      </div>
                    </div>
                  </td>

                  {/* Smart NID with Card Pill */}
                  <td className="py-3 px-3.5">
                    <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-slate-100/90 border border-slate-200/80 font-mono font-bold text-slate-800 text-[11px]">
                      <CreditCard className="w-3 h-3 text-slate-500 shrink-0" />
                      <span>{inv.nidNumber}</span>
                    </div>
                  </td>

                  {/* Shares & Total Amount */}
                  <td className="py-3 px-3.5">
                    <span className="font-bold text-[#0066FF] text-xs sm:text-sm block">
                      {formatBDT(inv.totalInvested, { isBangla })}
                    </span>
                    <span className="inline-block mt-0.5 px-2 py-0.2 rounded-md bg-blue-50 text-[#0066FF] border border-blue-200/60 font-semibold text-[10px]">
                      {inv.sharesOwned} {isBangla ? "টি শেয়ার" : inv.sharesOwned > 1 ? "Shares" : "Share"}
                    </span>
                  </td>

                  {/* Nominee with Relationship Badge */}
                  <td className="py-3 px-3.5">
                    <span className="font-bold text-slate-800 block text-xs">
                      {isBangla ? inv.nomineeName_bn || inv.nomineeName : inv.nomineeName}
                    </span>
                    <span className="inline-block text-[10px] px-1.5 py-0.2 rounded bg-slate-100 text-slate-600 font-medium mt-0.5">
                      {isBangla ? inv.nomineeRelation_bn || inv.nomineeRelation : inv.nomineeRelation}
                    </span>
                  </td>

                  {/* KYC Status Badge */}
                  <td className="py-3 px-3.5">
                    <span
                      className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[10px] font-bold ${
                        inv.kycStatus === "VERIFIED"
                          ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                          : inv.kycStatus === "PENDING"
                          ? "bg-amber-50 text-amber-800 border border-amber-200"
                          : "bg-red-50 text-red-800 border border-red-200"
                      }`}
                    >
                      {inv.kycStatus === "VERIFIED" ? (
                        <>
                          <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                          <span>{isBangla ? "যাচাইকৃত" : "VERIFIED"}</span>
                        </>
                      ) : inv.kycStatus === "PENDING" ? (
                        <>
                          <span className="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span>
                          <span>{isBangla ? "অপেক্ষমান" : "PENDING"}</span>
                        </>
                      ) : (
                        <span>{isBangla ? "বাতিল" : "REJECTED"}</span>
                      )}
                    </span>
                  </td>

                  {/* Action Buttons */}
                  <td className="py-3 px-3.5 text-right">
                    {inv.kycStatus === "PENDING" ? (
                      <div className="inline-flex gap-1.5">
                        <button
                          onClick={() => handleApproveKyc(inv.id, inv.name)}
                          className="px-3 py-1.5 rounded-lg bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs transition-colors shadow-2xs cursor-pointer"
                        >
                          {isBangla ? "অনুমোদন" : "Approve"}
                        </button>
                        <button
                          onClick={() => handleRejectKyc(inv.id, inv.name)}
                          className="px-2.5 py-1.5 rounded-lg bg-red-50 hover:bg-red-100 text-red-700 font-bold text-xs border border-red-200 transition-colors cursor-pointer"
                        >
                          {isBangla ? "বাতিল" : "Reject"}
                        </button>
                      </div>
                    ) : (
                      <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-slate-50 border border-slate-200 text-slate-500 text-[11px] font-semibold">
                        <Check className="w-3 h-3 text-emerald-600" />
                        <span>{isBangla ? "সম্পন্ন" : "Cleared"}</span>
                      </span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
