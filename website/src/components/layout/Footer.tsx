"use client";

import React from "react";
import Link from "next/link";
import { ShieldCheck, Building2, MapPin, Phone, Mail, FileText, CheckCircle2 } from "lucide-react";
import { useAuth } from "@/lib/auth/AuthContext";

export default function Footer() {
  const { isBangla } = useAuth();

  return (
    <footer className="bg-brand-darkest text-slate-300 border-t border-slate-800">
      {/* Main Footer Links */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10">
          {/* Brand Info */}
          <div className="lg:col-span-2 space-y-4">
            <Link href="/" className="flex items-center gap-3">
              <div className="w-12 h-12 shrink-0">
                <img src="/swapnojatri_logo.svg" alt="স্বপ্নযাত্রী" className="w-full h-full object-contain filter drop-shadow" />
              </div>
              <div className="flex flex-col">
                <span className="text-xl font-bold text-white tracking-tight">
                  {isBangla ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট" : "Swapnojatri Investment"}
                </span>
                <span className="text-[10px] text-sky-400 font-bold uppercase tracking-widest">
                  {isBangla ? "সহজ ও বিশ্বস্ত প্রফিট শেয়ারিং" : "Smart Profit-Sharing"}
                </span>
              </div>
            </Link>
            <p className="text-sm text-slate-400 leading-relaxed pr-6">
              {isBangla
                ? "স্বপ্নযাত্রী ঢাকায় জমি, আধুনিক কৃষি ও লাভজনক বিভিন্ন প্রজেক্টে সাধারণ মানুষকে অল্প পুঁজিতে অংশ নিয়ে সরাসরি মুনাফা অর্জনের নির্ভরযোগ্য মাধ্যম।"
                : "Swapnojatri enables everyday investors to participate in vetted land, smart agro, and diverse businesses with small amounts to earn distributed net profits."}
            </p>
            <div className="pt-2 text-xs text-slate-500">
              Registration: <span className="text-slate-400 font-mono">TRAD/DNCC/049182/2026</span> • TIN: <span className="text-slate-400 font-mono">718294019283</span>
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="text-white text-sm font-bold uppercase tracking-wider mb-4">
              {isBangla ? "প্রকল্পসমূহ" : "Projects"}
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/projects/landvest-100" className="hover:text-gold transition-colors">
                  LandVest 100 (Washpur)
                </Link>
              </li>
              <li>
                <Link href="/projects" className="hover:text-gold transition-colors">
                  {isBangla ? "সকল প্রজেক্ট" : "Project Spectrum"}
                </Link>
              </li>
              <li>
                <Link href="/how-it-works" className="hover:text-gold transition-colors">
                  {isBangla ? "কার্যপদ্ধতি" : "How It Works"}
                </Link>
              </li>
            </ul>
          </div>

          {/* Institutional */}
          <div>
            <h3 className="text-white text-sm font-bold uppercase tracking-wider mb-4">
              {isBangla ? "আমাদের সম্পর্কে" : "Our Story"}
            </h3>
            <ul className="space-y-2.5 text-sm">
              <li>
                <Link href="/about" className="hover:text-gold transition-colors">
                  {isBangla ? "LandVest 100 এর কথা" : "The Story Behind"}
                </Link>
              </li>
              <li>
                <Link href="/faq" className="hover:text-gold transition-colors">
                  {isBangla ? "সাধারণ প্রশ্নোত্তর" : "FAQ"}
                </Link>
              </li>
              <li>
                <Link href="/contact" className="hover:text-gold transition-colors">
                  {isBangla ? "ব্যাংক ও অফিস তথ্য" : "Bank & Contacts"}
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

        {/* Bottom Disclaimer */}
        <div className="mt-12 pt-8 border-t border-slate-800 text-xs text-slate-500 flex flex-col md:flex-row items-center justify-between gap-4">
          <p>
            © 2026 Swapnojatri Platform. All rights reserved. “আগে পরিকল্পনাটা বুঝুন, তারপর সিদ্ধান্ত নিন।”
          </p>
          <div className="flex gap-6">
            <Link href="/faq" className="hover:text-slate-300">FAQ</Link>
            <Link href="/contact" className="hover:text-slate-300">Contact</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
