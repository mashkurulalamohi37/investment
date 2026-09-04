"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { Headphones, Phone, Mail, MessageSquare, Send, CheckCircle2, ShieldCheck } from "lucide-react";

export default function SupportPage() {
  const { isBangla } = useAuth();
  const [subject, setSubject] = useState("");
  const [message, setMessage] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitted(true);
    setTimeout(() => {
      setSubmitted(false);
      setSubject("");
      setMessage("");
    }, 4000);
  };

  return (
    <div className="max-w-4xl mx-auto space-y-4 sm:space-y-5 py-2">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "২৪/৭ সাপোর্ট ডেস্ক" : "24/7 INVESTOR SUPPORT"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "বিনিয়োগকারী সহায়তা ও হেল্পডেস্ক" : "Investor Support & Helpdesk"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "আপনার যেকোনো প্রশ্ন বা সমস্যার দ্রুত সমাধানে টিকিট তৈরি করুন অথবা সরাসরি যোগাযোগ করুন"
              : "Direct communication with Swapnojatri legal, investment, and finance relations"}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 items-start">
        {/* Support Ticket Form */}
        <div className="md:col-span-7 bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 space-y-4">
          <h2 className="text-sm font-bold text-slate-900 flex items-center gap-2 pb-2.5 border-b border-slate-100">
            <MessageSquare className="w-4 h-4 text-[#0066FF]" />
            <span>{isBangla ? "নতুন সাপোর্ট টিকিট তৈরি করুন" : "Create New Support Ticket"}</span>
          </h2>

          {submitted && (
            <div className="p-3 rounded-xl bg-emerald-50 text-emerald-800 text-xs font-bold flex items-center gap-2 border border-emerald-200">
              <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
              <span>
                {isBangla
                  ? "টিকিট #TCK-2026-891 সফলভাবে তৈরি হয়েছে। আমাদের প্রতিনিধি ২ ঘণ্টার মধ্যে যোগাযোগ করবেন।"
                  : "Ticket #TCK-2026-891 created. Our team will contact you within 2 hours."}
              </span>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-3 text-xs font-semibold">
            <div>
              <label className="text-slate-700 block mb-1">
                {isBangla ? "বিষয় / সমস্যা ক্যাটাগরি" : "Subject / Issue Category"}
              </label>
              <input
                type="text"
                required
                value={subject}
                onChange={(e) => setSubject(e.target.value)}
                placeholder={isBangla ? "যেমন: ল্যান্ডভেস্ট ১০০ শেয়ার দলিল সংক্রান্ত প্রশ্ন" : "e.g. Question regarding LandVest 100 share deed"}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-xs text-slate-900 focus:outline-none focus:border-[#0066FF]"
              />
            </div>

            <div>
              <label className="text-slate-700 block mb-1">
                {isBangla ? "বিস্তারিত বার্তা" : "Detailed Message"}
              </label>
              <textarea
                rows={4}
                required
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                placeholder={isBangla ? "আপনার প্রশ্ন বা সমস্যা বিস্তারিত লিখুন..." : "Write your query or message in detail..."}
                className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-xs text-slate-900 focus:outline-none focus:border-[#0066FF]"
              />
            </div>

            <button
              type="submit"
              className="w-full py-2.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-xs shadow-[#0066FF]/20 flex items-center justify-center gap-2 transition-all cursor-pointer"
            >
              <Send className="w-3.5 h-3.5" />
              <span>{isBangla ? "টিকিট জমা দিন" : "Submit Support Ticket"}</span>
            </button>
          </form>
        </div>

        {/* Quick Contacts */}
        <div className="md:col-span-5 space-y-3">
          <div className="p-4 sm:p-5 rounded-2xl bg-white border border-slate-200 shadow-sm space-y-3.5 text-xs">
            <h3 className="font-bold text-slate-900 text-sm pb-2 border-b border-slate-100">
              {isBangla ? "জরুরি যোগাযোগের নম্বর" : "Direct Contact Lines"}
            </h3>

            <div className="space-y-3 text-slate-600">
              <div className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-lg bg-blue-50 text-[#0066FF] flex items-center justify-center font-bold shrink-0">
                  <Phone className="w-4 h-4" />
                </div>
                <div>
                  <span className="font-bold text-slate-900 block text-xs">
                    {isBangla ? "ইনভেস্টর হেল্পলাইন" : "Investor Hotline"}
                  </span>
                  <span className="font-mono text-slate-600 text-xs font-semibold">+880 1712-345678</span>
                </div>
              </div>

              <div className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-lg bg-emerald-50 text-emerald-700 flex items-center justify-center font-bold shrink-0">
                  <MessageSquare className="w-4 h-4" />
                </div>
                <div>
                  <span className="font-bold text-slate-900 block text-xs">
                    {isBangla ? "অফিসিয়াল হোয়াটসঅ্যাপ" : "WhatsApp Official"}
                  </span>
                  <span className="font-mono text-slate-600 text-xs font-semibold">+880 1819-998877</span>
                </div>
              </div>

              <div className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-lg bg-slate-100 text-slate-700 flex items-center justify-center font-bold shrink-0">
                  <Mail className="w-4 h-4" />
                </div>
                <div>
                  <span className="font-bold text-slate-900 block text-xs">
                    {isBangla ? "সাপোর্ট ইমেইল" : "Support Email"}
                  </span>
                  <span className="font-mono text-slate-600 text-xs">support@swapnojatri.com</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
