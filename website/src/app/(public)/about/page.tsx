"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldCheck, Building2, Scale, Users, Award, CheckCircle2, HeartHandshake } from "lucide-react";

export default function AboutPage() {
  const { isBangla } = useAuth();

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-16">
      {/* 1. Mission Header */}
      <div className="text-center max-w-3xl mx-auto space-y-4">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "আমাদের পরিচয় ও লক্ষ্য" : "Our Vision & Mission"}
        </span>
        <h1 className="text-3xl sm:text-5xl font-black text-slate-900 leading-tight">
          {isBangla
            ? "বাংলাদেশে ভূমি ও কৃষি বিনিয়োগের নির্ভরযোগ্য প্ল্যাটফর্ম"
            : "Democratizing Asset-Backed Land & Agro Crowdfunding in Bangladesh"}
        </h1>
        <p className="text-base text-slate-600 leading-relaxed">
          {isBangla
            ? "স্বপ্নযাত্রী একটি ফিনটেক ইনভেস্টমেন্ট প্ল্যাটফর্ম যা সাধারণ মানুষকে বড় অঙ্কের ভূমি ও কৃষি প্রকল্পে নিরাপদ অংশীদারিত্বের সুযোগ দেয়। আইনি যাচাই, শতভাগ এসক্রো সুরক্ষা এবং ডিজিটাল স্বচ্ছতাই আমাদের মূল শক্তি।"
            : "Swapnojatri empowers retail investors to co-own verified freehold land and high-yield agro projects with institutional legal vetting, bank escrow clearing, and zero guaranteed return compromises."}
        </p>
      </div>

      {/* 2. Core Pillars Matrix */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div className="p-8 rounded-2xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-xl bg-brand-light text-brand-forest flex items-center justify-center">
            <ShieldCheck className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "নিষ্কণ্টক আইনি দলিল" : "100% Vetted Freehold Title"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "প্রতিটি প্রজেক্টের জমি সুপ্রিম কোর্টের অভিজ্ঞ আইনজীবীদের দ্বারা সিএস, এসএ, আরএস ও সিটি জরিপ পুঙ্খানুপুঙ্খ যাচাই করা হয়।"
              : "Every land parcel undergoes exhaustive title deed searches, AC Land mutation checks, and Supreme Court legal vetting."}
          </p>
        </div>

        <div className="p-8 rounded-2xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-xl bg-gold/10 text-gold-dark flex items-center justify-center">
            <Building2 className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "সিটি ব্যাংক এসক্রো হিসাব" : "Bank Escrow Security"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "বিনিয়োগকারীদের অর্থ সরাসরি আমাদের নির্ধারিত ব্যাংক এসক্রো অ্যাকাউন্টে জমা হয় এবং কেবল অডিটেড খরচের জন্যই ব্যবহৃত হয়।"
              : "Investor funds are held strictly in City Bank PLC dedicated escrow accounts with audited voucher-based disbursements."}
          </p>
        </div>

        <div className="p-8 rounded-2xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-700 flex items-center justify-center">
            <Scale className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "শরীয়াহ ও প্রো-রাটা মডেল" : "Shariah & Pro-Rata Model"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "কোনো কাল্পনিক ফিক্সড রিটার্ন নেই। বাস্তব প্রকল্প রাজস্ব থেকে অর্জিত লাভ গাণিতিক প্রো-রাটা অনুপাতে বণ্টন করা হয়।"
              : "No fictitious fixed return promises. Realized operational profits are distributed mathematically to lot holders."}
          </p>
        </div>
      </div>

      {/* 3. Leadership & Legal Advisory Desk */}
      <div className="p-8 sm:p-12 rounded-3xl bg-slate-900 text-white space-y-8">
        <div className="space-y-2 text-center max-w-2xl mx-auto">
          <span className="text-xs font-bold uppercase text-gold font-mono">INSTITUTIONAL GOVERNANCE</span>
          <h2 className="text-2xl sm:text-3xl font-black">
            {isBangla ? "পরিচালনা ও আইনি উপদেষ্টা প্যানেল" : "Management & Legal Advisory Directorate"}
          </h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 pt-4">
          <div className="p-6 rounded-2xl bg-slate-800/80 border border-slate-700 space-y-2">
            <span className="text-xs text-gold font-bold">Legal Advisory</span>
            <h4 className="text-lg font-bold text-white">Chambers of Senior Advocate, Supreme Court</h4>
            <p className="text-xs text-slate-400">
              Leading the title vetting, Sub-Registry deed execution, AC Land mutations, and regulatory compliance.
            </p>
          </div>

          <div className="p-6 rounded-2xl bg-slate-800/80 border border-slate-700 space-y-2">
            <span className="text-xs text-gold font-bold">Financial & Audit</span>
            <h4 className="text-lg font-bold text-white">Chartered Accountants & Financial Analysts</h4>
            <p className="text-xs text-slate-400">
              Overseeing fund utilization ledgers, expense voucher verification, and pro-rata dividend calculation.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
