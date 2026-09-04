"use client";

import React from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  Building2,
  CheckCircle2,
  TrendingUp,
  ShieldCheck,
  MapPin,
  Sparkles,
  Layers,
  Coins,
  ArrowUpRight,
  Quote,
} from "lucide-react";

export default function LandVestStoryCard() {
  const { isBangla } = useAuth();

  const pastProjects = [
    {
      name: isBangla ? "স্বপ্ননীড় প্যালেস" : "Shopnoneer Palace",
      location: isBangla ? "ওয়াশপুর, ঢাকা" : "Washpur, Dhaka",
      katha: isBangla ? "১১ কাঠা" : "11 Katha",
      storey: isBangla ? "১১ তলা" : "11-Storey",
      status: isBangla ? "হস্তান্তরিত ও বসবাসরত" : "Handed Over",
      badgeClass: "bg-emerald-500/10 text-emerald-700 border-emerald-500/20",
      dotClass: "bg-emerald-500",
    },
    {
      name: isBangla ? "স্বপ্নডানা" : "Shopnodana",
      location: isBangla ? "ওয়াশপুর, ঢাকা" : "Washpur, Dhaka",
      katha: isBangla ? "১১.২৭ কাঠা" : "11.27 Katha",
      storey: isBangla ? "১৩ তলা" : "13-Storey",
      status: isBangla ? "নির্মাণাধীন (৯ম তলা)" : "9th Floor Roof",
      badgeClass: "bg-blue-500/10 text-[#0066FF] border-blue-500/20",
      dotClass: "bg-[#0066FF]",
    },
    {
      name: isBangla ? "জল ও জ্যোৎস্না" : "Jol O Jyotsna",
      location: isBangla ? "ওয়াশপুর, ঢাকা" : "Washpur, Dhaka",
      katha: isBangla ? "১৪ কাঠা" : "14 Katha",
      storey: isBangla ? "১৪ তলা" : "14-Storey",
      status: isBangla ? "পাইলিং কাজ চলমান" : "Piling in Progress",
      badgeClass: "bg-amber-500/10 text-amber-700 border-amber-500/20",
      dotClass: "bg-amber-500",
    },
    {
      name: isBangla ? "গ্রীণ টাওয়ার" : "Green Tower",
      location: isBangla ? "ওয়াশপুর, ঢাকা" : "Washpur, Dhaka",
      katha: isBangla ? "৩০ কাঠা" : "30 Katha",
      storey: isBangla ? "১৬ তলা" : "16-Storey",
      status: isBangla ? "শেয়ার বুকিং উন্মুক্ত" : "Shares Open",
      badgeClass: "bg-cyan-500/10 text-cyan-700 border-cyan-500/20",
      dotClass: "bg-[#00B4D8]",
    },
  ];

  return (
    <div className="bg-white rounded-3xl border border-slate-200/90 shadow-card overflow-hidden">
      {/* 1. Executive Prospectus Header */}
      <div className="p-8 sm:p-12 border-b border-slate-100 bg-gradient-to-b from-[#F8FAFC] to-white space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div className="flex items-center gap-2">
            <span className="px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100">
              {isBangla ? "পটভূমি ও প্রেক্ষাপট" : "Background & Vision"}
            </span>
            <span className="px-3.5 py-1 rounded-full text-xs font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
              {isBangla ? "১০০% প্রফিট-শেয়ারিং" : "Transparent Profit-Sharing"}
            </span>
          </div>

          <div className="flex items-center gap-1.5 text-xs text-slate-500 font-mono">
            <MapPin className="w-3.5 h-3.5 text-[#0066FF]" />
            <span>Washpur Tower Road, Bosila, Dhaka</span>
          </div>
        </div>

        <h2 className="text-2xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "ল্যান্ডভেস্ট ১০০ এর পেছনের লক্ষ্য ও প্রেক্ষাপট" : "The Vision & Philosophy of LandVest 100"}
        </h2>

        <p className="text-sm sm:text-base text-slate-600 leading-relaxed max-w-4xl font-normal">
          {isBangla
            ? "ঢাকায় সম্ভাবনাময় জমিতে এককভাবে কোটি টাকা ছাড়া বিনিয়োগ করা সাধারণ মানুষের পক্ষে দুঃসাধ্য। এই সীমাবদ্ধতা দূর করতেই LandVest 100—যেখানে মোট জমি ও উন্নয়নকে ১০০টি নির্দিষ্ট ভাগে ভাগ করে প্রতিটি ভাগে ২৫,৫০০ টাকায় আংশিক মালিকানা ও সরাসরি নিট মুনাফা অর্জনের সুযোগ সৃষ্টি করা হয়েছে।"
            : "Purchasing prime land in Dhaka traditionally requires millions, keeping it out of reach for individual investors. LandVest 100 removes this barrier by dividing the project into 100 fixed parts at ৳25,500 each for proportional net profit sharing."}
        </p>
      </div>

      {/* 2. Track Record Showcase (4 Delivered / Active Projects) */}
      <div className="p-8 sm:p-12 border-b border-slate-100 space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
          <div>
            <h3 className="text-lg font-extrabold text-[#0A2540]">
              {isBangla ? "আমাদের সফল ও চলমান প্রকল্পসমূহ" : "Our Track Record & Ongoing Developments"}
            </h3>
            <p className="text-xs text-slate-500">
              {isBangla ? "ওয়াশপুর ও বসিলা অঞ্চলে স্বপ্নযাত্রী টিমের সফল বাস্তবায়ন" : "Delivered and active residential projects by Swapnojatri team"}
            </p>
          </div>
          <span className="text-xs font-mono font-bold text-[#0066FF] bg-blue-50 px-3 py-1 rounded-full border border-blue-100 self-start sm:self-auto">
            {isBangla ? "৪টি মেগা প্রকল্প" : "4 Mega Projects"}
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {pastProjects.map((p, idx) => (
            <div
              key={idx}
              className="p-5 rounded-2xl bg-white border border-slate-200/90 hover:border-[#0066FF]/50 hover:shadow-lg transition-all space-y-4 flex flex-col justify-between group"
            >
              <div className="space-y-2">
                <div className="flex items-center justify-between">
                  <div className="w-10 h-10 rounded-xl bg-slate-50 group-hover:bg-blue-50 text-[#0066FF] flex items-center justify-center transition-colors">
                    <Building2 className="w-5 h-5" />
                  </div>
                  <span className={`px-2.5 py-0.5 rounded-full text-[10px] font-extrabold border flex items-center gap-1.5 ${p.badgeClass}`}>
                    <span className={`w-1.5 h-1.5 rounded-full ${p.dotClass}`} />
                    <span>{p.status}</span>
                  </span>
                </div>

                <div>
                  <h4 className="font-extrabold text-[#0A2540] text-base group-hover:text-[#0066FF] transition-colors">
                    {p.name}
                  </h4>
                  <span className="text-xs text-slate-400 font-medium">{p.location}</span>
                </div>
              </div>

              <div className="pt-3 border-t border-slate-100 flex items-center justify-between text-xs font-mono font-bold text-slate-700">
                <span>{p.katha}</span>
                <span className="text-slate-300">•</span>
                <span>{p.storey}</span>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* 3. Mathematical Profit-Sharing Formula Bar */}
      <div className="p-8 sm:p-12 border-b border-slate-100 bg-[#F8FAFC] space-y-6">
        <h3 className="text-base font-extrabold text-[#0A2540] text-center">
          {isBangla ? "স্বচ্ছ ফান্ডিং কাঠামো ও প্রো-রাটা লভ্যাংশ নীতি" : "Transparent Funding Structure & Pro-Rata Math"}
        </h3>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 max-w-4xl mx-auto">
          <div className="p-5 rounded-2xl bg-white border border-slate-200/80 shadow-2xs text-center space-y-1">
            <span className="text-xs text-slate-400 font-bold uppercase font-mono">
              {isBangla ? "স্থির শেয়ার সংখ্যা" : "Fixed Total Shares"}
            </span>
            <p className="text-2xl font-black text-[#0A2540] font-mono">
              {isBangla ? "১০০ টি ভাগ" : "100 Units"}
            </p>
            <span className="text-[11px] text-slate-500 font-medium block">
              {isBangla ? "কোনো অতিরিক্ত শেয়ার তৈরি হবে না" : "Hard cap of exactly 100 units"}
            </span>
          </div>

          <div className="p-5 rounded-2xl bg-white border border-slate-200/80 shadow-2xs text-center space-y-1">
            <span className="text-xs text-slate-400 font-bold uppercase font-mono">
              {isBangla ? "ইউনিট মূল্য" : "Unit Share Price"}
            </span>
            <p className="text-2xl font-black text-[#0066FF] font-mono">
              {isBangla ? "৳ ২৫,৫০০" : "৳ 25,500"}
            </p>
            <span className="text-[11px] text-slate-500 font-medium block">
              {isBangla ? "১ থেকে সর্বোচ্চ ৪টি শেয়ার সীমা" : "Investor limit: 1 to 4 units"}
            </span>
          </div>

          <div className="p-5 rounded-2xl bg-white border border-slate-200/80 shadow-2xs text-center space-y-1">
            <span className="text-xs text-slate-400 font-bold uppercase font-mono">
              {isBangla ? "লভ্যাংশ বণ্টন" : "Profit Payout"}
            </span>
            <p className="text-2xl font-black text-emerald-700 font-mono">
              {isBangla ? "প্রো-রাটা" : "Pro-Rata"}
            </p>
            <span className="text-[11px] text-slate-500 font-medium block">
              {isBangla ? "সিটি ব্যাংক এসক্রো থেকে সরাসরি ব্যাংক জমা" : "Direct payout to verified bank account"}
            </span>
          </div>
        </div>
      </div>

      {/* 4. Core Principle Quote Card */}
      <div className="p-8 sm:p-12 bg-gradient-to-br from-[#0A2540] to-[#041628] text-white text-center relative overflow-hidden space-y-3">
        <Quote className="w-8 h-8 text-[#00B4D8]/30 mx-auto" />
        <p className="text-sm sm:text-lg font-bold italic text-cyan-light max-w-3xl mx-auto leading-relaxed">
          {isBangla
            ? "“আপনি আমাদের বিশ্বাস করেন বলে বিনিয়োগ করবেন—এটা আনন্দের; কিন্তু শুধু বিশ্বাসের ওপর ভিত্তি করে নয়, আগে আমাদের প্রাতিষ্ঠানিক পরিকল্পনা, ব্যাংক এসক্রো ও অডিট ভাউচার খতিয়ান বুঝুন, তারপর যুক্ত হোন।”"
            : "“Investing based on trust is valued; but do not invest solely on trust. Understand our institutional structure, escrow safety, and audited ledger first.”"}
        </p>
        <span className="text-[11px] font-mono tracking-wider text-slate-400 uppercase block pt-2">
          Swapnojatri Investment Platform Ltd • Institutional Transparency
        </span>
      </div>
    </div>
  );
}
