"use client";

import React from "react";
import { useAuth } from "@/lib/auth/AuthContext";
import { Building2, CheckCircle2, TrendingUp, Sparkles, ShieldCheck, HeartHandshake, MapPin } from "lucide-react";

export default function LandVestStoryCard() {
  const { isBangla } = useAuth();

  const pastProjects = [
    {
      name: "স্বপ্ননীড় প্যালেস",
      nameEn: "Shopnoneer Palace",
      spec: "১১ কাঠা জমিতে ১১ তলা বিল্ডিং",
      specEn: "11 Katha Land, 11-Storey Building",
      status: "এখন বসবাস করে (Completed & Handed Over)",
      statusColor: "bg-emerald-100 text-emerald-800 border-emerald-200",
    },
    {
      name: "স্বপ্নডানা",
      nameEn: "Shopnodana",
      spec: "১১.২৭ কাঠা জমিতে ১৩ তলা বিল্ডিং",
      specEn: "11.27 Katha Land, 13-Storey Building",
      status: "৯ তলার ছাদের কাজ চলমান (Under Construction)",
      statusColor: "bg-blue-100 text-blue-800 border-blue-200",
    },
    {
      name: "জল ও জ্যোৎস্না",
      nameEn: "Jol O Jyotsna",
      spec: "১৪ কাঠা জমিতে ১৪ তলা বিল্ডিং",
      specEn: "14 Katha Land, 14-Storey Building",
      status: "পাইলিং-এর কাজ চলমান (Piling in Progress)",
      statusColor: "bg-amber-100 text-amber-800 border-amber-200",
    },
    {
      name: "গ্রীণ টাওয়ার",
      nameEn: "Green Tower",
      spec: "৩০ কাঠা জমিতে ১৬ তলা বিল্ডিং",
      specEn: "30 Katha Land, 16-Storey Building",
      status: "শেয়ার বিক্রি চলছে... (Shares Open)",
      statusColor: "bg-gold-tint text-gold-dark border-gold/30",
    },
  ];

  return (
    <div className="bg-white rounded-3xl border border-slate-200 shadow-cardHover overflow-hidden p-6 sm:p-10 space-y-8">
      {/* Header Banner */}
      <div className="space-y-3 pb-6 border-b border-slate-100">
        <div className="flex flex-wrap items-center gap-2">
          <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-gold/15 text-gold-dark">
            {isBangla ? "আমাদের গল্প ও পটভূমি" : "Our Journey & Purpose"}
          </span>
          <span className="px-3 py-1 rounded-full text-xs font-bold bg-brand-light text-brand-forest">
            {isBangla ? "মুনাফা ভাগাভাগি ভিত্তিক বিনিয়োগ" : "Profit-Sharing Model"}
          </span>
        </div>
        <h2 className="text-2xl sm:text-3xl font-black text-slate-900">
          {isBangla ? "LandVest 100 এর কথা..." : "The Story of LandVest 100..."}
        </h2>
        <p className="text-sm text-slate-600 leading-relaxed max-w-4xl">
          {isBangla
            ? "LandVest 100 মূলত ঢাকায় জমিতে বিনিয়োগ করে মুনাফা ভাগাভাগি করার একটি ছোট পরিসরের উদ্যোগ। আমরা কয়েকজন মিলে ঢাকায় জমিতে বিনিয়োগ নিয়ে কাজ করছি। আমাদের একটি বিশ্বস্ত টিম আছে। আমরা এখন পর্যন্ত ৪টা শেয়ার ভিত্তিক প্রজেক্ট নিয়ে সফলভাবে কাজ করছি:"
            : "LandVest 100 is a dedicated initiative enabling individuals to participate in Dhaka's promising land opportunities and share profits. With our experienced team, we have successfully developed 4 major share-based residential and commercial projects:"}
        </p>
      </div>

      {/* 4 Proven Projects Grid */}
      <div className="space-y-3">
        <div className="flex items-center gap-2 text-xs font-bold text-slate-700">
          <MapPin className="w-4 h-4 text-brand-forest" />
          <span>
            {isBangla
              ? "এই সবগুলো প্রজেক্ট ওয়াশপুরে (বসিলা ব্রীজ পার হয়ে) টাওয়ার রোডে অবস্থিত:"
              : "All projects strategically located at Washpur Tower Road (Crossing Bosila Bridge), Dhaka:"}
          </span>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {pastProjects.map((p, idx) => (
            <div
              key={idx}
              className="p-5 rounded-2xl bg-canvas-light border border-slate-200/90 hover:border-brand-forest/40 transition-all space-y-2"
            >
              <div className="flex items-center justify-between">
                <h4 className="font-bold text-slate-900 text-base flex items-center gap-2">
                  <Building2 className="w-4 h-4 text-brand-forest" />
                  <span>{isBangla ? p.name : p.nameEn}</span>
                </h4>
                <span className={`px-2.5 py-0.5 rounded-full text-[10px] font-bold border ${p.statusColor}`}>
                  {p.status}
                </span>
              </div>
              <p className="text-xs text-slate-600">{isBangla ? p.spec : p.specEn}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Narrative & Profit-Sharing Clarification */}
      <div className="bg-brand-light/60 rounded-2xl p-6 border border-brand-emerald/20 space-y-4 text-sm text-slate-700 leading-relaxed">
        <p>
          {isBangla
            ? "আমাদের অভিজ্ঞতা থেকে মনে হয়েছে, অনেক পরিচিত মানুষ আছেন যারা জমিতে বিনিয়োগ করতে চান বা ঢাকায় বাসস্থান তৈরি করতে চান কিন্তু একা কয়েক লাখ বা কয়েক কোটি টাকা দিয়ে জমি কেনা তাদের পক্ষে সম্ভব হয় না। সেই চিন্তা থেকেই LandVest 100।"
            : "From our ground experience, many people aspire to invest in land or build housing in Dhaka, but purchasing prime land alone requires millions which isn't feasible for everyone. That inspired LandVest 100."}
        </p>
        <p>
          {isBangla
            ? "এখানে পুরো বিনিয়োগকে আমরা ১০০টি ভাগে ভাগ করেছি। প্রতিভাগে একজন বিনিয়োগকারী মোট ২৫,৫০০ টাকা দিয়ে যুক্ত হতে পারবেন। আপনি চাইলে আপনার সামর্থ্য অনুযায়ী ১, ২, ৩ বা ৪ ভাগ—উপলব্ধ থাকা সাপেক্ষে আরও বেশিভাগও নিতে পারবেন।"
            : "Here, total capital is divided into 100 fixed parts. Investors can join with ৳25,500 per part (1, 2, 3, 4 or more parts based on availability) to participate in profit distributions."}
        </p>
        <p className="font-semibold text-brand-forest">
          {isBangla
            ? "আমরা অপরিচিত মানুষের কাছ থেকে বড় আকারে অর্থ সংগ্রহের চিন্তা থেকে এটি শুরু করছি না। বরং পরিচিত ও আমাদের ওপর আস্থা রাখেন—এমন মানুষদের ছোট অঙ্কে একটি বিনিয়োগের সুযোগে যুক্ত করার চিন্তা থেকেই LandVest 100।"
            : "We are not raising capital indiscriminately from strangers. Rather, LandVest 100 is designed for trusted people to participate with small amounts in a transparent profit-sharing model."}
        </p>
        <p className="text-xs text-slate-600">
          {isBangla
            ? "তাই কাউকে চাপ দিয়ে যুক্ত করাও আমাদের উদ্দেশ্য নয়। আপনি আগে পুরো বিষয়টা বুঝবেন, প্রশ্ন করবেন, ঝুঁকিটাও বুঝবেন। তারপর আমাদের পরিকল্পনা ও আমাদের ওপর আস্থা তৈরি হলে নিজের সামর্থ্য অনুযায়ী সিদ্ধান্ত নেবেন।"
            : "Our goal is full transparency without any pressure. Understand the plan, ask questions, evaluate the risks, and invest according to your financial capability once confident."}
        </p>
      </div>

      {/* Core Principle Callout */}
      <div className="p-6 rounded-2xl bg-gradient-emerald text-white text-center space-y-2 relative overflow-hidden shadow-lg shadow-brand-forest/20">
        <p className="text-sm sm:text-base font-bold italic tracking-wide text-gold-light max-w-3xl mx-auto leading-relaxed">
          {isBangla
            ? "“আপনি আমাকে বিশ্বাস করেন বলে বিনিয়োগ করবেন—এটা গুরুত্বপূর্ণ; কিন্তু শুধু বিশ্বাসের কারণে করবেন না। আগে পরিকল্পনাটা বুঝুন, তারপর সিদ্ধান্ত নিন।”"
            : "“Investing because you trust us is important; but do not invest solely on trust. Understand the business plan first, and then make an informed decision.”"}
        </p>
      </div>
    </div>
  );
}
