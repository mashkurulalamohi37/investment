"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { MapPin, Phone, Mail, Building2, Copy, Check, ShieldCheck, Clock } from "lucide-react";

export default function ContactPage() {
  const { isBangla } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);

  const copyToClipboard = (text: string, key: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(key);
    setTimeout(() => setCopiedKey(null), 2000);
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">
      <div className="text-center max-w-2xl mx-auto space-y-3">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "যোগাযোগ ও ঠিকানা" : "Offices & Official Banking"}
        </span>
        <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
          {isBangla ? "আমাদের সাথে যোগাযোগ করুন" : "Get in Touch with Swapnojatri"}
        </h1>
        <p className="text-sm text-slate-600">
          {isBangla
            ? "প্রধান কার্যালয়, প্রজেক্ট সাইট অফিস এবং অফিসিয়াল এসক্রো ব্যাংকিং বিবরণী"
            : "Head office, project site address, and verified escrow banking credentials"}
        </p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        {/* Left Official Escrow Card */}
        <div className="lg:col-span-7 bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <div className="flex items-center justify-between pb-4 border-b border-slate-100">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-gold/10 text-gold flex items-center justify-center">
                <Building2 className="w-6 h-6" />
              </div>
              <div>
                <h3 className="font-bold text-slate-900 text-base sm:text-lg">
                  {isBangla ? "অফিসিয়াল ব্যাংক ডিপোজিট অ্যাকাউন্ট" : "Official Company Bank Account"}
                </h3>
                <span className="text-xs text-slate-500 font-mono">The City Bank PLC (Escrow Clearing)</span>
              </div>
            </div>
            <span className="px-2.5 py-1 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
              VERIFIED ESCROW
            </span>
          </div>

          {/* Account Details Box */}
          <div className="p-5 rounded-xl bg-slate-50 border border-slate-200/90 space-y-4 font-mono text-sm">
            <div className="flex items-center justify-between">
              <div>
                <span className="text-[11px] text-slate-400 font-sans block">Account Name (হিসাবের নাম)</span>
                <span className="font-bold text-slate-900 font-sans">Swapnojatri Investment Platform Ltd</span>
              </div>
            </div>

            <div className="flex items-center justify-between pt-2 border-t border-slate-200/60">
              <div>
                <span className="text-[11px] text-slate-400 font-sans block">Account Number (হিসাব নম্বর)</span>
                <span className="font-black text-brand-forest text-base">1402-9988-7710-1</span>
              </div>
              <button
                onClick={() => copyToClipboard("1402998877101", "acc")}
                className="px-3 py-1.5 rounded-lg bg-white border border-slate-200 text-xs font-sans font-semibold text-slate-700 hover:bg-slate-100 flex items-center gap-1.5"
              >
                {copiedKey === "acc" ? <Check className="w-3.5 h-3.5 text-jade" /> : <Copy className="w-3.5 h-3.5" />}
                <span>{copiedKey === "acc" ? "Copied" : "Copy"}</span>
              </button>
            </div>

            <div className="grid grid-cols-2 gap-4 pt-2 border-t border-slate-200/60">
              <div>
                <span className="text-[11px] text-slate-400 font-sans block">Routing Number (রাউটিং নং)</span>
                <span className="font-bold text-slate-900">225275357</span>
              </div>
              <div>
                <span className="text-[11px] text-slate-400 font-sans block">Branch (শাখা)</span>
                <span className="font-bold text-slate-900 font-sans">Gulshan-1 Branch, Dhaka</span>
              </div>
            </div>
          </div>

          <p className="text-xs text-slate-500 flex items-center gap-2">
            <ShieldCheck className="w-4 h-4 text-jade shrink-0" />
            <span>
              {isBangla
                ? "ব্যাংক ডিপোজিট করার পর স্লিপের ছবি তুলে ইনভেস্টমেন্ট ফ্লোতে আপলোড করুন।"
                : "After deposit or BEFTN/NPSB transfer, upload the deposit slip photo for instant lot verification."}
            </span>
          </p>
        </div>

        {/* Right Office Addresses Card */}
        <div className="lg:col-span-5 space-y-6">
          <div className="bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5">
            <h3 className="font-bold text-slate-900 text-base pb-3 border-b border-slate-100">
              {isBangla ? "আমাদের কার্যালয়সমূহ" : "Office Locations & Desk"}
            </h3>

            <div className="space-y-4 text-xs text-slate-600">
              <div className="flex items-start gap-3">
                <MapPin className="w-5 h-5 text-brand-forest shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-bold text-slate-900 text-sm">{isBangla ? "কর্পোরেট প্রধান কার্যালয়" : "Corporate Head Office"}</h4>
                  <p>Level 7, Concord Tower, Road 11, Gulshan-1, Dhaka-1212</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <MapPin className="w-5 h-5 text-gold shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-bold text-slate-900 text-sm">{isBangla ? "সাভার প্রজেক্ট সাইট অফিস" : "Savar Site Inspection Office"}</h4>
                  <p>Washpur Tower Road, Hemayetpur, Savar, Dhaka</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <Phone className="w-5 h-5 text-brand-forest shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-bold text-slate-900 text-sm">{isBangla ? "হেল্পলাইন ও হোয়াটসঅ্যাপ" : "Helpline & WhatsApp Support"}</h4>
                  <p>+880 1712-345678 / +880 1819-998877</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <Mail className="w-5 h-5 text-brand-forest shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-bold text-slate-900 text-sm">{isBangla ? "অফিসিয়াল ইমেইল" : "Investor Relations Email"}</h4>
                  <p>invest@swapnojatri.com / support@swapnojatri.com</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <Clock className="w-5 h-5 text-brand-forest shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-bold text-slate-900 text-sm">{isBangla ? "অফিস সময়" : "Office Hours"}</h4>
                  <p>Sunday – Thursday: 9:30 AM – 6:30 PM (BST)</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
