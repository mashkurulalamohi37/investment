"use client";

import React, { useState, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import { Lock, Phone, ShieldCheck, Eye, EyeOff, Sparkles, ArrowRight, UserCheck } from "lucide-react";

function LoginForm() {
  const { login, isBangla } = useAuth();
  const router = useRouter();
  const searchParams = useSearchParams();
  const redirect = searchParams.get("redirect") || "/dashboard";

  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [authMode, setAuthMode] = useState<"PASSWORD" | "OTP">("PASSWORD");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    const success = await login(phone, password);
    setLoading(false);
    if (success) {
      router.push(phone.includes("admin") || phone.includes("999") ? "/admin" : redirect);
    }
  };

  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4 py-8">
      <div className="w-full max-w-md bg-white rounded-3xl border border-slate-200/90 shadow-card p-6 sm:p-8 space-y-6">
        {/* Header */}
        <div className="text-center space-y-2">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-blue-50 border border-blue-200 text-[#0066FF] text-xs font-bold font-mono">
            <ShieldCheck className="w-3.5 h-3.5" />
            {isBangla ? "নিরাপদ এনক্রিপ্টেড প্রবেশদ্বার" : "256-Bit Escrow Vault Gateway"}
          </div>
          <h1 className="text-2xl font-black text-slate-900 tracking-tight">
            {isBangla ? "স্বপ্নযাত্রী ইনভেস্টর পোর্টাল" : "Swapnojatri Portal"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "আপনার অ্যাকাউন্টে প্রবেশ করে বিনিয়োগের হালনাগাদ ও লাভ দেখুন"
              : "Access your dashboard to track lots, payouts & certificates"}
          </p>
        </div>

        {/* Auth Mode Toggle */}
        <div className="flex p-1 bg-slate-100 rounded-xl">
          <button
            type="button"
            onClick={() => setAuthMode("PASSWORD")}
            className={`flex-1 py-2 text-xs font-bold rounded-lg transition-all cursor-pointer ${
              authMode === "PASSWORD"
                ? "bg-white text-[#0066FF] shadow-sm"
                : "text-slate-500 hover:text-slate-800"
            }`}
          >
            {isBangla ? "পাসওয়ার্ড লগইন" : "Password Login"}
          </button>
          <button
            type="button"
            onClick={() => setAuthMode("OTP")}
            className={`flex-1 py-2 text-xs font-bold rounded-lg transition-all cursor-pointer ${
              authMode === "OTP"
                ? "bg-white text-[#0066FF] shadow-sm"
                : "text-slate-500 hover:text-slate-800"
            }`}
          >
            {isBangla ? "ওটিপি লগইন" : "SMS OTP Login"}
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-1.5">
            <label className="text-xs font-bold text-slate-700 block">
              {isBangla ? "মোবাইল নম্বর বা ইউজারনেম" : "Registered Phone Number or ID"}
            </label>
            <div className="relative">
              <Phone className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                type="text"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                required
                className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm font-medium focus:outline-none focus:border-[#0066FF] focus:ring-2 focus:ring-blue-100 transition-all text-slate-800"
                placeholder="+880 1700-000000"
              />
            </div>
          </div>

          {authMode === "PASSWORD" ? (
            <div className="space-y-1.5">
              <div className="flex justify-between items-center">
                <label className="text-xs font-bold text-slate-700 block">
                  {isBangla ? "পাসওয়ার্ড" : "Password"}
                </label>
                <a href="#forgot" className="text-[11px] font-bold text-[#0066FF] hover:underline">
                  {isBangla ? "পাসওয়ার্ড ভুলে গেছেন?" : "Forgot?"}
                </a>
              </div>
              <div className="relative">
                <Lock className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type={showPassword ? "text" : "password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  className="w-full pl-10 pr-10 py-2.5 rounded-xl border border-slate-200 text-sm font-medium focus:outline-none focus:border-[#0066FF] focus:ring-2 focus:ring-blue-100 transition-all text-slate-800"
                  placeholder="••••••••"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 cursor-pointer"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>
          ) : (
            <div className="p-3 bg-blue-50/70 border border-blue-200/80 rounded-xl text-xs text-blue-800 font-medium">
              {isBangla
                ? "লগইনে চাপ দিলে আপনার নম্বরে ৬ ডিজিটের গোপন কোড পাঠানো হবে।"
                : "A 6-digit one-time PIN will be dispatched to your phone upon submission."}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 rounded-xl bg-[#0A2540] hover:bg-[#0066FF] text-white font-bold text-sm shadow-md hover:shadow-lg transition-all duration-200 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-70"
          >
            <span>
              {loading
                ? isBangla ? "যাচাই করা হচ্ছে..." : "Verifying..."
                : isBangla ? "পোর্টালে প্রবেশ করুন" : "Secure Login"}
            </span>
            <ArrowRight className="w-4 h-4" />
          </button>
        </form>

        {/* Real Registration & Support Links */}
        <div className="pt-4 border-t border-slate-100 space-y-2 text-center">
          <p className="text-xs text-slate-500 font-medium">
            {isBangla ? "নতুন বিনিয়োগকারী হিসেবে যুক্ত হতে চান?" : "New to Swapnojatri Platform?"}{" "}
            <Link href="/register" className="text-[#0066FF] font-bold hover:underline">
              {isBangla ? "নিবন্ধন করুন" : "Register Now"}
            </Link>
          </p>
          <p className="text-[11px] text-slate-400">
            {isBangla
              ? "লগইন বা সহায়তা পেতে যোগাযোগ করুন: "
              : "Need help? Contact Investor Desk: "}{" "}
            <Link href="/contact" className="text-slate-600 font-semibold hover:underline">
              {isBangla ? "সহায়তা ডেস্ক" : "Support"}
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}

export default function LoginPage() {
  return (
    <Suspense fallback={<div className="min-h-[80vh] flex items-center justify-center text-slate-400 font-medium">Loading login...</div>}>
      <LoginForm />
    </Suspense>
  );
}
