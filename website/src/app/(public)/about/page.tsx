"use client";

import React from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import { Building2, Scale, Users, Award, CheckCircle2, HeartHandshake, Sprout, TrendingUp } from "lucide-react";
import LandVestStoryCard from "@/components/project/LandVestStoryCard";

export default function AboutPage() {
  const { isBangla } = useAuth();

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-16">
      {/* 1. Mission Header */}
      <div className="text-center max-w-3xl mx-auto space-y-4">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "আমাদের পরিচয় ও লক্ষ্য" : "Our Vision & Mission"}
        </span>
        <h1 className="text-3xl sm:text-5xl font-black text-slate-900 leading-tight">
          {isBangla
            ? "স্বপ্নযাত্রী — বহুমুখী প্রজেক্টে সহজ বিনিয়োগ ও লাভ ভাগাভাগি"
            : "Swapnojatri — Multi-Project Crowdfunding & Profit-Sharing Platform"}
        </h1>
        <p className="text-base text-slate-600 leading-relaxed">
          {isBangla
            ? "স্বপ্নযাত্রী একটি বিশ্বস্ত প্ল্যাটফর্ম যা জমি, স্মার্ট কৃষি এবং উচ্চ সম্ভাবনাময় উদ্যোগে সাধারণ মানুষকে অল্প পুঁজিতে অংশ নেওয়ার সুযোগ দেয়। কোনো প্রজেক্টের ব্যক্তিগত জটিল মালিকানা নয়—ইনভেস্ট করুন এবং প্রজেক্ট থেকে অর্জিত নিট মুনাফা লাভ করুন।"
            : "Swapnojatri enables everyday investors to participate in vetted land, smart agro, and diverse businesses with small amounts. Investors do not take on operational property hassles—you invest capital and share net project profits."}
        </p>
      </div>

      {/* 2. Official Story & Track Record Card */}
      <LandVestStoryCard />

      {/* 3. Core Principles */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div className="p-8 rounded-3xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-2xl bg-brand-light text-brand-forest flex items-center justify-center">
            <Building2 className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "অভিজ্ঞ ও পরীক্ষিত টিম" : "Proven Track Record"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "ঢাকার ওয়াশপুরে স্বপ্ননীড় প্যালেস, স্বপ্নডানা, জল ও জ্যোৎস্না এবং গ্রীণ টাওয়ারের মতো ৪টি বড় শেয়ারভিত্তিক প্রজেক্ট সফলভাবে পরিচালনার বাস্তব অভিজ্ঞতা।"
              : "Hands-on experience delivering 4 large-scale share-based projects in Dhaka: Shopnoneer Palace, Shopnodana, Jol O Jyotsna, and Green Tower."}
          </p>
        </div>

        <div className="p-8 rounded-3xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-2xl bg-emerald-50 text-emerald-700 flex items-center justify-center">
            <Scale className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "শতভাগ মুনাফা ভাগাভাগি" : "Direct Profit-Sharing"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "কোনো ইনভেস্টর কোনো প্রজেক্টের মালিক নন। ইনভেস্টররা তাদের অংশের অনুপাতে প্রজেক্ট থেকে অর্জিত লাভ বা লভ্যাংশ পাবেন।"
              : "Investors do not assume property ownership complexities. Capital is invested to generate returns, distributed proportionally."}
          </p>
        </div>

        <div className="p-8 rounded-3xl bg-white border border-slate-200 shadow-card space-y-4">
          <div className="w-12 h-12 rounded-2xl bg-gold/10 text-gold-dark flex items-center justify-center">
            <Sprout className="w-6 h-6" />
          </div>
          <h3 className="text-xl font-bold text-slate-900">
            {isBangla ? "বহুমুখী ভবিষ্যৎ প্রজেক্ট" : "Multi-Sector Pipeline"}
          </h3>
          <p className="text-sm text-slate-600 leading-relaxed">
            {isBangla
              ? "বর্তমানে LandVest 100 এর পাশাপাশি সামনে আধুনিক কৃষি, ডেইরি এবং অন্যান্য লাভজনক খাতে প্রজেক্ট নিয়ে আসা হবে।"
              : "Beyond LandVest 100, we are rolling out high-yield organic agro cultivation, dairy projects, and commercial business ventures."}
          </p>
        </div>
      </div>
    </div>
  );
}
