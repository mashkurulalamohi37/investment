"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  MapPin,
  Phone,
  Mail,
  Building2,
  Copy,
  Check,
  ShieldCheck,
  Clock,
  Send,
  CheckCircle2,
  User,
  MessageSquare,
  Sparkles,
  ExternalLink,
  ChevronRight,
  Landmark,
  CreditCard,
} from "lucide-react";

export default function ContactPage() {
  const { isBangla } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [inquirySent, setInquirySent] = useState(false);
  const [inquiryType, setInquiryType] = useState("share_booking");

  const copyToClipboard = (text: string, key: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(key);
    setTimeout(() => setCopiedKey(null), 2000);
  };

  const handleInquirySubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setInquirySent(true);
    setTimeout(() => setInquirySent(false), 5000);
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-10">
      {/* 1. Hero Header */}
      <div className="text-center max-w-3xl mx-auto space-y-4">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <Landmark className="w-3.5 h-3.5 text-[#0066FF]" />
          <span>{isBangla ? "অফিসিয়াল যোগাযোগ ও ব্যাংকিং" : "Institutional Contact & Banking"}</span>
        </div>
        <h1 className="text-3xl sm:text-5xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "আমাদের সাথে যুক্ত হোন" : "Connect with Swapnojatri"}
        </h1>
        <p className="text-sm sm:text-base text-slate-600 font-normal leading-relaxed">
          {isBangla
            ? "প্রকল্প পরিদর্শন, শেয়ার বুকিং কিংবা ব্যাংক এসক্রো ডিপোজিট সংক্রান্ত যেকোনো প্রয়োজনে আমাদের সাথে সরাসরি যোগাযোগ করুন।"
            : "Reach out for project site visits, share subscriptions, or verified bank escrow clearing inquiries."}
        </p>
      </div>

      {/* 2. Main 2-Column Bento Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        {/* Left Column: Escrow Passbook + Office Hub (7 cols) */}
        <div className="lg:col-span-7 space-y-6">
          
          {/* Virtual Escrow Banking Card */}
          <div className="relative rounded-3xl overflow-hidden bg-gradient-to-br from-[#0A2540] via-[#041628] to-[#0A2540] text-white p-6 sm:p-8 shadow-2xl border border-slate-800 space-y-6">
            <div className="absolute top-0 right-0 w-64 h-64 bg-[#0066FF]/15 rounded-full blur-3xl pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-48 h-48 bg-[#00B4D8]/10 rounded-full blur-2xl pointer-events-none" />

            {/* Top Bank Identity Bar */}
            <div className="flex items-center justify-between relative z-10">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-white/10 backdrop-blur-md flex items-center justify-center border border-white/20">
                  <Landmark className="w-5 h-5 text-[#00B4D8]" />
                </div>
                <div>
                  <h3 className="text-sm sm:text-base font-extrabold tracking-wide uppercase text-white">
                    The City Bank PLC
                  </h3>
                  <span className="text-[11px] text-cyan-light font-medium block">
                    {isBangla ? "এসক্রো ট্রাস্টি ও ক্লিয়ারিং পার্টনার" : "Custodial Escrow & Clearing Partner"}
                  </span>
                </div>
              </div>

              <span className="px-3 py-1 rounded-full text-[10px] font-bold bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                100% ESCROW SAFE
              </span>
            </div>

            {/* Account Title */}
            <div className="relative z-10 space-y-1">
              <span className="text-[10px] uppercase font-mono tracking-widest text-slate-400">
                {isBangla ? "হিসাবের নাম (Beneficiary Title)" : "Beneficiary Title"}
              </span>
              <p className="text-base sm:text-lg font-black tracking-wide text-white">
                Swapnojatri Investment Platform Ltd
              </p>
            </div>

            {/* Account Number with 1-Click Copy */}
            <div className="relative z-10 p-4 rounded-2xl bg-white/10 backdrop-blur-md border border-white/15 flex items-center justify-between">
              <div>
                <span className="text-[10px] uppercase font-mono tracking-widest text-cyan-light block">
                  {isBangla ? "এসক্রো হিসাব নম্বর (Account Number)" : "Escrow Account Number"}
                </span>
                <span className="text-xl sm:text-2xl font-black font-mono tracking-wider text-white mt-0.5 block">
                  1402-9988-7710-1
                </span>
              </div>
              <button
                type="button"
                onClick={() => copyToClipboard("1402998877101", "acc")}
                className="px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold flex items-center gap-1.5 transition-all shadow-md shadow-[#0066FF]/30 cursor-pointer"
              >
                {copiedKey === "acc" ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
                <span>{copiedKey === "acc" ? (isBangla ? "কপি হয়েছে!" : "Copied!") : isBangla ? "কপি করুন" : "Copy"}</span>
              </button>
            </div>

            {/* Routing Number, Branch & Accepted Channels */}
            <div className="relative z-10 grid grid-cols-2 gap-3 text-xs pt-1">
              <div className="p-3 rounded-xl bg-white/5 border border-white/10 flex items-center justify-between">
                <div>
                  <span className="text-[10px] text-slate-400 uppercase font-mono block">
                    {isBangla ? "রাউটিং নম্বর" : "Routing No"}
                  </span>
                  <span className="font-bold font-mono text-white text-sm">225275357</span>
                </div>
                <button
                  type="button"
                  onClick={() => copyToClipboard("225275357", "rt")}
                  className="p-1 rounded text-slate-400 hover:text-white hover:bg-white/10"
                  title="Copy Routing Number"
                >
                  {copiedKey === "rt" ? <Check className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
                </button>
              </div>

              <div className="p-3 rounded-xl bg-white/5 border border-white/10">
                <span className="text-[10px] text-slate-400 uppercase font-mono block">
                  {isBangla ? "শাখা (Branch)" : "Branch"}
                </span>
                <span className="font-bold text-white text-xs truncate block">Gulshan-1 Branch, Dhaka</span>
              </div>
            </div>

            {/* Bottom Channels */}
            <div className="relative z-10 pt-2 border-t border-white/10 flex flex-wrap items-center justify-between gap-2 text-[11px] text-slate-400">
              <span>{isBangla ? "অনুমোদিত লেনদেন মাধ্যম:" : "Accepted Channels:"}</span>
              <div className="flex gap-1.5">
                <span className="px-2 py-0.5 rounded bg-white/10 text-white font-mono text-[10px] font-bold">BEFTN</span>
                <span className="px-2 py-0.5 rounded bg-white/10 text-white font-mono text-[10px] font-bold">NPSB</span>
                <span className="px-2 py-0.5 rounded bg-white/10 text-white font-mono text-[10px] font-bold">RTGS</span>
                <span className="px-2 py-0.5 rounded bg-white/10 text-white font-mono text-[10px] font-bold">Pay-Order</span>
              </div>
            </div>
          </div>

          {/* 4 Office & Contact Cards */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {/* Corporate Head Office */}
            <div className="p-5 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-2">
              <div className="w-10 h-10 rounded-2xl bg-blue-50 text-[#0066FF] flex items-center justify-center">
                <Building2 className="w-5 h-5" />
              </div>
              <h4 className="font-extrabold text-[#0A2540] text-sm">
                {isBangla ? "প্রধান কার্যালয় (গুলশান-১, ঢাকা)" : "Corporate Head Office (Gulshan-1)"}
              </h4>
              <p className="text-xs text-slate-500 leading-relaxed">
                {isBangla
                  ? "লেভেল ৭, কনকর্ড টাওয়ার, রোড ১১, গুলশান-১, ঢাকা-১২১২"
                  : "Level 7, Concord Tower, Road 11, Gulshan-1, Dhaka-1212"}
              </p>
            </div>

            {/* Savar Site Desk */}
            <div className="p-5 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-2">
              <div className="w-10 h-10 rounded-2xl bg-cyan-50 text-[#00B4D8] flex items-center justify-center">
                <MapPin className="w-5 h-5" />
              </div>
              <h4 className="font-extrabold text-[#0A2540] text-sm">
                {isBangla ? "সাভার প্রজেক্ট সাইট অফিস" : "Savar Project Site Desk"}
              </h4>
              <p className="text-xs text-slate-500 leading-relaxed">
                {isBangla
                  ? "ওয়াশপুর টাওয়ার রোড (বসিলা ব্রিজ সংলগ্ন), হেমায়েতপুর, সাভার"
                  : "Washpur Tower Road (Near Bosila Bridge), Savar, Dhaka"}
              </p>
            </div>

            {/* Helpline */}
            <div className="p-5 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-2">
              <div className="w-10 h-10 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
                <Phone className="w-5 h-5" />
              </div>
              <h4 className="font-extrabold text-[#0A2540] text-sm">
                {isBangla ? "হেল্পলাইন ও হোয়াটসঅ্যাপ" : "Helpline & WhatsApp"}
              </h4>
              <p className="text-xs font-mono font-bold text-slate-800">
                +880 1712-345678 / +880 1819-998877
              </p>
            </div>

            {/* Email & Hours */}
            <div className="p-5 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-2">
              <div className="w-10 h-10 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center">
                <Mail className="w-5 h-5" />
              </div>
              <h4 className="font-extrabold text-[#0A2540] text-sm">
                {isBangla ? "অফিসিয়াল ইমেইল" : "Investor Relations Email"}
              </h4>
              <p className="text-xs font-mono text-slate-600 truncate">
                invest@swapnojatri.com
              </p>
            </div>
          </div>
        </div>

        {/* Right Column: Dedicated Inquiry Form (5 cols) */}
        <div className="lg:col-span-5 bg-white rounded-3xl border border-slate-200/90 shadow-card p-6 sm:p-8 space-y-6">
          <div className="space-y-1.5 pb-4 border-b border-slate-100">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[11px] font-bold bg-blue-50 text-[#0066FF]">
              <MessageSquare className="w-3.5 h-3.5" />
              <span>{isBangla ? "ইনভেস্টর হেল্পডেস্ক" : "Investor Helpdesk"}</span>
            </div>
            <h3 className="text-xl font-extrabold text-[#0A2540]">
              {isBangla ? "সরাসরি বার্তা পাঠান" : "Send an Inquiry"}
            </h3>
            <p className="text-xs text-slate-500 font-normal">
              {isBangla
                ? "আমাদের অভিজ্ঞ ইনভেস্টর রিলেশনস টিম সর্বোচ্চ ২ কর্মঘণ্টার মধ্যে আপনার সাথে যোগাযোগ করবে।"
                : "Our dedicated relations desk will get back to you within 2 working hours."}
            </p>
          </div>

          {inquirySent ? (
            <div className="p-6 rounded-2xl bg-emerald-50 border border-emerald-200 text-emerald-800 space-y-2 text-center">
              <CheckCircle2 className="w-8 h-8 text-emerald-600 mx-auto" />
              <h4 className="font-bold text-sm">
                {isBangla ? "বার্তাটি সফলভাবে পাঠানো হয়েছে!" : "Inquiry Submitted Successfully!"}
              </h4>
              <p className="text-xs text-emerald-700">
                {isBangla
                  ? "আমাদের একজন প্রতিনিধি দ্রুত আপনার মোবাইলে যোগাযোগ করবেন।"
                  : "One of our investment advisors will contact you shortly."}
              </p>
            </div>
          ) : (
            <form onSubmit={handleInquirySubmit} className="space-y-4 text-xs">
              {/* Inquiry Category Selector */}
              <div className="space-y-1.5">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "অনুসন্ধানের বিষয়" : "Inquiry Topic"}
                </label>
                <div className="grid grid-cols-2 gap-2">
                  <button
                    type="button"
                    onClick={() => setInquiryType("share_booking")}
                    className={`p-2.5 rounded-xl border text-center font-bold transition-all ${
                      inquiryType === "share_booking"
                        ? "bg-[#0066FF] text-white border-[#0066FF] shadow-xs"
                        : "bg-slate-50 text-slate-600 border-slate-200 hover:bg-slate-100"
                    }`}
                  >
                    {isBangla ? "শেয়ার বুকিং" : "Share Booking"}
                  </button>
                  <button
                    type="button"
                    onClick={() => setInquiryType("site_visit")}
                    className={`p-2.5 rounded-xl border text-center font-bold transition-all ${
                      inquiryType === "site_visit"
                        ? "bg-[#0066FF] text-white border-[#0066FF] shadow-xs"
                        : "bg-slate-50 text-slate-600 border-slate-200 hover:bg-slate-100"
                    }`}
                  >
                    {isBangla ? "সাইট ভিজিট" : "Site Visit"}
                  </button>
                </div>
              </div>

              {/* Name */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "আপনার পূর্ণ নাম" : "Your Full Name"}
                </label>
                <div className="relative">
                  <User className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
                  <input
                    type="text"
                    required
                    placeholder={isBangla ? "যেমন: তারিকুল ইসলাম" : "e.g. Tariqul Islam"}
                    className="w-full pl-10 pr-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 focus:outline-none focus:border-[#0066FF] focus:bg-white text-slate-900 font-medium transition-all"
                  />
                </div>
              </div>

              {/* Phone */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "মোবাইল নম্বর" : "Mobile Phone"}
                </label>
                <div className="relative">
                  <Phone className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
                  <input
                    type="tel"
                    required
                    placeholder={isBangla ? "০১৭১২-৩৪৫৬৭৮" : "+880 1712-345678"}
                    className="w-full pl-10 pr-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 focus:outline-none focus:border-[#0066FF] focus:bg-white text-slate-900 font-medium transition-all"
                  />
                </div>
              </div>

              {/* Message */}
              <div className="space-y-1">
                <label className="font-bold text-slate-700 block">
                  {isBangla ? "আপনার প্রশ্ন বা মন্তব্য" : "Your Message / Question"}
                </label>
                <textarea
                  rows={3}
                  required
                  placeholder={
                    isBangla
                      ? "ল্যান্ডভেস্ট ১০০ প্রজেক্ট বা ব্যাংক ডিপোজিট সংক্রান্ত আপনার প্রশ্ন লিখুন..."
                      : "Write your question about share booking or bank escrow..."
                  }
                  className="w-full px-4 py-3 rounded-2xl bg-slate-50 border border-slate-200 focus:outline-none focus:border-[#0066FF] focus:bg-white text-slate-900 font-medium resize-none transition-all"
                />
              </div>

              <button
                type="submit"
                className="w-full py-3.5 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white font-extrabold text-xs sm:text-sm shadow-md shadow-[#0066FF]/25 transition-all flex items-center justify-center gap-2 group cursor-pointer"
              >
                <Send className="w-4 h-4 text-[#00B4D8] transition-transform group-hover:translate-x-1" />
                <span>{isBangla ? "বার্তা পাঠান" : "Submit Inquiry"}</span>
              </button>

              <div className="flex items-center justify-center gap-1.5 text-[11px] text-slate-400 pt-1">
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-600" />
                <span>{isBangla ? "আপনার তথ্য ১০০% সুরক্ষিত ও গোপনীয়" : "Your privacy is 100% protected"}</span>
              </div>
            </form>
          )}
        </div>
      </div>

      {/* 3. Interactive Google Maps Section (Concord Tower, Road 11, Gulshan-1, Dhaka) */}
      <section className="space-y-4 pt-4">
        <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-2">
          <div>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-blue-50 text-[#0066FF]">
              <MapPin className="w-3.5 h-3.5" />
              <span>{isBangla ? "গুগল ম্যাপ লোকেশন" : "Interactive Office Map"}</span>
            </div>
            <h2 className="text-xl sm:text-2xl font-black text-[#0A2540] tracking-tight mt-1">
              {isBangla ? "আমাদের লোকেশন (কনকর্ড টাওয়ার, গুলশান-১, ঢাকা)" : "Find Us at Concord Tower, Gulshan-1, Dhaka"}
            </h2>
          </div>
          <a
            href="https://www.google.com/maps/dir/?api=1&destination=Concord+Tower+Road+11+Gulshan-1+Dhaka"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-1.5 px-4 py-2 rounded-xl bg-white border border-slate-200 shadow-sm hover:border-[#0066FF] hover:text-[#0066FF] text-xs font-bold text-slate-700 transition-all cursor-pointer"
          >
            <span>{isBangla ? "গুগল ম্যাপে দিকনির্দেশনা পান" : "Get Directions on Google Maps"}</span>
            <ExternalLink className="w-3.5 h-3.5" />
          </a>
        </div>

        {/* Compact Map Container with Floating Overlay */}
        <div className="relative w-full h-[260px] sm:h-[300px] rounded-2xl overflow-hidden border border-slate-200/90 shadow-card bg-slate-100">
          {/* Embedded Google Maps iframe pinpointed to Concord Tower, Gulshan-1, Dhaka */}
          <iframe
            title="Concord Tower Gulshan-1 Location Map"
            src="https://maps.google.com/maps?q=Concord+Tower,+Road+11,+Gulshan-1,+Dhaka,+Bangladesh&t=&z=16&ie=UTF8&iwloc=&output=embed"
            className="w-full h-full border-0"
            loading="lazy"
            allowFullScreen
          />

          {/* Floating Google Map Card (Concord Tower, Gulshan-1 - Exact Google Maps Widget Style) */}
          <div className="absolute top-3 left-3 sm:top-4 sm:left-4 max-w-[270px] sm:max-w-[310px] bg-white rounded-xl p-3.5 sm:p-4 shadow-lg border border-slate-200/90 z-10 space-y-2">
            <div className="flex items-start justify-between gap-3">
              <div>
                <h3 className="font-bold text-sm sm:text-base text-slate-900 leading-snug">
                  Concord Tower
                </h3>
                <p className="text-xs text-slate-600 font-normal mt-0.5">
                  Road 11, Gulshan-1, Dhaka-1212
                </p>
                <span className="text-[11px] text-slate-400 font-normal block mt-1">
                  {isBangla ? "কোনো রিভিউ নেই" : "No reviews"}
                </span>
              </div>
              <div className="flex items-center gap-1.5 shrink-0 pt-0.5">
                {/* External link button */}
                <a
                  href="https://maps.google.com/?q=Concord+Tower,+Road+11,+Gulshan-1,+Dhaka"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-8 h-8 rounded-full bg-blue-50/80 hover:bg-blue-100 text-[#0066FF] flex items-center justify-center transition-colors border border-blue-100"
                  title={isBangla ? "গুগল ম্যাপে খুলুন" : "Open in Google Maps"}
                >
                  <ExternalLink className="w-4 h-4" />
                </a>
                {/* Google Maps Direction Diamond Button */}
                <a
                  href="https://www.google.com/maps/dir/?api=1&destination=Concord+Tower+Road+11+Gulshan-1+Dhaka"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-8 h-8 rounded-full bg-[#1A73E8] hover:bg-[#1557B0] text-white flex items-center justify-center transition-transform hover:scale-105 shadow-sm"
                  title={isBangla ? "দিকনির্দেশনা পান" : "Get Directions"}
                >
                  <svg
                    className="w-4 h-4 fill-current"
                    viewBox="0 0 24 24"
                  >
                    <path d="M21.71 11.29l-9-9a.996.996 0 0 0-1.41 0l-9 9a.996.996 0 0 0 0 1.41l9 9c.39.39 1.02.39 1.41 0l9-9a.996.996 0 0 0 0-1.41zm-9.71 6.3l-7.59-7.59 7.59-7.59 7.59 7.59-7.59 7.59zm1-8.59V6.5l3.5 3.5-3.5 3.5v-2.5h-3v-3h3z"/>
                  </svg>
                </a>
              </div>
            </div>

            <div className="pt-2 border-t border-slate-100 flex items-center justify-between text-[11px] text-slate-500">
              <span className="font-medium text-slate-600">
                {isBangla ? "লেভেল ৭, রোড ১১" : "Level 7, Road 11"}
              </span>
              <span className="font-bold text-emerald-600 font-mono">● Active Desk</span>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
