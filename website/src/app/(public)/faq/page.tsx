"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { ChevronDown, HelpCircle, ShieldCheck } from "lucide-react";

export default function FaqPage() {
  const { isBangla } = useAuth();
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  const faqs = [
    {
      q: isBangla ? "ল্যান্ডভেস্ট ১০০ (LV100) কী ধরণের প্রকল্প?" : "What is the LandVest 100 (LV100) project?",
      a: isBangla
        ? "ল্যান্ডভেস্ট ১০০ হল সাভার হেমায়েতপুরের ওয়াশপুর মৌজায় ২২.৫ শতাংশ বাণিজ্যিক ফ্রিহোল্ড জমির ক্রাউডফান্ডিং প্রকল্প। মোট ২৫,৫০,০০০ টাকার তহবিল ১০০টি নির্দিষ্ট শেয়ারে বিভক্ত। প্রতি শেয়ারের মূল্য ২৫,৫০০ টাকা।"
        : "LandVest 100 is an asset-backed real estate co-ownership project on 22.5 decimals of commercial freehold land in Savar, Dhaka. The total target fund of ৳25,50,000 is divided into 100 fixed shares of ৳25,500 each.",
    },
    {
      q: isBangla ? "আমার বিনিয়োগের আইনি নিরাপত্তা কী?" : "What is the legal security of my investment?",
      a: isBangla
        ? "প্রতিটি বিনিয়োগকারী সাব-রেজিস্ট্রি দলিল #৪৯৮২/২০২৬ অনুযায়ী জমির ইকুইটি শেয়ারের দাবিদার হবেন। পেমেন্ট সম্পন্ন হলে SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশযুক্ত ডিজিটাল শেয়ার সার্টিফিকেট প্রদান করা হয়। সকল দলিল সুপ্রিম কোর্টের সিনিয়র আইনজীবী দ্বারা প্রত্যায়িত।"
        : "Every investor co-owns equity under registered Sub-Registry Deed #4982/2026. Upon allocation, an official cryptographic PDF share certificate with an immutable SHA-256 hash is issued to your document vault.",
    },
    {
      q: isBangla ? "একজন বিনিয়োগকারী সর্বোচ্চ কতটি শেয়ার কিনতে পারবেন?" : "What is the share limit per investor?",
      a: isBangla
        ? "বিনিয়োগের বৈচিত্র্য ও সাধারণ মানুষের অংশগ্রহণ নিশ্চিত করতে একজন বিনিয়োগকারী সর্বনিম্ন ১টি এবং সর্বোচ্চ ৪টি শেয়ার (সর্বোচ্চ ১,০২,০০০ টাকা) সাবস্ক্রাইব করতে পারবেন।"
        : "To ensure broad co-ownership and institutional risk control, each investor can purchase a minimum of 1 share and a maximum of 4 shares (up to ৳1,02,000).",
    },
    {
      q: isBangla ? "পেমেন্ট কীভাবে করা যায়?" : "What payment methods are supported?",
      a: isBangla
        ? "আমরা দুটি সুরক্ষিত পদ্ধতি সমর্থন করি: ১) EPS পেমেন্ট গেটওয়ের মাধ্যমে তাৎক্ষণিক বিকাশ, নগদ, রকেট, ভিসা/মাস্টারকার্ড ও নেট ব্যাংকিং। ২) সিটি ব্যাংক এসক্রো অ্যাকাউন্টে সরাসরি টাকা জমা দিয়ে ব্যাংক স্লিপ আপলোড।"
        : "We support dual payment channels: 1) Instant online checkout via EPS Payment Gateway (bKash, Nagad, Rocket, Visa/Mastercard, Net Banking), and 2) Direct bank deposit into City Bank PLC Escrow with deposit slip upload.",
    },
    {
      q: isBangla ? "লভ্যাংশ কীভাবে বণ্টিত হয় এবং এটা কি নিশ্চিত?" : "How is profit distributed and is it guaranteed?",
      a: isBangla
        ? "ইসলামিক শরীয়াহ ও ফিনটেক নিয়মানুযায়ী আমরা কোনো ফিক্সড বা গ্যারান্টেড রিটার্নের প্রতিশ্রুতি দিই না। প্রকল্পের বাণিজ্যিক ভাড়া ও অর্জিত রাজস্ব থেকে অর্জিত মোট মুনাফা প্রো-রাটা সূত্রে (লভ্যাংশ পুল × শেয়ার সংখ্যা ÷ ১০০) বণ্টিত হয়।"
        : "In adherence to Shariah asset-backed principles, returns are not artificially guaranteed. Realized net operational profits from the commercial land are distributed pro-rata based on your verified lot share percentage.",
    },
    {
      q: isBangla ? "আমার লভ্যাংশ কীভাবে ব্যাংক অ্যাকাউন্টে আসবে?" : "How do I receive my dividend payouts?",
      a: isBangla
        ? "কেওয়াইসি (KYC) প্রোফাইলে প্রদানকৃত আপনার নিজস্ব ব্যাংক অ্যাকাউন্ট বা বিকাশ অ্যাকাউন্টে প্রতিটি অডিট পিরিয়ড শেষে স্বয়ংক্রিয়ভাবে লভ্যাংশ পাঠিয়ে দেওয়া হয়।"
        : "Dividends are deposited directly into your designated settlement bank account or mobile wallet provided during your KYC compliance submission.",
    },
  ];

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-10">
      <div className="text-center space-y-3">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "প্রশ্নোত্তর ও তথ্য" : "Frequently Asked Questions"}
        </span>
        <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
          {isBangla ? "সাধারণ জিজ্ঞাসা ও উত্তর" : "Platform Disclosures & FAQ"}
        </h1>
        <p className="text-sm text-slate-600">
          {isBangla
            ? "আইনি দলিল, শেয়ার বরাদ্দ, এসক্রো নিরাপত্তা ও লভ্যাংশ বণ্টন সম্পর্কিত সকল তথ্যাবলি"
            : "Everything you need to know about legal security, share limits, escrow clearing, and dividends"}
        </p>
      </div>

      {/* Accordion FAQ List */}
      <div className="space-y-4">
        {faqs.map((faq, idx) => {
          const isOpen = openIndex === idx;
          return (
            <div
              key={idx}
              className="rounded-2xl bg-white border border-slate-200 overflow-hidden shadow-sm transition-all"
            >
              <button
                type="button"
                onClick={() => setOpenIndex(isOpen ? null : idx)}
                className="w-full p-6 text-left flex items-center justify-between gap-4 hover:bg-slate-50 transition-colors"
              >
                <span className="font-bold text-slate-900 text-base">{faq.q}</span>
                <ChevronDown
                  className={`w-5 h-5 text-slate-400 shrink-0 transition-transform ${
                    isOpen ? "rotate-180 text-brand-forest" : ""
                  }`}
                />
              </button>
              {isOpen && (
                <div className="px-6 pb-6 pt-2 text-sm text-slate-600 leading-relaxed border-t border-slate-100">
                  {faq.a}
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
