"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import InvestmentCalculator from "@/components/project/InvestmentCalculator";
import ShareMatrixGrid from "@/components/project/ShareMatrixGrid";
import TransparencyLedger from "@/components/project/TransparencyLedger";
import LandVestStoryCard from "@/components/project/LandVestStoryCard";
import {
  ShieldCheck,
  Building2,
  TrendingUp,
  ArrowRight,
  CheckCircle2,
  MapPin,
  FileText,
  Users,
  Coins,
  Scale,
  Sparkles,
  Award,
  Sprout,
  Layers,
} from "lucide-react";

export default function HomePage() {
  const { isBangla } = useAuth();

  return (
    <div className="space-y-20 pb-20">
      {/* 1. HERO SECTION */}
      <section className="relative overflow-hidden bg-gradient-emerald text-white pt-16 pb-24 lg:pt-24 lg:pb-32">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(197,155,39,0.15),transparent_50%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_bottom_left,rgba(16,185,129,0.12),transparent_50%)]" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-8 items-center">
            {/* Left Content */}
            <div className="lg:col-span-7 space-y-6 text-center lg:text-left">
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/15 text-xs font-semibold text-gold-light">
                <Sparkles className="w-4 h-4 text-gold" />
                <span>
                  {isBangla
                    ? "স্বপ্নযাত্রী — বহুমুখী প্রজেক্টে সহজ বিনিয়োগ ও মুনাফা বণ্টন প্ল্যাটফর্ম"
                    : "Swapnojatri — Multi-Project Crowdfunding & Profit-Sharing Platform"}
                </span>
              </div>

              <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black tracking-tight leading-[1.15]">
                {isBangla ? (
                  <>
                    পরিকল্পিত প্রজেক্টে বিনিয়োগ। <br />
                    <span className="text-gold-gradient">সরাসরি মুনাফা লাভ।</span>
                  </>
                ) : (
                  <>
                    Invest in High-Value Projects. <br />
                    <span className="text-gold-gradient">Share Tangible Profits.</span>
                  </>
                )}
              </h1>

              <p className="text-base sm:text-lg text-slate-300 max-w-2xl mx-auto lg:mx-0 leading-relaxed font-normal">
                {isBangla
                  ? "স্বপ্নযাত্রী একটি বহুমুখী ইনভেস্টমেন্ট প্ল্যাটফর্ম। জমি, কৃষি ও লাভজনক বিভিন্ন প্রজেক্টে অংশ নিয়ে ঘরে বসেই অর্জিত মুনাফা লাভ করুন। কোনো প্রজেক্টের মালিকানা নয়—সহজ ইনভেস্টমেন্ট ও লাভ ভাগাভাগির নির্ভরযোগ্য মাধ্যম।"
                  : "Swapnojatri enables you to invest in vetted land, smart agro, and high-potential projects to earn distributed profits. Simple, transparent profit-sharing without operational complexities."}
              </p>

              {/* Action Buttons */}
              <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4 pt-2">
                <Link
                  href="/projects/landvest-100"
                  className="w-full sm:w-auto px-8 py-4 rounded-xl bg-gradient-gold text-slate-950 font-bold text-base hover:opacity-95 shadow-goldGlow flex items-center justify-center gap-2 transition-all"
                >
                  <span>{isBangla ? "চলমান LandVest 100 দেখুন" : "Explore LandVest 100"}</span>
                  <ArrowRight className="w-5 h-5 text-slate-950" />
                </Link>

                <Link
                  href="/projects"
                  className="w-full sm:w-auto px-6 py-4 rounded-xl bg-white/10 hover:bg-white/15 border border-white/20 text-white font-semibold text-base transition-all flex items-center justify-center gap-2"
                >
                  <Layers className="w-4 h-4 text-slate-300" />
                  <span>{isBangla ? "সকল প্রজেক্ট" : "All Projects"}</span>
                </Link>
              </div>

              {/* Quick Platform Metrics */}
              <div className="grid grid-cols-3 gap-4 pt-8 border-t border-white/10 max-w-xl mx-auto lg:mx-0">
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-gold font-mono">
                    {isBangla ? "৪টি প্রজেক্ট" : "4 Projects"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "সফল টিম অভিজ্ঞতা" : "Proven Track Record"}
                  </span>
                </div>
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-white font-mono">
                    {isBangla ? "১০০ ভাগ" : "100 Parts"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "LandVest 100 উদ্যোগ" : "LandVest 100"}
                  </span>
                </div>
                <div>
                  <span className="block text-2xl sm:text-3xl font-black text-jade font-mono">
                    {isBangla ? "প্রো-রাটা" : "Pro-Rata"}
                  </span>
                  <span className="text-xs text-slate-400">
                    {isBangla ? "সরাসরি লভ্যাংশ বণ্টন" : "Profit Distribution"}
                  </span>
                </div>
              </div>
            </div>

            {/* Right Calculator */}
            <div className="lg:col-span-5 text-slate-900">
              <InvestmentCalculator />
            </div>
          </div>
        </div>
      </section>

      {/* 2. OFFICIAL LANDVEST 100 STORY & TRACK RECORD */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <LandVestStoryCard />
      </section>

      {/* 3. MULTI-PROJECT PORTFOLIO PREVIEW */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div>
            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
              {isBangla ? "বহুমুখী উদ্যোগ" : "Diverse Project Spectrum"}
            </span>
            <h2 className="text-2xl sm:text-3xl font-black text-slate-900 mt-1">
              {isBangla ? "স্বপ্নযাত্রীর বর্তমান ও আসন্ন প্রজেক্টসমূহ" : "Current & Upcoming Investment Projects"}
            </h2>
          </div>
          <Link href="/projects" className="text-xs font-bold text-brand-forest hover:underline flex items-center gap-1">
            <span>{isBangla ? "সকল প্রজেক্ট ক্যাটালগ" : "View All Projects"}</span>
            <ArrowRight className="w-3.5 h-3.5" />
          </Link>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Project 1: LandVest 100 */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5 flex flex-col justify-between">
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="px-2.5 py-0.5 rounded text-xs font-mono font-bold bg-gold/15 text-gold-dark">
                  LV100 • CURRENT PROJECT
                </span>
                <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                  OPEN (74% BOOKED)
                </span>
              </div>
              <h3 className="text-xl font-bold text-slate-900">
                {isBangla ? "LandVest 100 (ওয়াশপুর টাওয়ার রোড, ঢাকা)" : "LandVest 100 (Washpur, Dhaka)"}
              </h3>
              <p className="text-xs text-slate-500 flex items-center gap-1.5">
                <MapPin className="w-3.5 h-3.5 text-brand-forest shrink-0" />
                <span>{isBangla ? "ওয়াশপুর (বসিলা ব্রীজ পার হয়ে) টাওয়ার রোড, ঢাকা" : "Washpur Tower Road, Bosila Bridge, Dhaka"}</span>
              </p>
              <p className="text-xs text-slate-600 leading-relaxed">
                {isBangla
                  ? "ঢাকায় জমিতে বিনিয়োগ করে মুনাফা ভাগাভাগি করার ১০০টি ভাগের উদ্যোগ। প্রতিভাগ মাত্র ২৫,৫০০ টাকা।"
                  : "Dhaka land investment profit-sharing initiative divided into 100 fixed parts of ৳25,500 each."}
              </p>
            </div>

            <div className="pt-4 border-t border-slate-100 flex items-center justify-between">
              <span className="font-mono font-black text-brand-forest text-sm">৳ ২৫,৫০০ / ভাগ</span>
              <Link
                href="/projects/landvest-100"
                className="px-4 py-2 rounded-xl bg-brand-forest text-white text-xs font-bold hover:bg-brand-primary"
              >
                {isBangla ? "বিস্তারিত দেখুন" : "View Details"}
              </Link>
            </div>
          </div>

          {/* Project 2: Smart Agro Farming (Upcoming) */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-card p-6 sm:p-8 space-y-5 flex flex-col justify-between">
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="px-2.5 py-0.5 rounded text-xs font-mono font-bold bg-emerald-100 text-emerald-800">
                  AGRO-01 • UPCOMING
                </span>
                <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-blue-100 text-blue-800">
                  COMING SOON
                </span>
              </div>
              <h3 className="text-xl font-bold text-slate-900 flex items-center gap-2">
                <Sprout className="w-5 h-5 text-jade" />
                <span>{isBangla ? "স্বপ্নযাত্রী স্মার্ট কৃষি ও ডেইরি প্রজেক্ট" : "Swapnojatri Smart Agro Farm"}</span>
              </h3>
              <p className="text-xs text-slate-500 flex items-center gap-1.5">
                <MapPin className="w-3.5 h-3.5 text-brand-forest shrink-0" />
                <span>{isBangla ? "সিংগাইর এগ্রো বেল্ট, মানিকগঞ্জ (ঢাকা সংলগ্ন)" : "Singair Agro Belt, Manikganj"}</span>
              </p>
              <p className="text-xs text-slate-600 leading-relaxed">
                {isBangla
                  ? "উচ্চ ফলনশীল আধুনিক গ্রিনহাউস ও সমন্বিত পশুপালন প্রকল্প। প্রতি সিজনে সরাসরি বিনিয়োগকারীদের মুনাফা বণ্টন।"
                  : "Modern greenhouse organic agro cultivation with seasonal profit payouts to participating investors."}
              </p>
            </div>

            <div className="pt-4 border-t border-slate-100 flex items-center justify-between">
              <span className="font-mono font-bold text-slate-500 text-xs">আসন্ন প্রজেক্ট</span>
              <span className="text-xs font-bold text-brand-forest">Pre-Registration Open</span>
            </div>
          </div>
        </div>
      </section>

      {/* 4. 10x10 SHARE MATRIX MAP */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ShareMatrixGrid />
      </section>

      {/* 5. TRANSPARENCY & FUND UTILIZATION LEDGER */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <TransparencyLedger />
      </section>

      {/* 6. CALL TO ACTION BANNER */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="rounded-3xl bg-gradient-emerald text-white p-8 sm:p-14 text-center space-y-6 shadow-2xl shadow-brand-forest/30">
          <div className="max-w-2xl mx-auto space-y-4">
            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-gold/20 text-gold-light border border-gold/30">
              {isBangla ? "আগে পরিকল্পনা বুঝুন, তারপর সিদ্ধান্ত নিন" : "Understand First, Then Invest"}
            </span>
            <h2 className="text-3xl sm:text-4xl font-black text-white">
              {isBangla ? "স্বপ্নযাত্রীর সাথে আপনার আর্থিক যাত্রায় যুক্ত হোন" : "Join the Swapnojatri Profit-Sharing Journey"}
            </h2>
            <p className="text-sm text-slate-300">
              {isBangla
                ? "কোনো জটিলতা ছাড়া সাধ্য অনুযায়ী ছোট অঙ্কে বিভিন্ন সম্ভাবনাময় প্রজেক্টে যুক্ত হয়ে মুনাফা লাভ করুন।"
                : "Invest small, participate in proven projects, and receive regular profit distributions directly."}
            </p>
          </div>

          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-2">
            <Link
              href="/register"
              className="w-full sm:w-auto px-8 py-4 rounded-xl bg-gradient-gold text-slate-950 font-bold text-base hover:opacity-95 shadow-goldGlow transition-all"
            >
              {isBangla ? "বিনিয়োগকারী অ্যাকাউন্ট খুলুন" : "Create Investor Account"}
            </Link>
            <Link
              href="/projects/landvest-100"
              className="w-full sm:w-auto px-8 py-4 rounded-xl bg-white/10 hover:bg-white/15 border border-white/20 text-white font-semibold text-base transition-all"
            >
              {isBangla ? "LandVest 100 পরিকল্পনা দেখুন" : "View LandVest 100 Details"}
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
