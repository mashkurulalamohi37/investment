"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { FALLBACK_LANDVEST_100 } from "@/lib/api/projects";
import { MapPin, ArrowRight, ShieldCheck, CheckCircle2 } from "lucide-react";

export default function ProjectsCatalogPage() {
  const { isBangla } = useAuth();
  const [filter, setFilter] = useState<"ALL" | "REAL_ESTATE" | "AGRICULTURAL">("ALL");

  const projects = [
    FALLBACK_LANDVEST_100,
    {
      id: "proj-agro-season-01",
      code: "AGRO-S1",
      name: "Smart Organic Agro Farming (Season 1)",
      name_bn: "স্মার্ট অর্গানিক এগ্রো ফার্মিং (সিজন ১)",
      category: "AGRICULTURAL" as const,
      location: "Singair Agro Belt, Manikganj",
      location_bn: "সিংগাইর এগ্রো বেল্ট, মানিকগঞ্জ",
      description: "High-yield organic vegetable and modern greenhouse farming project with quarterly profit distributions.",
      description_bn: "উচ্চ ফলনশীল জৈব সবজি ও আধুনিক গ্রিনহাউস চাষাবাদ প্রকল্প। ৩ মাস পর পর লভ্যাংশ বণ্টন।",
      target_fund: 1500000,
      price_per_share: 15000,
      total_shares: 100,
      allocated_shares: 42,
      available_shares: 58,
      min_shares: 1,
      max_shares: 5,
      status: "OPEN" as const,
      projected_roi_min: 20.0,
      projected_roi_max: 24.5,
      milestones: [],
    },
  ];

  const filteredProjects = filter === "ALL" ? projects : projects.filter((p) => p.category === filter);

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-10">
      {/* Title */}
      <div className="text-center max-w-2xl mx-auto space-y-3">
        <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
          {isBangla ? "প্রকল্প সম্ভার" : "Asset-Backed Opportunities"}
        </span>
        <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
          {isBangla ? "বিনিয়োগ প্রকল্পসমূহ" : "Investment Projects Catalog"}
        </h1>
        <p className="text-sm text-slate-600">
          {isBangla
            ? "নিবন্ধিত মূল দলিল ও শতভাগ স্বচ্ছ অডিট রিপোর্টযুক্ত সক্রিয় ভূমি ও কৃষি প্রকল্পসমূহ"
            : "Explore vetted freehold land and agro opportunities with transparent escrow security"}
        </p>
      </div>

      {/* Filter Tabs */}
      <div className="flex justify-center gap-2">
        {[
          { id: "ALL", label: isBangla ? "সকল প্রকল্প" : "All Projects" },
          { id: "REAL_ESTATE", label: isBangla ? "রিয়েল এস্টেট ভূমি" : "Real Estate Land" },
          { id: "AGRICULTURAL", label: isBangla ? "স্মার্ট কৃষি" : "Smart Agro Farming" },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setFilter(tab.id as any)}
            className={`px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold transition-all ${
              filter === tab.id
                ? "bg-brand-forest text-white shadow-sm"
                : "bg-white text-slate-600 hover:bg-slate-100 border border-slate-200"
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Projects Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        {filteredProjects.map((p) => (
          <div
            key={p.id}
            className="bg-white rounded-2xl border border-slate-200 shadow-card hover:shadow-cardHover transition-all overflow-hidden flex flex-col justify-between"
          >
            <div className="p-6 sm:p-8 space-y-4">
              <div className="flex items-center justify-between">
                <span className="px-2.5 py-1 rounded-md text-xs font-mono font-bold bg-brand-light text-brand-forest">
                  {p.code}
                </span>
                <span className="inline-flex items-center gap-1 text-xs font-bold text-emerald-800 bg-emerald-100 px-2.5 py-0.5 rounded-full">
                  <CheckCircle2 className="w-3.5 h-3.5" />
                  {p.status}
                </span>
              </div>

              <h2 className="text-xl font-bold text-slate-900">{isBangla ? p.name_bn : p.name}</h2>
              <p className="text-xs text-slate-500 flex items-center gap-1.5">
                <MapPin className="w-3.5 h-3.5 text-brand-forest shrink-0" />
                <span>{isBangla ? p.location_bn : p.location}</span>
              </p>
              <p className="text-xs text-slate-600 leading-relaxed line-clamp-2">
                {isBangla ? p.description_bn : p.description}
              </p>

              {/* Progress Bar */}
              <div className="space-y-1.5 pt-2">
                <div className="flex justify-between text-xs font-semibold">
                  <span className="text-slate-600">
                    {isBangla ? `বরাদ্দ: ${p.allocated_shares}/${p.total_shares} শেয়ার` : `Allocated: ${p.allocated_shares}/${p.total_shares} Shares`}
                  </span>
                  <span className="text-brand-forest font-mono">{((p.allocated_shares / p.total_shares) * 100).toFixed(0)}%</span>
                </div>
                <div className="h-2 rounded-full bg-slate-100 overflow-hidden">
                  <div
                    className="h-full bg-gradient-emerald rounded-full"
                    style={{ width: `${(p.allocated_shares / p.total_shares) * 100}%` }}
                  />
                </div>
              </div>

              {/* Metrics */}
              <div className="grid grid-cols-2 gap-3 pt-3 border-t border-slate-100 text-xs">
                <div>
                  <span className="text-slate-400 block">{isBangla ? "প্রতি শেয়ার মূল্য" : "Price Per Share"}</span>
                  <span className="font-bold text-slate-900 font-mono text-sm">
                    {formatBDT(p.price_per_share, { isBangla })}
                  </span>
                </div>
                <div>
                  <span className="text-slate-400 block">{isBangla ? "টার্গেট ফান্ড" : "Target Fund"}</span>
                  <span className="font-bold text-slate-900 font-mono text-sm">
                    {formatBDT(p.target_fund, { isBangla })}
                  </span>
                </div>
              </div>
            </div>

            <div className="p-4 sm:px-8 sm:py-4 bg-slate-50 border-t border-slate-100 flex items-center justify-between">
              <span className="text-xs text-jade-dark font-bold">
                {p.projected_roi_min}% - {p.projected_roi_max}% {isBangla ? "প্রত্যাশিত ROI" : "Projected ROI"}
              </span>
              <Link
                href={`/projects/${p.code === "LV100" ? "landvest-100" : p.id}`}
                className="px-4 py-2 rounded-xl bg-brand-forest text-white text-xs font-bold hover:bg-brand-primary transition-all flex items-center gap-1.5"
              >
                <span>{isBangla ? "বিস্তারিত দেখুন" : "View Details"}</span>
                <ArrowRight className="w-3.5 h-3.5 text-gold" />
              </Link>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
