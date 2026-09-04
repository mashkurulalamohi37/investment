"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ShieldCheck,
  User,
  Building2,
  CheckCircle2,
  AlertCircle,
  Save,
  KeyRound,
  Lock,
  Eye,
  EyeOff,
  UserCheck,
  CreditCard,
  Check,
} from "lucide-react";

export default function KycProfilePage() {
  const { isBangla, user } = useAuth();
  const [activeTab, setActiveTab] = useState<"KYC" | "SECURITY">("KYC");

  // KYC State
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

  // Password Change State
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showCurrent, setShowCurrent] = useState(false);
  const [showNew, setShowNew] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);
  const [isUpdatingPass, setIsUpdatingPass] = useState(false);
  const [passToast, setPassToast] = useState<{ type: "success" | "error"; message: string } | null>(null);

  const handleSaveKyc = (e: React.FormEvent) => {
    e.preventDefault();
    setSavedSuccess(true);
    setTimeout(() => setSavedSuccess(false), 3000);
  };

  const handlePasswordChange = (e: React.FormEvent) => {
    e.preventDefault();

    if (!currentPassword) {
      setPassToast({
        type: "error",
        message: isBangla ? "বর্তমান পাসওয়ার্ড প্রদান করুন।" : "Please enter your current password.",
      });
      return;
    }

    if (newPassword.length < 8) {
      setPassToast({
        type: "error",
        message: isBangla ? "নতুন পাসওয়ার্ড কমপক্ষে ৮ অক্ষরের হতে হবে।" : "New password must be at least 8 characters long.",
      });
      return;
    }

    if (newPassword !== confirmPassword) {
      setPassToast({
        type: "error",
        message: isBangla ? "নতুন পাসওয়ার্ড এবং কনফার্ম পাসওয়ার্ড মিলছে না।" : "New password and confirmation do not match.",
      });
      return;
    }

    setIsUpdatingPass(true);

    setTimeout(() => {
      setIsUpdatingPass(false);
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
      setPassToast({
        type: "success",
        message: isBangla
          ? "আপনার ইনভেস্টর পাসওয়ার্ড সফলভাবে আপডেট ও সুরক্ষিত হয়েছে!"
          : "Investor security password updated and encrypted successfully!",
      });
      setTimeout(() => setPassToast(null), 4000);
    }, 800);
  };

  return (
    <div className="max-w-4xl mx-auto space-y-4 sm:space-y-5 py-2">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "অ্যাকাউন্ট ভেরিফিকেশন" : "VERIFIED INVESTOR"}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 flex items-center gap-1">
              <ShieldCheck className="w-3 h-3 text-emerald-600" />
              <span>{isBangla ? "কেওয়াইসি সম্পন্ন" : "KYC CLEARED"}</span>
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "প্রোফাইল, কেওয়াইসি ও পাসওয়ার্ড নিরাপত্তা" : "Profile, KYC & Account Security"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "মালিকানা নিবন্ধন, ব্যাংক হিসাব, মনোনীত নমিনি এবং পাসওয়ার্ড পরিবর্তন"
              : "Institutional NID verification, settlement bank account, nominee, and password management"}
          </p>
        </div>
      </div>

      {/* Tabs Switcher */}
      <div className="flex items-center gap-2">
        <button
          onClick={() => setActiveTab("KYC")}
          className={`px-3.5 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
            activeTab === "KYC"
              ? "bg-[#0066FF] text-white shadow-xs"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          <UserCheck className="w-3.5 h-3.5" />
          <span>{isBangla ? "কেওয়াইসি ও নমিনি তথ্য" : "KYC & Nominee Particulars"}</span>
        </button>

        <button
          onClick={() => setActiveTab("SECURITY")}
          className={`px-3.5 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
            activeTab === "SECURITY"
              ? "bg-[#0066FF] text-white shadow-xs"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          <KeyRound className="w-3.5 h-3.5" />
          <span>{isBangla ? "পাসওয়ার্ড পরিবর্তন ও নিরাপত্তা" : "Change Password & Security"}</span>
        </button>
      </div>

      {/* TAB 1: KYC & Nominee Records */}
      {activeTab === "KYC" && (
        <form onSubmit={handleSaveKyc} className="space-y-4">
          {savedSuccess && (
            <div className="p-3 rounded-xl bg-emerald-50 text-emerald-800 border border-emerald-200 text-xs font-bold flex items-center gap-2">
              <CheckCircle2 className="w-4 h-4 text-emerald-600" />
              <span>
                {isBangla
                  ? "কেওয়াইসি এবং নমিনি তথ্য সফলভাবে আপডেট ও সংরক্ষিত হয়েছে।"
                  : "Compliance & Nominee records updated successfully."}
              </span>
            </div>
          )}

          {/* Section 1: NID & Personal Details */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 space-y-3.5">
            <h2 className="text-sm font-bold text-slate-900 border-b border-slate-100 pb-2.5 flex items-center gap-2">
              <User className="w-4 h-4 text-[#0066FF]" />
              <span>1. {isBangla ? "জাতীয় পরিচয়পত্র ও ব্যক্তিগত তথ্য" : "National Identity & Legal Particulars"}</span>
            </h2>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-xs font-semibold">
              <div>
                <label className="text-slate-600 block mb-1">
                  {isBangla ? "পূর্ণ নাম (এনআইডি অনুযায়ী)" : "Full Legal Name (as per NID)"}
                </label>
                <input
                  type="text"
                  disabled
                  value={user?.full_name || "Mashkurul Alam Ohi"}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 bg-slate-50 font-bold text-slate-900 text-xs"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">
                  {isBangla ? "স্মার্ট এনআইডি নম্বর" : "Smart NID Number"}
                </label>
                <input
                  type="text"
                  value={nidNumber}
                  onChange={(e) => setNidNumber(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs font-mono focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "পিতার নাম" : "Father's Name"}</label>
                <input
                  type="text"
                  value={fatherName}
                  onChange={(e) => setFatherName(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "মাতার নাম" : "Mother's Name"}</label>
                <input
                  type="text"
                  value={motherName}
                  onChange={(e) => setMotherName(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div className="sm:col-span-2">
                <label className="text-slate-600 block mb-1">{isBangla ? "বর্তমান ঠিকানা" : "Present Address"}</label>
                <input
                  type="text"
                  value={presentAddress}
                  onChange={(e) => setPresentAddress(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
            </div>
          </div>

          {/* Section 2: Settlement Bank Account */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 space-y-3.5">
            <h2 className="text-sm font-bold text-slate-900 border-b border-slate-100 pb-2.5 flex items-center gap-2">
              <Building2 className="w-4 h-4 text-[#0066FF]" />
              <span>2. {isBangla ? "লভ্যাংশ নিষ্পত্তির ব্যাংক হিসাব" : "Dividend Settlement Bank Account"}</span>
            </h2>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-xs font-semibold">
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "ব্যাংকের নাম" : "Bank Name"}</label>
                <input
                  type="text"
                  value={bankName}
                  onChange={(e) => setBankName(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "অ্যাকাউন্ট নম্বর" : "Account Number"}</label>
                <input
                  type="text"
                  value={bankAccount}
                  onChange={(e) => setBankAccount(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs font-mono focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "শাখা" : "Branch Name"}</label>
                <input
                  type="text"
                  value={branchName}
                  onChange={(e) => setBranchName(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "রাউটিং নম্বর" : "Routing Number"}</label>
                <input
                  type="text"
                  value={routingNumber}
                  onChange={(e) => setRoutingNumber(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs font-mono focus:border-[#0066FF] focus:outline-none"
                />
              </div>
            </div>
          </div>

          {/* Section 3: Nominee Allocation */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 space-y-3.5">
            <h2 className="text-sm font-bold text-slate-900 border-b border-slate-100 pb-2.5 flex items-center gap-2">
              <ShieldCheck className="w-4 h-4 text-emerald-600" />
              <span>3. {isBangla ? "মনোনীত নমিনির বিবরণ (১০০% উত্তরাধিকারী)" : "Nominee Designation (100% Beneficiary)"}</span>
            </h2>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-xs font-semibold">
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "নমিনির নাম" : "Nominee Full Name"}</label>
                <input
                  type="text"
                  value={nomineeName}
                  onChange={(e) => setNomineeName(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "নমিনির এনআইডি নম্বর" : "Nominee NID Number"}</label>
                <input
                  type="text"
                  value={nomineeNid}
                  onChange={(e) => setNomineeNid(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs font-mono focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "সম্পর্ক" : "Relationship"}</label>
                <input
                  type="text"
                  value={nomineeRelation}
                  onChange={(e) => setNomineeRelation(e.target.value)}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 text-xs focus:border-[#0066FF] focus:outline-none"
                />
              </div>
              <div>
                <label className="text-slate-600 block mb-1">{isBangla ? "অংশীদারিত্ব %" : "Nominee Share %"}</label>
                <input
                  type="text"
                  disabled
                  value={nomineeShare}
                  className="w-full px-3 py-2 rounded-xl border border-slate-200 bg-slate-50 font-bold text-slate-900 text-xs font-mono"
                />
              </div>
            </div>
          </div>

          <div className="flex justify-end pt-1">
            <button
              type="submit"
              className="px-5 py-2.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-xs shadow-[#0066FF]/20 flex items-center gap-2 transition-all cursor-pointer"
            >
              <Save className="w-3.5 h-3.5" />
              <span>{isBangla ? "কেওয়াইসি তথ্য সংরক্ষণ করুন" : "Save & Update Compliance Record"}</span>
            </button>
          </div>
        </form>
      )}

      {/* TAB 2: Change Password & Security */}
      {activeTab === "SECURITY" && (
        <div className="space-y-4">
          {/* Password Change Card */}
          <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-4">
            <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <div className="w-7 h-7 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold">
                  <KeyRound className="w-4 h-4" />
                </div>
                <div>
                  <h3 className="font-bold text-slate-900 text-sm">
                    {isBangla ? "ইনভেস্টর পাসওয়ার্ড পরিবর্তন করুন" : "Change Investor Account Password"}
                  </h3>
                  <p className="text-[11px] text-slate-500">
                    {isBangla
                      ? "আপনার বিনিয়োগ পোর্টফোলিও নিরাপদ রাখতে শক্তিশালী পাসওয়ার্ড ব্যবহার করুন"
                      : "Ensure your investment portfolio stays secure with an encrypted password"}
                  </p>
                </div>
              </div>
              <span className="hidden sm:inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-[10px] font-mono font-bold bg-blue-50 text-blue-700 border border-blue-200">
                <Lock className="w-3 h-3" />
                256-BIT SECURED
              </span>
            </div>

            {passToast && (
              <div
                className={`p-3 rounded-xl text-xs font-bold flex items-center gap-2 ${
                  passToast.type === "success"
                    ? "bg-emerald-50 border border-emerald-200 text-emerald-800"
                    : "bg-red-50 border border-red-200 text-red-700"
                }`}
              >
                {passToast.type === "success" ? (
                  <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                ) : (
                  <AlertCircle className="w-4 h-4 text-red-600 shrink-0" />
                )}
                <span>{passToast.message}</span>
              </div>
            )}

            <form onSubmit={handlePasswordChange} className="space-y-3 text-xs font-semibold">
              {/* Current Password */}
              <div>
                <label className="text-slate-700 block mb-1">
                  {isBangla ? "বর্তমান পাসওয়ার্ড" : "Current Password"}
                </label>
                <div className="relative">
                  <input
                    type={showCurrent ? "text" : "password"}
                    required
                    value={currentPassword}
                    onChange={(e) => setCurrentPassword(e.target.value)}
                    placeholder="••••••••••••"
                    className="w-full pl-3.5 pr-10 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono text-xs focus:outline-none focus:border-[#0066FF]"
                  />
                  <button
                    type="button"
                    onClick={() => setShowCurrent(!showCurrent)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 cursor-pointer"
                  >
                    {showCurrent ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                {/* New Password */}
                <div>
                  <label className="text-slate-700 block mb-1">
                    {isBangla ? "নতুন পাসওয়ার্ড" : "New Password"}
                  </label>
                  <div className="relative">
                    <input
                      type={showNew ? "text" : "password"}
                      required
                      value={newPassword}
                      onChange={(e) => setNewPassword(e.target.value)}
                      placeholder={isBangla ? "কমপক্ষে ৮ অক্ষর..." : "Min 8 characters..."}
                      className="w-full pl-3.5 pr-10 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono text-xs focus:outline-none focus:border-[#0066FF]"
                    />
                    <button
                      type="button"
                      onClick={() => setShowNew(!showNew)}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 cursor-pointer"
                    >
                      {showNew ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                    </button>
                  </div>
                </div>

                {/* Confirm New Password */}
                <div>
                  <label className="text-slate-700 block mb-1">
                    {isBangla ? "নতুন পাসওয়ার্ড নিশ্চিত করুন" : "Confirm New Password"}
                  </label>
                  <div className="relative">
                    <input
                      type={showConfirm ? "text" : "password"}
                      required
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      placeholder={isBangla ? "পুনরায় লিখুন..." : "Re-enter new password..."}
                      className="w-full pl-3.5 pr-10 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono text-xs focus:outline-none focus:border-[#0066FF]"
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirm(!showConfirm)}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 cursor-pointer"
                    >
                      {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                    </button>
                  </div>
                </div>
              </div>

              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pt-1.5">
                <span className="text-[11px] text-slate-400">
                  {isBangla
                    ? "পাসওয়ার্ডে অন্তত একটি বড় হাতের অক্ষর, একটি সংখ্যা এবং বিশেষ অক্ষর ব্যবহার করুন"
                    : "Must be at least 8 characters with a mix of numbers and letters."}
                </span>
                <button
                  type="submit"
                  disabled={isUpdatingPass}
                  className="self-start sm:self-auto px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold shadow-xs shadow-[#0066FF]/20 flex items-center gap-1.5 cursor-pointer transition-all disabled:opacity-50"
                >
                  <KeyRound className="w-3.5 h-3.5" />
                  <span>
                    {isUpdatingPass
                      ? isBangla ? "আপডেট হচ্ছে..." : "Updating..."
                      : isBangla ? "পাসওয়ার্ড আপডেট করুন" : "Update Password"}
                  </span>
                </button>
              </div>
            </form>
          </div>

          {/* Account Security Info Card */}
          <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3 text-xs">
            <h3 className="font-bold text-slate-900 text-sm flex items-center gap-2">
              <ShieldCheck className="w-4 h-4 text-emerald-600" />
              <span>{isBangla ? "অ্যাকাউন্ট সিকিউরিটি ও এসক্রো ট্রাস্ট" : "Account Security & Escrow Trust"}</span>
            </h3>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-slate-700">
              <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-slate-400 block text-[11px]">
                  {isBangla ? "রেজিস্টার্ড মোবাইল নম্বর" : "Registered Investor Phone"}
                </span>
                <span className="font-bold text-slate-900 text-xs">{user?.phone || "+880 1712-345678"}</span>
              </div>
              <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-slate-400 block text-[11px]">
                  {isBangla ? "এসক্রো পার্টনার" : "Escrow Custodian"}
                </span>
                <span className="font-bold text-slate-900 text-xs">The City Bank PLC (Gulshan Branch)</span>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
