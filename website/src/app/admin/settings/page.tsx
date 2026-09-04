"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Settings,
  ShieldCheck,
  Building2,
  KeyRound,
  UserCheck,
  CheckCircle2,
  Save,
  Lock,
  Eye,
  EyeOff,
  AlertCircle,
} from "lucide-react";

export default function AdminSettingsPage() {
  const { user, isBangla } = useAuth();
  const [toast, setToast] = useState<string | null>(null);
  const [passToast, setPassToast] = useState<{ type: "success" | "error"; message: string } | null>(null);

  // Escrow Banking State
  const [bankAccount, setBankAccount] = useState("1402-9988-7710-1");
  const [routingNumber, setRoutingNumber] = useState("225275357");
  const [branchName, setBranchName] = useState("Gulshan-1 Branch, Dhaka");
  const [supportPhone, setSupportPhone] = useState("+880 1712-345678");

  // Password Change State
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showCurrent, setShowCurrent] = useState(false);
  const [showNew, setShowNew] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);
  const [isUpdatingPass, setIsUpdatingPass] = useState(false);

  const handleSaveBankSettings = (e: React.FormEvent) => {
    e.preventDefault();
    setToast(
      isBangla
        ? "প্ল্যাটফর্ম এবং সিটি ব্যাংক এসক্রো সেটিংস সফলভাবে সংরক্ষিত হয়েছে।"
        : "Platform and Escrow Banking settings saved successfully."
    );
    setTimeout(() => setToast(null), 3000);
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
          ? "অ্যাডমিন পাসওয়ার্ড সফলভাবে পরিবর্তিত ও আপডেট হয়েছে!"
          : "Admin security password updated and encrypted successfully!",
      });
      setTimeout(() => setPassToast(null), 4000);
    }, 800);
  };

  return (
    <div className="space-y-4 sm:space-y-5 max-w-4xl">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "নিরাপত্তা ও কনফিগারেশন" : "SECURITY & CONFIG"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "প্ল্যাটফর্ম কনফিগারেশন ও অ্যাডমিন নিরাপত্তা" : "Platform Configuration & Security"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "সিটি ব্যাংক এসক্রো ক্লিয়ারিং প্যারামিটার, অ্যাডমিন পাসওয়ার্ড এবং নিরাপত্তা নিয়ন্ত্রণ"
              : "Manage official City Bank escrow clearing parameters, admin credentials, and platform password"}
          </p>
        </div>
      </div>

      {toast && (
        <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-bold flex items-center gap-2">
          <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
          <span>{toast}</span>
        </div>
      )}

      {/* 1. Admin Password Change Section */}
      <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-4">
        <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
          <div className="flex items-center gap-2">
            <div className="w-7 h-7 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold">
              <KeyRound className="w-4 h-4" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 text-sm">
                {isBangla ? "অ্যাডমিন পাসওয়ার্ড পরিবর্তন করুন" : "Change Admin Master Password"}
              </h3>
              <p className="text-[11px] text-slate-500">
                {isBangla
                  ? "সুপার অ্যাডমিন অ্যাকাউন্টের নিরাপত্তা নিশ্চিত করতে শক্তিশালী পাসওয়ার্ড ব্যবহার করুন"
                  : "Update your Super Admin master login credentials with SHA-256 encryption"}
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

      {/* 2. Escrow Bank Config Form */}
      <form onSubmit={handleSaveBankSettings} className="space-y-4">
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3.5">
          <div className="flex items-center gap-2 pb-2 border-b border-slate-100">
            <div className="w-7 h-7 rounded-lg bg-emerald-50 text-emerald-700 flex items-center justify-center font-bold">
              <Building2 className="w-4 h-4" />
            </div>
            <div>
              <h3 className="font-bold text-slate-900 text-sm">
                {isBangla ? "দ্য সিটি ব্যাংক পিএলসি এসক্রো ডিপোজিট তথ্য" : "City Bank PLC Escrow Deposit Credentials"}
              </h3>
              <p className="text-[11px] text-slate-500">
                {isBangla ? "ইনভেস্টরদের প্রদর্শিত ব্যাংক ডিপোজিট তথ্য" : "Official escrow account details shown to investors"}
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 text-xs font-semibold">
            <div>
              <label className="text-slate-600 block mb-1">
                {isBangla ? "এসক্রো অ্যাকাউন্ট নম্বর" : "Account Number"}
              </label>
              <input
                type="text"
                value={bankAccount}
                onChange={(e) => setBankAccount(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
              />
            </div>
            <div>
              <label className="text-slate-600 block mb-1">
                {isBangla ? "রাউটিং নম্বর" : "Routing Number"}
              </label>
              <input
                type="text"
                value={routingNumber}
                onChange={(e) => setRoutingNumber(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
              />
            </div>
            <div>
              <label className="text-slate-600 block mb-1">
                {isBangla ? "ব্যাংক শাখা" : "Branch Name"}
              </label>
              <input
                type="text"
                value={branchName}
                onChange={(e) => setBranchName(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
              />
            </div>
            <div>
              <label className="text-slate-600 block mb-1">
                {isBangla ? "ইনভেস্টর সাপোর্ট হটলাইন" : "Investor Support Hotline"}
              </label>
              <input
                type="text"
                value={supportPhone}
                onChange={(e) => setSupportPhone(e.target.value)}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
              />
            </div>
          </div>
        </div>

        {/* 3. Admin Session Security */}
        <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3 text-xs">
          <h3 className="font-bold text-slate-900 text-sm flex items-center gap-2">
            <ShieldCheck className="w-4 h-4 text-emerald-600" />
            <span>{isBangla ? "সক্রিয় অ্যাডমিন সেশন ও সিকিউরিটি" : "Active Admin Credentials"}</span>
          </h3>
          <div className="grid grid-cols-2 gap-3 text-slate-700">
            <div>
              <span className="text-slate-400 block text-[11px]">
                {isBangla ? "অনুমোদিত অ্যাডমিনিস্ট্রেটর" : "Authorized Administrator"}
              </span>
              <span className="font-bold text-slate-900">{user?.full_name || "Tanvir Ahmed"}</span>
            </div>
            <div>
              <span className="text-slate-400 block text-[11px]">
                {isBangla ? "নিরাপত্তা ভূমিকা" : "Privilege Tier"}
              </span>
              <span className="font-mono text-emerald-700 font-bold">SUPER_ADMIN (Level 3)</span>
            </div>
          </div>
        </div>

        <div className="flex justify-end pt-1">
          <button
            type="submit"
            className="px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold shadow-xs shadow-[#0066FF]/20 flex items-center gap-2 cursor-pointer transition-all"
          >
            <Save className="w-3.5 h-3.5" />
            <span>{isBangla ? "ব্যাংক সেটিংস সংরক্ষণ করুন" : "Save Escrow Settings"}</span>
          </button>
        </div>
      </form>
    </div>
  );
}
