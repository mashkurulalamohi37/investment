"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { FALLBACK_LANDVEST_100 } from "@/lib/api/projects";
import InvestmentCalculator from "@/components/project/InvestmentCalculator";
import ShareMatrixGrid from "@/components/project/ShareMatrixGrid";
import TransparencyLedger from "@/components/project/TransparencyLedger";
import LandVestStoryCard from "@/components/project/LandVestStoryCard";
import {
  MapPin,
  Building2,
  Calendar,
  CheckCircle2,
  ArrowRight,
  TrendingUp,
  Sparkles,
  Layers,
  Coins,
  ShieldCheck,
} from "lucide-react";

export default function LandVest100Page() {
  const { isBangla, isAuthenticated } = useAuth();
  const project = FALLBACK_LANDVEST_100;

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12 space-y-12">
      {/* 1. Project Title & Breadcrumb Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-xs font-semibold text-slate-500">
          <Link href="/projects" className="hover:text-brand-emerald">
            {isBangla ? "প্রকল্প সম্ভার" : "Projects"}
          </Link>
          <span>/</span>
          <span className="text-brand-emerald font-bold">LandVest 100 (LV100)</span>
        </div>

        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-6 pb-6 border-b border-slate-200">
          <div className="space-y-2.5">
            <div className="flex flex-wrap items-center gap-2">
              <span className="px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-brand-light text-brand-emerald">
                {isBangla ? "জমি ও আবাসন উদ্যোগ" : "Land & Real Estate Initiative"}
              </span>
              <span className="px-3.5 py-1 rounded-full text-xs font-bold font-mono bg-emerald-50 text-emerald-800 border border-emerald-200 flex items-center gap-1.5">
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                {isBangla ? "৭৪% শেয়ার সাবস্ক্রাইবড" : "STATUS: OPEN (74% ALLOCATED)"}
              </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-extrabold text-slate-900 tracking-tight">
              {isBangla ? project.name_bn : project.name}
            </h1>
            <p className="text-xs sm:text-sm text-slate-500 flex items-center gap-2 font-normal">
              <MapPin className="w-4 h-4 text-brand-emerald shrink-0" />
              <span>{isBangla ? project.location_bn : project.location}</span>
            </p>
          </div>

          <div className="flex items-center gap-3 shrink-0">
            <Link
              href={isAuthenticated ? `/dashboard/investments/new` : `/login?redirect=/dashboard/investments/new`}
              className="px-7 py-3.5 rounded-full bg-brand-emerald hover:bg-brand-forest text-white text-xs sm:text-sm font-extrabold shadow-lg shadow-brand-emerald/30 flex items-center gap-2 transition-all group"
            >
              <span>{isBangla ? "শেয়ার বুক করুন" : "Invest in Shares"}</span>
              <ArrowRight className="w-4 h-4 text-cyan-light transition-transform group-hover:translate-x-1" />
            </Link>
          </div>
        </div>
      </div>

      {/* 2. Official Story & Track Record Card */}
      <LandVestStoryCard />

      {/* 3. Key Financial Specifications & Calculator */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        {/* Left Project Specs */}
        <div className="lg:col-span-7 space-y-6">
          <div className="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-6 shadow-card">
            <h2 className="text-base sm:text-lg font-extrabold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
              <Layers className="w-5 h-5 text-brand-emerald" />
              <span>{isBangla ? "ইনভেস্টমেন্ট কাঠামো ও শর্তাবলী" : "Investment Structure & Participation"}</span>
            </h2>

            <div className="grid grid-cols-2 sm:grid-cols-3 gap-3.5 text-xs">
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "মোট ভাগ" : "Total Project Parts"}
                </span>
                <span className="text-sm font-extrabold text-slate-900">
                  {isBangla ? "১০০টি নির্দিষ্ট ভাগ" : "Fixed 100 Units"}
                </span>
              </div>
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "প্রতি ভাগের মূল্য" : "Price Per Unit"}
                </span>
                <span className="text-sm font-black text-brand-emerald font-mono">
                  {isBangla ? "৳ ২৫,৫০০" : "৳ 25,500"}
                </span>
              </div>
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "অংশগ্রহণ সীমা" : "Investor Ceiling"}
                </span>
                <span className="text-sm font-extrabold text-slate-900">
                  {isBangla ? "১ থেকে ৪টি ভাগ" : "1 to 4 Shares"}
                </span>
              </div>
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "মালিকানা নীতি" : "Ownership Structure"}
                </span>
                <span className="text-sm font-extrabold text-emerald-700">
                  {isBangla ? "প্রো-রাটা লভ্যাংশ" : "Pro-Rata Returns"}
                </span>
              </div>
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "প্রকল্পের অবস্থান" : "Project Location"}
                </span>
                <span className="text-sm font-extrabold text-slate-900">
                  {isBangla ? "ওয়াশপুর টাওয়ার রোড" : "Washpur Tower Road"}
                </span>
              </div>
              <div className="p-4 rounded-2xl bg-slate-50 border border-slate-200/90 space-y-1">
                <span className="text-[11px] text-slate-400 block font-normal">
                  {isBangla ? "বর্তমান স্ট্যাটাস" : "Subscription Status"}
                </span>
                <span className="text-sm font-extrabold text-brand-emerald">
                  {isBangla ? "৭৪টি ভাগ বুকড" : "74 Units Booked"}
                </span>
              </div>
            </div>
          </div>

          {/* Timeline Milestones */}
          <div className="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-6 shadow-card">
            <h3 className="text-base sm:text-lg font-extrabold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
              <Calendar className="w-5 h-5 text-brand-emerald" />
              <span>{isBangla ? "পরিকল্পনা ও অগ্রগতি" : "Execution Milestones"}</span>
            </h3>

            <div className="space-y-6 pl-2">
              {project.milestones.map((m, idx) => (
                <div key={m.id} className="relative flex items-start gap-4">
                  <div
                    className={`w-8 h-8 rounded-full flex items-center justify-center font-bold text-xs shrink-0 ${
                      m.is_completed
                        ? "bg-emerald-500 text-white shadow-sm shadow-emerald-500/30"
                        : "bg-slate-100 text-slate-500 border border-slate-300"
                    }`}
                  >
                    {m.is_completed ? <CheckCircle2 className="w-4 h-4" /> : idx + 1}
                  </div>
                  <div className="space-y-1">
                    <div className="flex items-center gap-2">
                      <h4 className="text-sm font-bold text-slate-900">{isBangla ? m.title_bn : m.title}</h4>
                      {m.is_completed && (
                        <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-800 border border-emerald-200">
                          {isBangla ? "সম্পন্ন" : "COMPLETED"}
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-slate-600 font-normal">
                      {isBangla ? (m as any).description_bn || m.description : m.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Right Sticky Calculator */}
        <div className="lg:col-span-5 sticky top-24">
          <InvestmentCalculator />
        </div>
      </div>

      {/* 4. Live Share Allocation Progress Matrix */}
      <section>
        <ShareMatrixGrid />
      </section>

      {/* 5. Live Transparency Ledger & Audited Vouchers */}
      <section>
        <TransparencyLedger />
      </section>
    </div>
  );
}
