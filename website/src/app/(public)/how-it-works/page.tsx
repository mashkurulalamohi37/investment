"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Users,
  ShieldCheck,
  Coins,
  Building2,
  Award,
  FileCheck2,
  TrendingUp,
  Scale,
  FileText,
  ArrowRight,
} from "lucide-react";

export default function HowItWorksPage() {
  const { isBangla } = useAuth();

  const steps = [
    {
      num: "1",
      title: isBangla ? "অ্যাকাউন্ট তৈরি ও মোবাইল OTP" : "Step 1: Create Account & Phone OTP",
      desc: isBangla
        ? "আপনার বাংলাদেশি মোবাইল নম্বর প্রদান করুন। তাৎক্ষণিক SMS OTP যাচাইয়ের মাধ্যমে আপনার সুরক্ষিত বিনিয়োগকারী অ্যাকাউন্ট সক্রিয় হবে।"
        : "Sign up using your active Bangladesh mobile number. Verify via instant SMS OTP to establish your encrypted investor identity.",
      icon: Users,
    },
    {
      num: "2",
      title: isBangla ? "স্মার্ট এনআইডি ও নমিনি কেওয়াইসি" : "Step 2: Smart NID & Nominee KYC",
      desc: isBangla
        ? "আইনি মালিকানা ও লভ্যাংশ অধিকারের জন্য আপনার স্মার্ট জাতীয় পরিচয়পত্র এবং নমিনির তথ্য সাবমিট করুন।"
        : "Submit your legal Smart NID details and designate your nominee for institutional compliance and inheritance records.",
      icon: ShieldCheck,
    },
    {
      num: "3",
      title: isBangla ? "প্রকল্প ও শেয়ার নির্বাচন (১-৪টি)" : "Step 3: Select Shares (1 to 4 limit)",
      desc: isBangla
        ? "ল্যান্ডভেস্ট ১০০ প্রকল্পে ১ থেকে ৪টি নির্দিষ্ট শেয়ার নির্বাচন করুন। ক্যালকুলেটরে সরাসরি মোট মূল্য ও ইকুইটি মালিকানা দেখা যাবে।"
        : "Choose 1 to 4 fixed shares in LandVest 100. The authoritative backend engine previews your exact capital and equity share.",
      icon: Coins,
    },
    {
      num: "4",
      title: isBangla ? "পেমেন্ট গেটওয়ে অথবা ব্যাংক জমা" : "Step 4: Dual Payment Engine Selection",
      desc: isBangla
        ? "EPS গেটওয়ের মাধ্যমে (বিকাশ, নগদ, রকেট, কার্ড) তাৎক্ষণিক পরিশোধ করুন অথবা আমাদের সিটি ব্যাংক এসক্রো অ্যাকাউন্টে জমা দিয়ে স্লিপের ছবি আপলোড করুন।"
        : "Pay instantly through EPS Payment Gateway (bKash/Nagad/Cards) or deposit directly into Swapnojatri's City Bank PLC Escrow Account.",
      icon: Building2,
    },
    {
      num: "5",
      title: isBangla ? "সিকোয়েনশিয়াল লট নম্বর বরাদ্দ" : "Step 5: Atomic Share Lot Assignment",
      desc: isBangla
        ? "পেমেন্ট নিশ্চিত হওয়ার সাথে সাথে ডাটাবেস স্বয়ংক্রিয়ভাবে অদ্বিতীয় সিকোয়েনশিয়াল লট নম্বর (যেমন: LOT-075, LOT-076) বরাদ্দ করবে।"
        : "Upon payment settlement, the backend locks and assigns non-overlapping sequential lot numbers (e.g. LOT-075, LOT-076).",
      icon: Award,
    },
    {
      num: "6",
      title: isBangla ? "ডিজিটাল শেয়ার সনদপত্র প্রাপ্তি" : "Step 6: Digital Share Certificate Issued",
      desc: isBangla
        ? "আপনার ডকুমেন্টস ভল্টে SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশযুক্ত অফিসিয়াল শেয়ার সার্টিফিকেট জেনারেট হবে।"
        : "An official PDF Share Certificate with SHA-256 cryptographic verification is generated into your personal Document Vault.",
      icon: FileCheck2,
    },
    {
      num: "7",
      title: isBangla ? "লাইভ ফান্ড ও ভাউচার ট্র্যাকিং" : "Step 7: Real-Time Transparency Tracking",
      desc: isBangla
        ? "জমির উন্নয়ন ও প্রজেক্টের প্রতিটি খরচের অনুমোদিত ভাউচার, অডিট রিপোর্ট এবং এসক্রো ব্যালেন্স ২৪/৭ লাইভ ট্র্যাক করুন।"
        : "Track verified expense vouchers, surveyor bills, and bank escrow balances in real-time on the project transparency ledger.",
      icon: TrendingUp,
    },
    {
      num: "8",
      title: isBangla ? "প্রো-রাটা লভ্যাংশ বণ্টন" : "Step 8: Pro-Rata Profit Distribution",
      desc: isBangla
        ? "বাণিজ্যিক ও কৃষি প্রজেক্টের মুনাফা গাণিতিক প্রো-রাটা সূত্রে সরাসরি আপনার ব্যাংক অ্যাকাউন্টে জমা হবে।"
        : "Realized project profits are distributed mathematically into your settlement bank account based on your owned lot count.",
      icon: Scale,
    },
    {
      num: "9",
      title: isBangla ? "অফিসিয়াল অডিট ও ট্যাক্স রিপোর্ট" : "Step 9: Financial Statements & Exit",
      desc: isBangla
        ? "যেকোনো সময় ট্যাক্স বা ব্যক্তিগত অডিটের জন্য অফিসিয়াল ইনভেস্টমেন্ট স্টেটমেন্ট ডাউনলোড করতে পারবেন।"
        : "Export audited financial statements, tax certificates, and portfolio valuation records whenever needed.",
      icon: FileText,
    },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "স্বচ্ছ বিনিয়োগ কাঠামো" : "Transparent Investor Process"}
        </span>
        <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
          {isBangla ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম কীভাবে কাজ করে?" : "How Swapnojatri Platform Works"}
        </h1>
        <p className="text-sm text-slate-600">
          {isBangla
            ? "আইনি নিরাপত্তা, এসক্রো ব্যাংক অ্যাকাউন্টের সুরক্ষা এবং স্বয়ংক্রিয় লট বরাদ্দের সম্পূর্ণ ৯-ধাপ প্রক্রিয়া"
            : "Complete 9-step institutional process ensuring legal security, escrow safety, and automated lot distribution"}
        </p>
      </div>

      <div className="space-y-6 max-w-4xl mx-auto">
        {steps.map((st) => (
          <div
            key={st.num}
            className="p-6 sm:p-8 rounded-2xl bg-white border border-slate-200 shadow-card hover:shadow-cardHover transition-all flex flex-col sm:flex-row items-start gap-6"
          >
            <div className="w-12 h-12 rounded-2xl bg-gradient-emerald text-gold font-black text-lg flex items-center justify-center shrink-0 shadow-md shadow-brand-forest/20">
              {st.num}
            </div>
            <div className="space-y-2 flex-1">
              <div className="flex items-center gap-2">
                <st.icon className="w-5 h-5 text-brand-forest" />
                <h3 className="text-lg font-bold text-slate-900">{st.title}</h3>
              </div>
              <p className="text-sm text-slate-600 leading-relaxed">{st.desc}</p>
            </div>
          </div>
        ))}
      </div>

      {/* CTA Box */}
      <div className="text-center pt-8">
        <Link
          href="/projects/landvest-100"
          className="inline-flex items-center gap-2 px-8 py-4 rounded-xl bg-gradient-gold text-slate-950 font-bold text-base hover:opacity-95 shadow-goldGlow transition-all"
        >
          <span>{isBangla ? "ল্যান্ডভেস্ট ১০০-এ বিনিয়োগ করুন" : "Get Started with LandVest 100"}</span>
          <ArrowRight className="w-5 h-5 text-slate-950" />
        </Link>
      </div>
    </div>
  );
}
