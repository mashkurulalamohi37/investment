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
} from "lucide-react";

export default function LandVest100Page() {
  const { isBangla, isAuthenticated } = useAuth();
  const project = FALLBACK_LANDVEST_100;

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-12">
      {/* 1. Project Title & Breadcrumb Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-xs font-semibold text-slate-500">
          <Link href="/projects" className="hover:text-brand-forest">
            {isBangla ? "প্রকল্প তালিকা" : "Projects"}
          </Link>
          <span>/</span>
          <span className="text-brand-forest">LandVest 100 (LV100)</span>
        </div>

        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-6 pb-6 border-b border-slate-200">
          <div className="space-y-2">
            <div className="flex items-center gap-2">
              <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-brand-light text-brand-forest">
                {isBangla ? "জমি ও আবাসন প্রকল্প" : "Land & Real Estate Initiative"}
              </span>
              <span className="px-3 py-1 rounded-full text-xs font-bold font-mono bg-emerald-100 text-emerald-800">
                STATUS: OPEN (74% ALLOCATED)
              </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-black text-slate-900">
              {isBangla ? project.name_bn : project.name}
            </h1>
            <p className="text-sm text-slate-600 flex items-center gap-2">
              <MapPin className="w-4 h-4 text-brand-forest shrink-0" />
              <span>{isBangla ? project.location_bn : project.location}</span>
            </p>
          </div>

          <div className="flex items-center gap-3">
            <Link
              href={isAuthenticated ? `/dashboard/investments/new` : `/login?redirect=/dashboard/investments/new`}
              className="px-6 py-3.5 rounded-xl bg-gradient-emerald text-white text-sm font-bold hover:opacity-95 shadow-lg shadow-brand-forest/20 flex items-center gap-2 transition-all"
            >
              <span>{isBangla ? "ইনভেস্ট করতে এগিয়ে যান" : "Invest in Parts"}</span>
              <ArrowRight className="w-4 h-4 text-gold" />
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
          <div className="bg-white rounded-3xl border border-slate-200 p-6 sm:p-8 space-y-6 shadow-card">
            <h2 className="text-lg font-bold text-slate-900 border-b border-slate-100 pb-3">
              {isBangla ? "ইনভেস্টমেন্ট কাঠামো ও শর্তাবলী" : "Investment Structure & Participation"}
            </h2>

            <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">মোট ভাগ (Total Parts)</span>
                <span className="text-sm font-bold text-slate-900">১০০টি ভাগ (100 Parts)</span>
              </div>
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">প্রতি ভাগের মূল্য</span>
                <span className="text-sm font-bold text-brand-forest font-mono">৳ ২৫,৫০০</span>
              </div>
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">অংশগ্রহণ সীমা</span>
                <span className="text-sm font-bold text-slate-900">১, ২, ৩, ৪ বা বেশি</span>
              </div>
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">মালিকানা নীতি</span>
                <span className="text-sm font-bold text-emerald-800">মুনাফা ভাগাভাগি</span>
              </div>
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">প্রকল্পের অবস্থান</span>
                <span className="text-sm font-bold text-slate-900">ওয়াশপুর টাওয়ার রোড</span>
              </div>
              <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200/80">
                <span className="text-[11px] text-slate-500 block">বর্তমান স্ট্যাটাস</span>
                <span className="text-sm font-bold text-slate-900">৭৪টি ভাগ বুকড</span>
              </div>
            </div>
          </div>

          {/* Timeline Milestones */}
          <div className="bg-white rounded-3xl border border-slate-200 p-6 sm:p-8 space-y-6 shadow-card">
            <h3 className="text-lg font-bold text-slate-900 border-b border-slate-100 pb-3 flex items-center gap-2">
              <Calendar className="w-5 h-5 text-brand-forest" />
              <span>{isBangla ? "পরিকল্পনা ও অগ্রগতি" : "Execution Milestones"}</span>
            </h3>

            <div className="space-y-6 pl-2">
              {project.milestones.map((m, idx) => (
                <div key={m.id} className="relative flex items-start gap-4">
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center font-bold text-xs shrink-0 ${
                    m.is_completed
                      ? "bg-jade text-white shadow-sm shadow-jade/30"
                      : "bg-slate-100 text-slate-500 border border-slate-300"
                  }`}>
                    {m.is_completed ? <CheckCircle2 className="w-4 h-4" /> : idx + 1}
                  </div>
                  <div className="space-y-1">
                    <div className="flex items-center gap-2">
                      <h4 className="text-sm font-bold text-slate-900">{isBangla ? m.title_bn : m.title}</h4>
                      {m.is_completed && (
                        <span className="px-2 py-0.5 rounded text-[10px] font-bold bg-emerald-100 text-emerald-800">
                          COMPLETED
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-slate-600">{m.description}</p>
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

      {/* 4. 10x10 Share Matrix Map */}
      <section className="space-y-4">
        <ShareMatrixGrid />
      </section>

      {/* 5. Fund Transparency & Live Expense Vouchers */}
      <section className="space-y-4">
        <TransparencyLedger />
      </section>
    </div>
  );
}
