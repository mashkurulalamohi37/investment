"use client";

import React from "react";
import Link from "next/link";
import { ShieldCheck, Building2, MapPin, Phone, Mail, FileText, CheckCircle2 } from "lucide-react";
import { useAuth } from "@/lib/auth/AuthContext";

export default function Footer() {
  const { isBangla } = useAuth();

  return (
    <footer className="bg-brand-darkest text-slate-300 border-t border-slate-800">
      {/* Top Escrow & Compliance Highlight Banner */}
      <div className="border-b border-slate-800/80 bg-brand-primary/40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-lg bg-jade/10 text-jade flex items-center justify-center shrink-0 border border-jade/20">
                <ShieldCheck className="w-5 h-5" />
              </div>
              <div>
                <h4 className="text-white text-sm font-semibold">
                  {isBangla ? "নিষ্কণ্টক জমি ও শতভাগ স্বচ্ছতা" : "100% Asset-Backed Title Deeds"}
                </h4>
                <p className="text-xs text-slate-400">
                  {isBangla ? "সাব-রেজিস্ট্রি দলিল ও খারিজ খতিয়ানযুক্ত" : "Vetted Sub-Registry Deed #4982/2026"}
                </p>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-lg bg-gold/10 text-gold flex items-center justify-center shrink-0 border border-gold/20">
                <Building2 className="w-5 h-5" />
              </div>
              <div>
                <h4 className="text-white text-sm font-semibold">
                  {isBangla ? "অফিসিয়াল ব্যাংক এসক্রো অ্যাকাউন্ট" : "City Bank PLC Escrow Clearing"}
                </h4>
                <p className="text-xs text-slate-400">
                  {isBangla ? "হিসাব: ১৪০২-৯৯৮৮-৭৭১০-১" : "A/C: 1402-9988-7710-1 (Routing: 225275357)"}
                </p>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-lg bg-blue-500/10 text-blue-400 flex items-center justify-center shrink-0 border border-blue-500/20">
                <CheckCircle2 className="w-5 h-5" />
              </div>
              <div>
                <h4 className="text-white text-sm font-semibold">
                  {isBangla ? "ডিজিটাল শেয়ার সনদ ও লভ্যাংশ" : "Sequential Lots & Pro-Rata Dividend"}
                </h4>
                <p className="text-xs text-slate-400">
                  {isBangla ? "SHA-256 হ্যাশযুক্ত ডিজিটাল সনদ" : "Cryptographic Digital Certificate Issuance"}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Footer Links */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10">
          {/* Brand Info */}
          <div className="lg:col-span-2 space-y-4">
            <Link href="/" className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-gradient-gold flex items-center justify-center font-bold text-slate-950 text-lg">
                SJ
              </div>
              <div>
                <span className="text-xl font-bold text-white tracking-tight">
                  {isBangla ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট" : "Swapnojatri Investment"}
                </span>
              </div>
            </Link>
            <p className="text-sm text-slate-400 leading-relaxed pr-6">
              {isBangla
                ? "স্বপ্নযাত্রী বাংলাদেশে অ্যাসেট-ব্যাকড ভূমি ও আধুনিক কৃষি প্রকল্পে সাধারণ বিনিয়োগকারীদের জন্য একটি নির্ভরযোগ্য, শরীয়াহ-সম্মত ও আধুনিক ক্রাউডফান্ডিং প্ল্যাটফর্ম।"
                : "Swapnojatri is an institutional asset-backed crowdfunding platform democratizing land and agricultural investments in Bangladesh through legal deeds and transparent fund tracking."}
            </p>
            <div className="pt-2 text-xs text-slate-500">
              Trade License: <span className="text-slate-400 font-mono">TRAD/DNCC/049182/2026</span> • TIN: <span className="text-slate-400 font-mono">718294019283</span>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="text-white text-sm font-bold uppercase tracking-wider mb-4">
              {isBangla ? "প্রকল্প ও প্ল্যাটফর্ম" : "Projects"}
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/projects/landvest-100" className="hover:text-gold transition-colors">
                  LandVest 100 (Savar)
                </Link>
              </li>
              <li>
                <Link href="/projects" className="hover:text-gold transition-colors">
                  {isBangla ? "সকল প্রকল্প" : "Project Catalog"}
                </Link>
              </li>
              <li>
                <Link href="/how-it-works" className="hover:text-gold transition-colors">
                  {isBangla ? "বিনিয়োগ কার্যপদ্ধতি" : "How It Works"}
                </Link>
              </li>
              <li>
                <Link href="/documents" className="hover:text-gold transition-colors">
                  {isBangla ? "দলিল ও সনদপত্র" : "Legal Document Vault"}
                </Link>
              </li>
            </ul>
          </div>

          {/* Institutional & Legal */}
          <div>
            <h3 className="text-white text-sm font-bold uppercase tracking-wider mb-4">
              {isBangla ? "আইনি ও স্বচ্ছতা" : "Transparency"}
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/about" className="hover:text-gold transition-colors">
                  {isBangla ? "আমাদের সম্পর্কে" : "About Swapnojatri"}
                </Link>
              </li>
              <li>
                <Link href="/faq" className="hover:text-gold transition-colors">
                  {isBangla ? "সাধারণ প্রশ্নোত্তর" : "FAQ & Disclosures"}
                </Link>
              </li>
              <li>
                <Link href="/documents" className="hover:text-gold transition-colors">
                  {isBangla ? "আইনি মতামত রিপোর্ট" : "Legal Vetting Report"}
                </Link>
              </li>
              <li>
                <Link href="/contact" className="hover:text-gold transition-colors">
                  {isBangla ? "এসক্রো ব্যাংক তথ্য" : "Bank Details & Escrow"}
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact Details */}
          <div>
            <h3 className="text-white text-sm font-bold uppercase tracking-wider mb-4">
              {isBangla ? "যোগাযোগ ও ঠিকানা" : "Contact"}
            </h3>
            <ul className="space-y-3 text-xs text-slate-400">
              <li className="flex items-start gap-2.5">
                <MapPin className="w-4 h-4 text-gold shrink-0 mt-0.5" />
                <span>Level 7, Concord Tower, Road 11, Gulshan-1, Dhaka-1212</span>
              </li>
              <li className="flex items-center gap-2.5">
                <Phone className="w-4 h-4 text-gold shrink-0" />
                <span>+880 1712-345678 / +880 1819-998877</span>
              </li>
              <li className="flex items-center gap-2.5">
                <Mail className="w-4 h-4 text-gold shrink-0" />
                <span>invest@swapnojatri.com</span>
              </li>
            </ul>
          </div>
        </div>

        {/* Bottom Disclaimer & Copyright */}
        <div className="mt-12 pt-8 border-t border-slate-800 text-xs text-slate-500 flex flex-col md:flex-row items-center justify-between gap-4">
          <p>
            © 2026 Swapnojatri Platform. All rights reserved. Land investments involve market risks without guaranteed profit claims.
          </p>
          <div className="flex gap-6">
            <Link href="/faq" className="hover:text-slate-300">
              Risk Disclosure
            </Link>
            <Link href="/documents" className="hover:text-slate-300">
              Terms & Conditions
            </Link>
            <Link href="/contact" className="hover:text-slate-300">
              Privacy Policy
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
