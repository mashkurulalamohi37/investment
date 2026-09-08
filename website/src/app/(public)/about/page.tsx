"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  AboutPageCmsConfig,
  AboutImageItem,
  DEFAULT_ABOUT_CMS,
} from "@/types/cms";
import {
  Building2,
  ShieldCheck,
  TrendingUp,
  HeartHandshake,
  ArrowRight,
  Sparkles,
  MapPin,
  CheckCircle2,
  Layers,
  Coins,
  Camera,
  Eye,
  X,
  ExternalLink,
} from "lucide-react";

export default function AboutPage() {
  const { isBangla } = useAuth();

  // Dynamic CMS state
  const [cmsConfig, setCmsConfig] = useState<AboutPageCmsConfig>(DEFAULT_ABOUT_CMS);
  const [activePreview, setActivePreview] = useState<AboutImageItem | null>(null);

  // Fetch CMS config from API / LocalStorage
  useEffect(() => {
    async function fetchCms() {
      try {
        const res = await fetch("/api/cms/about");
        const json = await res.json();
        if (json.success && json.data) {
          setCmsConfig(json.data);
          localStorage.setItem("swapnojatri_about_cms", JSON.stringify(json.data));
        } else {
          const cached = localStorage.getItem("swapnojatri_about_cms");
          if (cached) setCmsConfig(JSON.parse(cached));
        }
      } catch (err) {
        const cached = localStorage.getItem("swapnojatri_about_cms");
        if (cached) setCmsConfig(JSON.parse(cached));
      }
    }
    fetchCms();
  }, []);

  const principles = [
    {
      title: isBangla ? "১০০টি নির্দিষ্ট শেয়ার" : "Fixed 100 Shares",
      desc: isBangla
        ? "প্রতিটি প্রজেক্টে শেয়ার সংখ্যা কঠোরভাবে ১০০টিতে সীমাবদ্ধ, যা সমতা ও অতিরিক্ত ইস্যু প্রতিরোধ নিশ্চিত করে।"
        : "Strict hard cap of 100 shares per project preventing dilution and concentration.",
      icon: Layers,
    },
    {
      title: isBangla ? "সিটি ব্যাংক এসক্রো নিরাপত্তা" : "City Bank Escrow Safety",
      desc: isBangla
        ? "সকল বিনিয়োগ তহবিল অডিটকৃত অনুমোদন ছাড়া উত্তোলনযোগ্য নয়, যা ১০০% ট্রাস্ট ও সুরক্ষা দেয়।"
        : "Funds are legally held in The City Bank PLC Escrow with audited disbursements.",
      icon: ShieldCheck,
    },
    {
      title: isBangla ? "১০০% লাইভ অডিট ভাউচার" : "100% Live Audited Ledger",
      desc: isBangla
        ? "সংগৃহীত তহবিলের প্রতিটি খরচ ও পেমেন্টের ভাউচার লাইভ লেজারে দৃশ্যমান।"
        : "Every single taka deployed is documented with live audited vouchers.",
      icon: TrendingUp,
    },
    {
      title: isBangla ? "গাণিতিক প্রো-রাটা মুনাফা" : "Mathematical Pro-Rata Returns",
      desc: isBangla
        ? "অর্জিত নিট মুনাফা শেয়ারের অনুপাতে স্বয়ংক্রিয়ভাবে সরাসরি ব্যাংক অ্যাকাউন্টে জমা হয়।"
        : "Realized net profits are automatically distributed pro-rata to bank accounts.",
      icon: Coins,
    },
  ];

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-12">
      {/* 1. Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <Sparkles className="w-3.5 h-3.5" />
          <span>{isBangla ? "আমাদের গল্প ও দর্শন" : "Our Story & Vision"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "স্বচ্ছ ও নির্ভরযোগ্য যৌথ উদ্যোগ" : "Transparent Fractional Co-Ownership"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম সাধারণ মানুষকে ক্ষুদ্র পুঁজিতে ঢাকার লাভজনক জমি ও বাণিজ্যিক উদ্যোগে অংশীদারিত্বের সুযোগ তৈরি করে।"
            : "Swapnojatri democratizes access to high-value Dhaka land and commercial agriculture through fractional profit-sharing."}
        </p>
      </div>

      {/* 2. 4-Pillar Trust Bento Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
        {principles.map((p, idx) => {
          const Icon = p.icon;
          return (
            <div
              key={idx}
              className="p-6 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover transition-all space-y-3 flex flex-col justify-between"
            >
              <div className="space-y-3">
                <div className="w-10 h-10 rounded-2xl bg-blue-50 text-[#0066FF] flex items-center justify-center shadow-2xs">
                  <Icon className="w-5 h-5" />
                </div>
                <h3 className="font-extrabold text-[#0A2540] text-sm sm:text-base">
                  {p.title}
                </h3>
                <p className="text-xs text-slate-600 leading-relaxed font-normal">
                  {p.desc}
                </p>
              </div>

              <div className="pt-2 text-[11px] font-mono text-emerald-700 flex items-center gap-1 font-bold">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                <span>{isBangla ? "যাচাইকৃত ভিত্তি" : "Verified Pillar"}</span>
              </div>
            </div>
          );
        })}
      </div>

      {/* 3. Featured Story & Narrative (Split Grid with CMS Hero Visual) */}
      <div className="bg-white rounded-3xl border border-slate-200/90 shadow-sm p-6 sm:p-8 lg:p-10">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-10 items-center">
          {/* Narrative Column */}
          <div className="lg:col-span-7 space-y-4 text-xs sm:text-sm text-slate-700 leading-relaxed font-normal">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-emerald-50 text-emerald-700 border border-emerald-200/80">
              <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
              <span>{isBangla ? "আমাদের মূল বিশ্বাস ও উদ্দেশ্য" : "Our Core Philosophy"}</span>
            </div>

            <h2 className="text-xl sm:text-2xl lg:text-3xl font-black text-[#0A2540] tracking-tight leading-snug">
              {isBangla
                ? "আস্থা ও বন্ধুত্বের মেলবন্ধনে ক্ষুদ্র পুঁজিতে বড় অ্যাসেটের মালিকানা"
                : "Real Asset-Backed Co-Investment Built on Fiduciary Trust"}
            </h2>

            <p>
              {isBangla
                ? "আমরা অপরিচিত মানুষের কাছ থেকে বড় আকারে অর্থ সংগ্রহের চিন্তা থেকে এটি শুরু করিনি। বরং পরিচিত ও আমাদের ওপর আস্থা রাখেন—এমন মানুষদের ছোট অঙ্কে একটি নিরাপদ যৌথ বিনিয়োগের সুযোগে যুক্ত করার চিন্তা থেকেই স্বপ্নযাত্রী ও LandVest 100 এর সূচনা।"
                : "Rather than raising capital indiscriminately from strangers, Swapnojatri was born to provide trusted individuals with low-ticket access to asset-backed co-investments."}
            </p>

            <p className="font-bold text-[#0066FF] p-3 rounded-2xl bg-blue-50/60 border border-blue-100">
              {isBangla
                ? "আমাদের লক্ষ্য সম্পূর্ণ স্বচ্ছতা—কোনো লুকায়িত শর্ত নেই। আপনি পরিকল্পনা বুঝবেন, ভাউচার দেখবেন, তারপর সিদ্ধান্ত নেবেন।"
                : "Our goal is absolute fiduciary transparency without hidden clauses. Review our audited ledger, inspect the bank escrow, and invest with confidence."}
            </p>

            {/* Verification checklist bullets */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 pt-2 text-xs font-medium text-slate-600">
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                <span>{isBangla ? "সিটি ব্যাংক এসক্রো ক্লিয়ারিং" : "City Bank Escrow Clearing"}</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                <span>{isBangla ? "২৪/৭ লাইভ অডিট ভাউচার খতিয়ান" : "24/7 Audited Voucher Ledger"}</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                <span>{isBangla ? "১০০ ভাগে নির্দিষ্ট শেয়ার হিসাব" : "Fixed 100 Pro-Rata Fractions"}</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                <span>{isBangla ? "কোনো লুকায়িত কমিশন বা ফি নেই" : "Zero Hidden Fees or Dilution"}</span>
              </div>
            </div>
          </div>

          {/* Featured CMS Hero Image Column */}
          <div className="lg:col-span-5">
            <div className="relative rounded-3xl overflow-hidden border border-slate-200/90 shadow-xl h-72 sm:h-88 lg:h-96 bg-slate-950 group">
              <img
                src={cmsConfig.heroImage.imageUrl || "/images/hero_investment_bg.jpg"}
                alt="Featured Swapnojatri Asset"
                className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-slate-950/90 via-slate-950/20 to-transparent pointer-events-none" />

              {/* Top Badge */}
              <div className="absolute top-3.5 left-3.5 right-3.5 flex items-center justify-between pointer-events-none">
                <span className="px-3 py-1 rounded-full text-[10px] sm:text-xs font-mono font-bold bg-[#040D1A]/85 backdrop-blur-md text-cyan-light border border-white/20 shadow-sm">
                  {isBangla
                    ? cmsConfig.heroImage.badgeBn || cmsConfig.heroImage.badge
                    : cmsConfig.heroImage.badge}
                </span>
                <span className="w-2.5 h-2.5 rounded-full bg-emerald-400 animate-ping" />
              </div>

              {/* Bottom Caption Overlay */}
              <div className="absolute bottom-4 left-4 right-4 space-y-1">
                <div className="flex items-center gap-1.5 text-[11px] font-mono text-cyan-light font-bold">
                  <MapPin className="w-3.5 h-3.5 text-cyan shrink-0" />
                  <span>Washpur & Singair Strategic Belts</span>
                </div>
                <p className="text-xs sm:text-sm text-white font-medium leading-relaxed drop-shadow-md">
                  {isBangla
                    ? cmsConfig.heroImage.captionBn || cmsConfig.heroImage.caption
                    : cmsConfig.heroImage.caption}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* 4. Visual Journey & Ground Reality Gallery (Controlled by CMS) */}
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 pb-3 border-b border-slate-200/80">
          <div className="space-y-1">
            <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-[11px] font-bold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-200/60">
              <Camera className="w-3.5 h-3.5" />
              <span>{isBangla ? "বাস্তব প্রকল্প ও উন্নয়ন চিত্র" : "Ground Reality & Field Album"}</span>
            </div>
            <h2 className="text-xl sm:text-2xl lg:text-3xl font-black text-[#0A2540] tracking-tight">
              {isBangla ? "আমাদের দৃশ্যমান যাত্রা ও সাইট অ্যালবাম" : "Our Visual Journey & Asset Gallery"}
            </h2>
            <p className="text-xs sm:text-sm text-slate-600 max-w-2xl">
              {isBangla
                ? "ক্যামেরার চোখে স্বপ্নযাত্রীর জমি, আধুনিক এগ্রো ও অবকাঠামো উন্নয়নের বাস্তব চিত্র। স্বচ্ছতার অংশ হিসেবে প্রতিটি ফিল্ড ডেভেলপমেন্ট সংরক্ষিত থাকে।"
                : "Real on-site field captures of prime land parcels, agro greenhouse setups, and access roads curated for investor assurance."}
            </p>
          </div>

          <Link
            href="/projects"
            className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full bg-white hover:bg-slate-50 border border-slate-200 text-xs font-bold text-slate-700 hover:text-brand-emerald shadow-2xs transition-all self-start sm:self-auto group cursor-pointer shrink-0"
          >
            <span>{isBangla ? "চলমান প্রকল্পসমূহ দেখুন" : "Explore Projects"}</span>
            <ArrowRight className="w-3.5 h-3.5 text-brand-emerald transition-transform group-hover:translate-x-1" />
          </Link>
        </div>

        {/* Gallery Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
          {cmsConfig.storyImages.map((img) => (
            <div
              key={img.id}
              onClick={() => setActivePreview(img)}
              className="bg-white rounded-2xl border border-slate-200/90 shadow-sm hover:shadow-cardHover hover:-translate-y-1 transition-all duration-300 overflow-hidden flex flex-col justify-between group cursor-pointer"
            >
              {/* Image Frame */}
              <div className="relative h-44 sm:h-48 bg-slate-950 overflow-hidden">
                <img
                  src={img.imageUrl}
                  alt={img.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-slate-950/85 via-slate-950/20 to-transparent" />

                {/* Category Pill */}
                <div className="absolute top-3 left-3">
                  <span className="px-2.5 py-0.5 rounded-full text-[10px] font-mono font-bold uppercase tracking-wider bg-[#040D1A]/85 backdrop-blur-md text-cyan-light border border-white/20">
                    {isBangla ? img.categoryBn || img.category : img.category}
                  </span>
                </div>

                {/* View Icon */}
                <div className="absolute top-3 right-3 opacity-0 group-hover:opacity-100 transition-opacity">
                  <span className="w-7 h-7 rounded-full bg-white/90 text-slate-900 flex items-center justify-center shadow-md">
                    <Eye className="w-3.5 h-3.5 text-[#0066FF]" />
                  </span>
                </div>
              </div>

              {/* Card Body */}
              <div className="p-4 space-y-2 flex-1 flex flex-col justify-between">
                <div className="space-y-1">
                  <h3 className="text-sm sm:text-base font-bold text-slate-900 group-hover:text-[#0066FF] transition-colors leading-snug line-clamp-1">
                    {isBangla ? img.titleBn || img.title : img.title}
                  </h3>
                  <p className="text-xs text-slate-600 font-normal leading-relaxed line-clamp-2">
                    {isBangla ? img.captionBn || img.caption : img.caption}
                  </p>
                </div>

                <div className="pt-2 border-t border-slate-100 flex items-center justify-between text-[11px] font-bold text-[#0066FF]">
                  <span>{isBangla ? "বিস্তারিত দেখুন →" : "View Photo →"}</span>
                  <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* 5. Lightbox Modal Preview */}
      {activePreview && (
        <div
          className="fixed inset-0 z-50 bg-slate-950/80 backdrop-blur-sm flex items-center justify-center p-4"
          onClick={() => setActivePreview(null)}
        >
          <div
            className="bg-white rounded-3xl max-w-2xl w-full border border-slate-200 overflow-hidden shadow-2xl animate-in fade-in zoom-in-95"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Modal Image */}
            <div className="relative h-72 sm:h-96 bg-slate-950">
              <img
                src={activePreview.imageUrl}
                alt={activePreview.title}
                className="w-full h-full object-cover"
              />
              <button
                type="button"
                onClick={() => setActivePreview(null)}
                className="absolute top-3 right-3 w-8 h-8 rounded-full bg-black/60 hover:bg-black/90 text-white flex items-center justify-center transition-all cursor-pointer backdrop-blur-md"
              >
                <X className="w-4 h-4" />
              </button>
              <div className="absolute bottom-3 left-3">
                <span className="px-3 py-1 rounded-full text-xs font-mono font-bold uppercase bg-black/70 backdrop-blur-md text-cyan-light border border-white/20">
                  {isBangla ? activePreview.categoryBn || activePreview.category : activePreview.category}
                </span>
              </div>
            </div>

            {/* Modal Text */}
            <div className="p-6 space-y-2">
              <h3 className="text-lg sm:text-xl font-black text-slate-900">
                {isBangla ? activePreview.titleBn || activePreview.title : activePreview.title}
              </h3>
              <p className="text-xs sm:text-sm text-slate-600 leading-relaxed font-normal">
                {isBangla ? activePreview.captionBn || activePreview.caption : activePreview.caption}
              </p>
            </div>
          </div>
        </div>
      )}

      {/* 6. Closing Trust Ribbon */}
      <div className="p-8 sm:p-10 rounded-3xl bg-[#0A2540] hero-mesh-gradient text-white flex flex-col sm:flex-row items-center justify-between gap-6 shadow-xl border border-slate-800">
        <div className="space-y-2 text-center sm:text-left max-w-xl">
          <span className="px-3 py-0.5 rounded-full text-[10px] font-mono font-bold bg-white/10 text-cyan uppercase tracking-wider border border-white/15">
            VERIFIED CO-OWNERSHIP
          </span>
          <h3 className="text-xl sm:text-2xl font-black text-white">
            {isBangla
              ? "স্বপ্নযাত্রীর সাথে শুরু হোক আপনার নিরাপদ বিনিয়োগ যাত্রা"
              : "Experience Transparent Fractional Asset Ownership"}
          </h3>
          <p className="text-xs text-slate-300 font-normal leading-relaxed">
            {isBangla
              ? "ঢাকার বসিলা ও মানিকগঞ্জ বেল্টে যাচাইকৃত প্রাইম জমি ও এগ্রো প্রকল্পে অংশ নিন।"
              : "Join vetted land and smart agro ventures with bank escrow protection."}
          </p>
        </div>

        <Link
          href="/projects"
          className="px-6 py-3 rounded-full bg-brand-emerald hover:bg-brand-forest text-white font-extrabold text-xs sm:text-sm flex items-center gap-2 shadow-md transition-all shrink-0 cursor-pointer"
        >
          <span>{isBangla ? "সকল প্রকল্প দেখুন" : "View All Projects"}</span>
          <ArrowRight className="w-4 h-4 text-cyan-light" />
        </Link>
      </div>
    </div>
  );
}
