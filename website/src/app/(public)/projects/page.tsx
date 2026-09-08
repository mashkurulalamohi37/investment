"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { SWAPNOJATRI_PROJECTS } from "@/lib/api/projects";
import { MapPin, ArrowRight, ShieldCheck, CheckCircle2, Sparkles, Layers, Sprout } from "lucide-react";

export default function ProjectsCatalogPage() {
  const { isBangla } = useAuth();
  const [filter, setFilter] = useState<"ALL" | "REAL_ESTATE" | "AGRICULTURAL">("ALL");

  const projects = SWAPNOJATRI_PROJECTS;

  const filteredProjects = filter === "ALL" ? projects : projects.filter((p) => p.category === filter);

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-10 space-y-8">
      {/* 1. Compact Header Banner */}
      <div className="text-center max-w-3xl mx-auto space-y-3">
        <div className="inline-flex items-center gap-1.5 px-3.5 py-1 rounded-full text-xs font-extrabold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-100 shadow-2xs">
          <Layers className="w-3.5 h-3.5" />
          <span>{isBangla ? "প্রকল্প সম্ভার" : "Asset-Backed Opportunities"}</span>
        </div>
        <h1 className="text-3xl sm:text-4xl font-black text-[#0A2540] tracking-tight">
          {isBangla ? "স্বচ্ছ লাভজনক প্রকল্পসমূহ" : "Verified Investment Projects"}
        </h1>
        <p className="text-xs sm:text-sm text-slate-600 font-normal max-w-xl mx-auto leading-relaxed">
          {isBangla
            ? "১০০টি নির্দিষ্ট শেয়ারে বিভক্ত জমি ও কৃষি প্রকল্প। সরাসরি ব্যাংক এসক্রো সুরক্ষায় অর্জিত নিট মুনাফা অর্জন করুন।"
            : "Explore vetted real estate and agro-ventures structured in 100 fixed parts with City Bank escrow protection."}
        </p>
      </div>

      {/* 2. Compact Filter Navigation Pills */}
      <div className="flex flex-wrap items-center justify-center gap-2">
        <button
          onClick={() => setFilter("ALL")}
          className={`px-4 py-2 rounded-full text-xs font-extrabold transition-all cursor-pointer ${
            filter === "ALL"
              ? "bg-[#0066FF] text-white shadow-md shadow-[#0066FF]/25"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? "সকল প্রজেক্ট" : "All Projects"} ({projects.length})
        </button>
        <button
          onClick={() => setFilter("REAL_ESTATE")}
          className={`px-4 py-2 rounded-full text-xs font-extrabold transition-all cursor-pointer ${
            filter === "REAL_ESTATE"
              ? "bg-[#0066FF] text-white shadow-md shadow-[#0066FF]/25"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? "🏢 জমি ও আবাসন" : "🏢 Real Estate"}
        </button>
        <button
          onClick={() => setFilter("AGRICULTURAL")}
          className={`px-4 py-2 rounded-full text-xs font-extrabold transition-all cursor-pointer ${
            filter === "AGRICULTURAL"
              ? "bg-[#0066FF] text-white shadow-md shadow-[#0066FF]/25"
              : "bg-white text-slate-600 border border-slate-200 hover:bg-slate-50"
          }`}
        >
          {isBangla ? "🌱 স্মার্ট কৃষি ও ডেইরি" : "🌱 Smart Agro & Dairy"}
        </button>
      </div>

      {/* 3. Compact & Calibrated Projects Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredProjects.map((proj) => {
          const isLandVest = proj.code === "LV100" || proj.id === "proj-lv100";
          const progressPercent = Math.round((proj.allocated_shares / proj.total_shares) * 100);
          const projectSlug = isLandVest ? "landvest-100" : proj.code;

          return (
            <div
              key={proj.id}
              className={`bg-white rounded-3xl border transition-all flex flex-col justify-between overflow-hidden group hover:shadow-cardHover ${
                isLandVest
                  ? "border-[#0066FF]/30 shadow-card ring-1 ring-[#0066FF]/15"
                  : "border-slate-200/90 shadow-card"
              }`}
            >
              {/* Card Top & Badges */}
              <div className="p-6 space-y-4">
                <div className="flex items-center justify-between gap-2">
                  <span className="px-3 py-1 rounded-full text-[10px] font-extrabold tracking-wider uppercase bg-blue-50 text-[#0066FF] border border-blue-100">
                    {proj.code}
                  </span>
                  <span
                    className={`px-3 py-0.5 rounded-full text-[10px] font-extrabold flex items-center gap-1.5 border ${
                      proj.status === "OPEN"
                        ? "bg-emerald-50 text-emerald-800 border-emerald-200"
                        : "bg-slate-100 text-slate-600 border-slate-200"
                    }`}
                  >
                    <span
                      className={`w-1.5 h-1.5 rounded-full ${
                        proj.status === "OPEN" ? "bg-emerald-500 animate-pulse" : "bg-slate-400"
                      }`}
                    />
                    <span>{proj.status === "OPEN" ? (isBangla ? "চলমান" : "OPEN") : isBangla ? "আসন্ন" : "UPCOMING"}</span>
                  </span>
                </div>

                <div>
                  <h3 className="text-lg font-black text-[#0A2540] group-hover:text-[#0066FF] transition-colors">
                    {isBangla ? proj.name_bn : proj.name}
                  </h3>
                  <p className="text-xs text-slate-500 flex items-center gap-1.5 mt-1 font-normal">
                    <MapPin className="w-3.5 h-3.5 text-[#0066FF] shrink-0" />
                    <span className="truncate">{isBangla ? proj.location_bn : proj.location}</span>
                  </p>
                </div>

                <p className="text-xs text-slate-600 leading-relaxed line-clamp-2 font-normal">
                  {isBangla ? proj.description_bn : proj.description}
                </p>

                {/* Pricing & ROI 2-Col Box */}
                <div className="grid grid-cols-2 gap-2.5 p-3.5 rounded-2xl bg-[#F8FAFC] border border-slate-200/80 text-xs">
                  <div>
                    <span className="text-[10px] text-slate-400 font-bold uppercase font-mono block">
                      {isBangla ? "প্রতি শেয়ার" : "Per Share"}
                    </span>
                    <span className="font-black text-[#0066FF] text-sm font-mono block mt-0.5">
                      {formatBDT(proj.price_per_share, { isBangla })}
                    </span>
                  </div>
                  <div>
                    <span className="text-[10px] text-slate-400 font-bold uppercase font-mono block">
                      {isBangla ? "প্রত্যাশিত ROI" : "Est. Return"}
                    </span>
                    <span className="font-black text-emerald-700 text-sm font-mono block mt-0.5">
                      {proj.projected_roi_min}% - {proj.projected_roi_max}%
                    </span>
                  </div>
                </div>

                {/* Share Progress Bar */}
                <div className="space-y-1.5">
                  <div className="flex items-center justify-between text-[11px] font-bold text-slate-700">
                    <span>
                      {isBangla
                        ? `${proj.allocated_shares} / ${proj.total_shares} ভাগ বরাদ্দ`
                        : `${proj.allocated_shares} / ${proj.total_shares} Shares Allocated`}
                    </span>
                    <span className="text-[#0066FF] font-mono">{progressPercent}%</span>
                  </div>
                  <div className="h-2 rounded-full bg-slate-100 overflow-hidden">
                    <div
                      className="h-full bg-gradient-to-r from-[#0066FF] to-[#00B4D8] rounded-full transition-all duration-700"
                      style={{ width: `${progressPercent}%` }}
                    />
                  </div>
                </div>
              </div>

              {/* Bottom Action Footer */}
              <div className="p-4 sm:px-6 bg-slate-50/70 border-t border-slate-100 flex items-center justify-between">
                <span className="text-[11px] font-mono text-slate-500 font-semibold">
                  {isBangla ? "এসক্রো পার্টনার: দ্য সিটি ব্যাংক" : "Escrow: The City Bank"}
                </span>

                <Link
                  href={`/projects/${projectSlug}`}
                  className="px-4 py-2 rounded-full bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-extrabold flex items-center gap-1.5 shadow-xs transition-all group-hover:shadow-md"
                >
                  <span>{isBangla ? "বিস্তারিত দেখুন" : "View Details"}</span>
                  <ArrowRight className="w-3.5 h-3.5 text-[#00B4D8]" />
                </Link>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
