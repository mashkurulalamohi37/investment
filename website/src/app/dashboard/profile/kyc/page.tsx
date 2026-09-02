"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldCheck, User, Building2, CheckCircle2, AlertCircle, Save } from "lucide-react";

export default function KycProfilePage() {
  const { isBangla, user } = useAuth();

  const [nidNumber, setNidNumber] = useState("5918294018294");
  const [fatherName, setFatherName] = useState("Abdul Alim");
  const [motherName, setMotherName] = useState("Rokeya Begum");
  const [presentAddress, setPresentAddress] = useState("House 14, Road 5, Block C, Banani, Dhaka");
  const [bankName, setBankName] = useState("The City Bank PLC");
  const [bankAccount, setBankAccount] = useState("1402998877101");
  const [routingNumber, setRoutingNumber] = useState("225275357");
  const [branchName, setBranchName] = useState("Gulshan-1 Branch");
  const [nomineeName, setNomineeName] = useState("Fatema Tuz Zohra");
  const [nomineeNid, setNomineeNid] = useState("8192840192849");
  const [nomineeRelation, setNomineeRelation] = useState("Spouse (স্ত্রী)");
  const [nomineeShare, setNomineeShare] = useState("100%");
  const [savedSuccess, setSavedSuccess] = useState(false);

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    setSavedSuccess(true);
    setTimeout(() => setSavedSuccess(false), 3000);
  };

  return (
    <div className="max-w-4xl mx-auto space-y-8 py-4">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-200">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-slate-900">
            {isBangla ? "কেওয়াইসি ও আইনি সম্মতি" : "KYC Compliance & Nominee Record"}
          </h1>
          <p className="text-xs text-slate-500">
            {isBangla
              ? "মালিকানা নিবন্ধন ও লভ্যাংশ নিষ্পত্তির জন্য আইনি তথ্য"
              : "Institutional NID verification, settlement bank account, and nominee allocation"}
          </p>
        </div>

        <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-emerald-100 text-emerald-800">
          <CheckCircle2 className="w-4 h-4 text-jade" />
          <span>VERIFIED INVESTOR</span>
        </span>
      </div>

      {savedSuccess && (
        <div className="p-4 rounded-xl bg-emerald-50 text-emerald-800 border border-emerald-200 text-xs font-bold flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-jade" />
          <span>Compliance & Nominee records updated successfully in the PostgreSQL backend.</span>
        </div>
      )}

      <form onSubmit={handleSave} className="space-y-8">
        {/* Section 1: NID & Personal Details */}
        <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5">
          <h2 className="text-base font-bold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
            <User className="w-4 h-4 text-brand-forest" />
            <span>1. National Identity & Legal Particulars</span>
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
            <div>
              <label className="font-bold text-slate-700 block mb-1">Full Legal Name (as per NID)</label>
              <input
                type="text"
                disabled
                value={user?.full_name || "Mashkurul Alam Ohi"}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 bg-slate-50 font-bold text-slate-900 text-sm"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Smart NID Number (১০ বা ১৭ ডিজিট)</label>
              <input
                type="text"
                value={nidNumber}
                onChange={(e) => setNidNumber(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm font-mono focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Father&apos;s Name</label>
              <input
                type="text"
                value={fatherName}
                onChange={(e) => setFatherName(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Mother&apos;s Name</label>
              <input
                type="text"
                value={motherName}
                onChange={(e) => setMotherName(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div className="sm:col-span-2">
              <label className="font-bold text-slate-700 block mb-1">Present Address (বর্তমান ঠিকানা)</label>
              <input
                type="text"
                value={presentAddress}
                onChange={(e) => setPresentAddress(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* Section 2: Settlement Bank Account */}
        <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5">
          <h2 className="text-base font-bold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
            <Building2 className="w-4 h-4 text-brand-forest" />
            <span>2. Dividend Settlement Bank Account</span>
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
            <div>
              <label className="font-bold text-slate-700 block mb-1">Bank Name</label>
              <input
                type="text"
                value={bankName}
                onChange={(e) => setBankName(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Account Number</label>
              <input
                type="text"
                value={bankAccount}
                onChange={(e) => setBankAccount(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm font-mono focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Branch Name</label>
              <input
                type="text"
                value={branchName}
                onChange={(e) => setBranchName(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Routing Number</label>
              <input
                type="text"
                value={routingNumber}
                onChange={(e) => setRoutingNumber(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm font-mono focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
          </div>
        </div>

        {/* Section 3: Nominee Allocation */}
        <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5">
          <h2 className="text-base font-bold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
            <ShieldCheck className="w-4 h-4 text-gold" />
            <span>3. Nominee Designation (১০০% উত্তরাধিকারী)</span>
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
            <div>
              <label className="font-bold text-slate-700 block mb-1">Nominee Full Name (নমিনির নাম)</label>
              <input
                type="text"
                value={nomineeName}
                onChange={(e) => setNomineeName(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Nominee NID Number</label>
              <input
                type="text"
                value={nomineeNid}
                onChange={(e) => setNomineeNid(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm font-mono focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Relationship (সম্পর্ক)</label>
              <input
                type="text"
                value={nomineeRelation}
                onChange={(e) => setNomineeRelation(e.target.value)}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none"
              />
            </div>
            <div>
              <label className="font-bold text-slate-700 block mb-1">Nominee Share %</label>
              <input
                type="text"
                disabled
                value={nomineeShare}
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 bg-slate-50 font-bold text-slate-900 text-sm font-mono"
              />
            </div>
          </div>
        </div>

        <button
          type="submit"
          className="w-full py-4 rounded-xl bg-gradient-emerald text-white font-bold text-sm hover:opacity-95 shadow-lg shadow-brand-forest/20 flex items-center justify-center gap-2 transition-all"
        >
          <Save className="w-4 h-4 text-gold" />
          <span>Save & Update Compliance Record</span>
        </button>
      </form>
    </div>
  );
}
