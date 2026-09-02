"use client";

import React, { useState } from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { Headphones, Phone, Mail, MessageSquare, Send, CheckCircle2 } from "lucide-react";

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
    <div className="max-w-4xl mx-auto space-y-8 py-4">
      <div className="pb-4 border-b border-slate-200">
        <h1 className="text-2xl sm:text-3xl font-black text-slate-900">
          {isBangla ? "বিনিয়োগকারী সহায়তা ডেস্ক" : "Investor Support Desk"}
        </h1>
        <p className="text-xs text-slate-500">
          {isBangla
            ? "আপনার যেকোনো প্রশ্ন বা সমস্যার দ্রুত সমাধান পেতে টিকিট তৈরি করুন"
            : "Direct communication with Swapnojatri legal & finance relations"}
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-8 items-start">
        {/* Support Ticket Form */}
        <div className="md:col-span-7 bg-white rounded-2xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-6">
          <h2 className="text-base font-bold text-slate-900 flex items-center gap-2">
            <MessageSquare className="w-4 h-4 text-brand-forest" />
            <span>Create New Support Ticket</span>
          </h2>

          {submitted && (
            <div className="p-4 rounded-xl bg-emerald-50 text-emerald-800 text-xs font-bold flex items-center gap-2 border border-emerald-200">
              <CheckCircle2 className="w-4 h-4 text-jade shrink-0" />
              <span>Ticket #TCK-2026-891 created. Our team will contact you within 2 hours.</span>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4 text-xs">
            <div>
              <label className="font-bold text-slate-700 block mb-1">Subject / Issue Category</label>
              <input
                type="text"
                required
                value={subject}
                onChange={(e) => setSubject(e.target.value)}
                placeholder="e.g. Question regarding LandVest 100 share deed"
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none font-medium"
              />
            </div>

            <div>
              <label className="font-bold text-slate-700 block mb-1">Detailed Message</label>
              <textarea
                rows={5}
                required
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                placeholder="Write your query or message in detail..."
                className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 text-sm focus:ring-2 focus:ring-brand-forest focus:outline-none font-medium"
              />
            </div>

            <button
              type="submit"
              className="w-full py-3.5 rounded-xl bg-gradient-emerald text-white font-bold text-sm hover:opacity-95 shadow-md shadow-brand-forest/20 flex items-center justify-center gap-2 transition-all"
            >
              <Send className="w-4 h-4 text-gold" />
              <span>Submit Support Ticket</span>
            </button>
          </form>
        </div>

        {/* Quick Contacts */}
        <div className="md:col-span-5 space-y-4">
          <div className="p-6 rounded-2xl bg-white border border-slate-200 shadow-card space-y-4 text-xs">
            <h3 className="font-bold text-slate-900 text-sm pb-2 border-b border-slate-100">
              Direct Contact Lines
            </h3>

            <div className="space-y-3 text-slate-600">
              <div className="flex items-center gap-3">
                <Phone className="w-4 h-4 text-brand-forest" />
                <div>
                  <span className="font-bold text-slate-900 block">Investor Hotline</span>
                  <span>+880 1712-345678</span>
                </div>
              </div>

              <div className="flex items-center gap-3">
                <MessageSquare className="w-4 h-4 text-jade" />
                <div>
                  <span className="font-bold text-slate-900 block">WhatsApp Official</span>
                  <span>+880 1819-998877</span>
                </div>
              </div>

              <div className="flex items-center gap-3">
                <Mail className="w-4 h-4 text-gold" />
                <div>
                  <span className="font-bold text-slate-900 block">Support Email</span>
                  <span>support@swapnojatri.com</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
