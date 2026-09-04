"use client";

import React from "react";
import Link from "next/link";
import { ShieldCheck, Building2, MapPin, Phone, Mail, FileText, CheckCircle2, Award, Sparkles } from "lucide-react";
import { useAuth } from "@/lib/auth/AuthContext";

export default function Footer() {
  const { isBangla } = useAuth();

  return (
    <footer className="bg-[#030914] text-slate-300 border-t border-slate-800/80">
      {/* Main Footer Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-10">
          {/* Brand Info (5 cols) */}
          <div className="lg:col-span-4 space-y-4">
            <Link href="/" className="flex items-center gap-3 group">
              <div className="w-10 h-10 shrink-0">
                <img
                  src="/swapnojatri_logo.svg"
                  alt="স্বপ্নযাত্রী"
                  className="w-full h-full object-contain filter drop-shadow"
                />
              </div>
              <div className="flex flex-col">
                <span className="text-xl font-extrabold text-white tracking-tight">
                  {isBangla ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট" : "Swapnojatri Investment"}
                </span>
                <span className="text-[10px] text-cyan-light font-bold uppercase tracking-wider">
                  {isBangla ? "সহজ ও নির্ভরযোগ্য প্রফিট-শেয়ারিং" : "Smart Multi-Project Crowdfunding"}
                </span>
              </div>
            </Link>

            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-normal pr-4">
              {isBangla
                ? "স্বপ্নযাত্রী ঢাকায় জমি, আধুনিক কৃষি ও লাভজনক বাণিজ্যিক উদ্যোগে সাধারণ মানুষকে অল্প পুঁজিতে অংশ নিয়ে সরাসরি অর্জিত নিট মুনাফা লাভের নির্ভরযোগ্য মাধ্যম।"
                : "Swapnojatri enables everyday investors to participate in vetted prime land, smart agro, and commercial businesses with small amounts to earn distributed net profits."}
            </p>

            <div className="pt-2 text-xs text-slate-400 font-mono space-y-1">
              <div>
                <span className="text-slate-500">DNCC Trade Reg:</span>{" "}
                <span className="text-slate-200">TRAD/DNCC/049182/2026</span>
              </div>
              <div>
                <span className="text-slate-500">Corporate TIN:</span>{" "}
                <span className="text-slate-200">718294019283</span>
              </div>
            </div>
          </div>

          {/* Quick Links (2.5 cols) */}
          <div className="lg:col-span-3 space-y-4">
            <h3 className="text-white text-xs sm:text-sm font-bold uppercase tracking-wider flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-cyan" />
              <span>{isBangla ? "বিনিয়োগ প্রকল্পসমূহ" : "Investment Projects"}</span>
            </h3>
            <ul className="space-y-3 text-xs sm:text-sm text-slate-300 font-medium">
              <li>
                <Link href="/projects/landvest-100" className="hover:text-cyan transition-colors flex items-center gap-1.5">
                  <span>{isBangla ? "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)" : "LandVest 100 (Washpur)"}</span>
                  <span className="px-1.5 py-0.2 rounded text-[9px] bg-cyan-tint text-cyan-dark font-mono font-bold">
                    {isBangla ? "লাইভ" : "LIVE"}
                  </span>
                </Link>
              </li>
              <li>
                <Link href="/projects" className="hover:text-cyan transition-colors">
                  {isBangla ? "সকল প্রজেক্ট সম্ভার" : "Explore Project Spectrum"}
                </Link>
              </li>
              <li>
                <Link href="/how-it-works" className="hover:text-cyan transition-colors">
                  {isBangla ? "বিনিয়োগ ও বণ্টন কার্যপদ্ধতি" : "How Crowdfunding Works"}
                </Link>
              </li>
              <li>
                <Link href="/documents" className="hover:text-cyan transition-colors">
                  {isBangla ? "যাচাইকৃত অডিট ও ভল্ট" : "Cryptographic Audit Vault"}
                </Link>
              </li>
            </ul>
          </div>

          {/* Institutional (2.5 cols) */}
          <div className="lg:col-span-2 space-y-4">
            <h3 className="text-white text-xs sm:text-sm font-bold uppercase tracking-wider flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-brand-emerald" />
              <span>{isBangla ? "প্রতিষ্ঠান ও ট্রাস্ট" : "Trust & Company"}</span>
            </h3>
            <ul className="space-y-3 text-xs sm:text-sm text-slate-300 font-medium">
              <li>
                <Link href="/about" className="hover:text-cyan transition-colors">
                  {isBangla ? "আমাদের গল্প ও উদ্দেশ্য" : "The LandVest Story"}
                </Link>
              </li>
              <li>
                <Link href="/faq" className="hover:text-cyan transition-colors">
                  {isBangla ? "সাধারণ প্রশ্নোত্তর (FAQ)" : "FAQ & Clarifications"}
                </Link>
              </li>
              <li>
                <Link href="/contact" className="hover:text-cyan transition-colors">
                  {isBangla ? "সিটি ব্যাংক এসক্রো হিসাব" : "City Bank Escrow Safety"}
                </Link>
              </li>
              <li>
                <Link href="/login" className="hover:text-cyan transition-colors">
                  {isBangla ? "বিনিয়োগকারী ড্যাশবোর্ড" : "Investor Portal Login"}
                </Link>
              </li>
              <li>
                <Link href="/admin" className="text-cyan-light hover:text-white transition-colors flex items-center gap-1 font-semibold">
                  <span>{isBangla ? "অ্যাডমিন কন্ট্রোল সেন্টার" : "Admin Console"}</span>
                  <span className="text-[10px] px-1.5 py-0.2 rounded bg-white/10 text-cyan">PRO</span>
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact Details (3 cols) */}
          <div className="lg:col-span-3 space-y-4">
            <h3 className="text-white text-xs sm:text-sm font-bold uppercase tracking-wider flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400" />
              <span>{isBangla ? "যোগাযোগ ও প্রধান কার্যালয়" : "Contact & Offices"}</span>
            </h3>
            <ul className="space-y-3.5 text-xs text-slate-300">
              <li className="flex items-start gap-2.5">
                <MapPin className="w-4 h-4 text-cyan shrink-0 mt-0.5" />
                <span className="leading-relaxed">
                  {isBangla
                    ? "লেভেল ৭, কনকর্ড টাওয়ার, রোড ১১, গুলশান-১, ঢাকা-১২১২"
                    : "Level 7, Concord Tower, Road 11, Gulshan-1, Dhaka-1212"}
                </span>
              </li>
              <li className="flex items-center gap-2.5">
                <Phone className="w-4 h-4 text-cyan shrink-0" />
                <span className="font-mono text-white font-bold">+880 1712-345678</span>
              </li>
              <li className="flex items-center gap-2.5">
                <Mail className="w-4 h-4 text-cyan shrink-0" />
                <span className="font-mono text-slate-200">invest@swapnojatri.com</span>
              </li>
              <li className="flex items-center gap-2.5 pt-1 text-[11px] text-slate-400">
                <Building2 className="w-4 h-4 text-emerald-400 shrink-0" />
                <span>{isBangla ? "এসক্রো পার্টনার: দ্য সিটি ব্যাংক পিএলসি" : "Escrow Custodian: The City Bank PLC"}</span>
              </li>
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="pt-8 mt-12 border-t border-slate-800/80 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-slate-400">
          <div>
            {isBangla
              ? `© ২০২৬ স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম লিমিটেড। সর্বস্বত্ব সংরক্ষিত।`
              : `© ${new Date().getFullYear()} Swapnojatri Investment Platform Ltd. All rights reserved.`}
          </div>
          <div className="flex items-center gap-2 text-emerald-400 font-semibold text-xs">
            <ShieldCheck className="w-4 h-4 text-emerald-400 shrink-0" />
            <span>
              {isBangla
                ? "১০০% দ্য সিটি ব্যাংক পিএলসি এসক্রো একাউন্টে সুরক্ষিত"
                : "100% Secured with The City Bank PLC Escrow"}
            </span>
          </div>
        </div>
      </div>
    </footer>
  );
}
