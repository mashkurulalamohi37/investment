"use client";

import React from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { useCms } from "@/lib/cms/useCms";
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
  Lock,
  Receipt,
} from "lucide-react";

const ICON_MAP: Record<string, any> = {
  Layers,
  Building2,
  Receipt,
  Scale,
  ShieldCheck,
  Award,
  Coins,
};

export default function HomePage() {
  const { isBangla, isAuthenticated } = useAuth();
  const { home } = useCms();

  // Extract live projects for showcase
  const showcaseProjects = (home.liveProjectsSection?.projects || [])
    .filter((p) => p.showOnHome)
    .sort((a, b) => (a.order || 0) - (b.order || 0));

  // 4 Bento Trust Pillars from CMS
  const trustPillars = home.trustPillars || [];

  return (
    <div className="space-y-16 lg:space-y-20 pb-20">
      {/* =========================================================================
          1. HERO SECTION — Ultra-Luxurious Prime Asset Imagery & Ambient Mesh
          ========================================================================= */}
      <section className="relative overflow-hidden text-white pt-10 pb-12 lg:pt-14 lg:pb-16 rounded-3xl mx-2 sm:mx-4 lg:mx-8 mt-2 shadow-2xl border border-slate-800/80 min-h-[420px] lg:min-h-[480px] flex items-center">
        {/* Full Background Asset Image with Balanced Cinematic Gradient */}
        <div className="absolute inset-0 z-0 pointer-events-none">
          <img
            src={home.hero.bgImageUrl || "/images/hero_investment_bg.jpg"}
            alt="Prime Asset and Smart Agro Development"
            className="w-full h-full object-cover object-center lg:object-[center_28%]"
          />
          {/* Subtle gradient: ensures crisp typography on the left while allowing the complete estate view to shine */}
          <div className="absolute inset-0 bg-gradient-to-r from-[#040D1A]/95 via-[#040D1A]/80 to-[#040D1A]/25 lg:to-transparent" />
          <div className="absolute inset-0 bg-gradient-to-t from-[#040D1A]/90 via-transparent to-[#040D1A]/40" />
        </div>

        {/* Ambient Lighting Glows */}
        <div className="absolute -top-40 -right-40 w-96 h-96 bg-cyan/20 rounded-full blur-3xl pointer-events-none z-1" />
        <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-brand-emerald/25 rounded-full blur-3xl pointer-events-none z-1" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 w-full py-2">
          <div className="max-w-3xl space-y-4 lg:space-y-5 text-center lg:text-left">
            {/* Live Badge Pill */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white/10 backdrop-blur-xl border border-white/20 text-xs font-semibold text-cyan-light shadow-inner">
              <span className="w-2 h-2 rounded-full bg-emerald-400 animate-ping" />
              <Sparkles className="w-3.5 h-3.5 text-cyan" />
              <span>{isBangla ? home.hero.taglineBn : home.hero.tagline}</span>
            </div>

            {/* Main Headline */}
            <h1 className="text-2xl sm:text-4xl lg:text-5xl font-black tracking-tight leading-[1.14]">
              {isBangla ? (
                <>
                  {home.hero.headlineBn.split("।")[0]}
                  {home.hero.headlineBn.includes("।") ? "।" : ""}{" "}
                  <br />
                  <span className="text-shimmer-blue">
                    {home.hero.headlineBn.split("।")[1] || ""}
                  </span>
                </>
              ) : (
                <>
                  {home.hero.headline.split(".")[0]}
                  {home.hero.headline.includes(".") ? "." : ""}{" "}
                  <br />
                  <span className="text-shimmer-blue">
                    {home.hero.headline.split(".")[1] || ""}
                  </span>
                </>
              )}
            </h1>

            {/* Sub-Headline */}
            <p className="text-xs sm:text-sm lg:text-base text-slate-300 max-w-2xl mx-auto lg:mx-0 leading-relaxed font-normal">
              {isBangla ? home.hero.subheadlineBn : home.hero.subheadline}
            </p>

            {/* Action Buttons */}
            <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-3 pt-0.5">
              <Link
                href={home.hero.primaryCtaUrl || "/projects/landvest-100"}
                className="w-full sm:w-auto px-7 py-3 rounded-full btn-primary-glow text-white font-extrabold text-xs sm:text-sm flex items-center justify-center gap-2 group cursor-pointer"
              >
                <span>{isBangla ? home.hero.primaryCtaTextBn : home.hero.primaryCtaText}</span>
                <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1 text-cyan-light" />
              </Link>

              <Link
                href={home.hero.secondaryCtaUrl || "/projects"}
                className="w-full sm:w-auto px-6 py-3 rounded-full btn-secondary-glow text-white font-bold text-xs sm:text-sm transition-all flex items-center justify-center gap-2 cursor-pointer"
              >
                <Layers className="w-4 h-4 text-cyan" />
                <span>{isBangla ? home.hero.secondaryCtaTextBn : home.hero.secondaryCtaText}</span>
              </Link>
            </div>

            {/* Sleek Trust & Escrow Assurance */}
            <div className="flex flex-wrap items-center justify-center lg:justify-start gap-2.5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#040D1A]/70 backdrop-blur-md border border-white/15 text-[11px] sm:text-xs text-slate-200 shadow-sm">
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-400 shrink-0" />
                <span>{isBangla ? "সিটি ব্যাংক এসক্রো অ্যাকাউন্টে ১০০% সুরক্ষিত" : "100% City Bank Escrow Protected"}</span>
              </div>
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#040D1A]/70 backdrop-blur-md border border-white/15 text-[11px] sm:text-xs text-slate-200 shadow-sm">
                <CheckCircle2 className="w-3.5 h-3.5 text-cyan shrink-0" />
                <span>{isBangla ? "মাইলস্টোন ও অডিট সাপেক্ষে তহবিল" : "Audited Milestone Disbursements"}</span>
              </div>
            </div>

            {/* Trust Metrics Ribbon — Sleek Solid Frosted Glass Bar */}
            <div className="pt-3 border-t border-white/15 max-w-2xl mx-auto lg:mx-0">
              <div className="p-2.5 sm:p-3 rounded-2xl bg-[#040D1A]/75 backdrop-blur-xl border border-white/20 shadow-xl grid grid-cols-3 divide-x divide-white/15 text-center">
                {home.metrics.slice(0, 3).map((metric, idx) => (
                  <div key={metric.id || idx} className="px-1.5 sm:px-3 flex flex-col items-center justify-center">
                    <span className={`text-xs sm:text-base lg:text-lg font-black ${metric.color || "text-cyan"} font-mono whitespace-nowrap block`}>
                      {isBangla ? metric.valueBn : metric.value}
                    </span>
                    <span className="text-[9px] sm:text-[11px] text-slate-300 font-medium whitespace-nowrap block mt-0.5">
                      {isBangla ? metric.labelBn : metric.label}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* =========================================================================
          2. 4 INSTITUTIONAL TRUST PILLARS (BENTO GRID)
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
        <div className="text-center max-w-2xl mx-auto space-y-2">
          <span className="px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-brand-light text-brand-emerald">
            {isBangla ? "কেন স্বপ্নযাত্রী?" : "Core Trust Architecture"}
          </span>
          <h2 className="text-2xl sm:text-4xl font-black text-slate-900 tracking-tight">
            {isBangla ? "শতভাগ স্বচ্ছতা ও সুরক্ষার ৪টি ভিত্তি" : "Four Pillars of Transparent Crowdfunding"}
          </h2>
          <p className="text-xs sm:text-sm text-slate-500">
            {isBangla
              ? "সাধারণ বিনিয়োগকারীদের আস্থা ও সুরক্ষার জন্য তৈরি আধুনিক ফিনটেক ফ্রেমওয়ার্ক"
              : "Institutional grade fund security, audited records, and automated pro-rata profit mechanics"}
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          {trustPillars.map((tp, idx) => {
            const PillarIcon = ICON_MAP[tp.icon] || Layers;
            return (
              <div
                key={tp.id || idx}
                className="p-6 rounded-3xl bg-white border border-slate-200/90 shadow-card hover:shadow-cardHover hover:-translate-y-1 transition-all duration-300 space-y-4 flex flex-col justify-between"
              >
                <div className="space-y-3">
                  <div className="w-12 h-12 rounded-2xl bg-cyan-tint/60 text-cyan-dark flex items-center justify-center">
                    <PillarIcon className="w-6 h-6" />
                  </div>
                  <div className="space-y-1">
                    <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-amber-50 text-amber-700 font-mono">
                      {isBangla ? tp.badgeBn : tp.badge}
                    </span>
                    <h3 className="text-base font-bold text-slate-900 pt-1">
                      {isBangla ? tp.titleBn : tp.title}
                    </h3>
                  </div>
                  <p className="text-xs text-slate-600 leading-relaxed">
                    {isBangla ? tp.descBn : tp.desc}
                  </p>
                </div>

                <div className="pt-2 flex items-center gap-1 text-[11px] font-bold text-brand-emerald">
                  <CheckCircle2 className="w-3.5 h-3.5" />
                  <span>{isBangla ? "যাচাইকৃত সুবিধা" : "Verified Protocol"}</span>
                </div>
              </div>
            );
          })}
        </div>
      </section>

      {/* =========================================================================
          3. LIVE SHARE ALLOCATION & SUMMARY CARD
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ShareMatrixGrid />
      </section>

      {/* =========================================================================
          4. OFFICIAL TRACK RECORD & LANDVEST 100 STORY
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <LandVestStoryCard />
      </section>

      {/* =========================================================================
          5. CMS-CONTROLLED ONGOING & UPCOMING PROJECTS SHOWCASE
          ========================================================================= */}
      {home.liveProjectsSection?.enabled !== false && (
        <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-6">
          {/* Section Header */}
          <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 pb-3 border-b border-slate-200/80">
            <div className="space-y-1">
              <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-[11px] font-bold uppercase tracking-wider bg-emerald-50 text-emerald-700 border border-emerald-200/80">
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
                <span>
                  {isBangla
                    ? home.liveProjectsSection.badgeBn
                    : home.liveProjectsSection.badge}
                </span>
              </div>
              <h2 className="text-xl sm:text-2xl lg:text-3xl font-black text-slate-900 tracking-tight">
                {isBangla
                  ? home.liveProjectsSection.titleBn
                  : home.liveProjectsSection.title}
              </h2>
              <p className="text-xs sm:text-sm text-slate-600 max-w-xl">
                {isBangla
                  ? home.liveProjectsSection.subtitleBn
                  : home.liveProjectsSection.subtitle}
              </p>
            </div>

            <Link
              href="/projects"
              className="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full bg-white hover:bg-slate-50 border border-slate-200 text-xs font-bold text-slate-700 hover:text-brand-emerald shadow-2xs transition-all self-start sm:self-auto group cursor-pointer shrink-0"
            >
              <span>{isBangla ? "সকল প্রকল্প দেখুন" : "View All Projects"}</span>
              <ArrowRight className="w-3.5 h-3.5 text-brand-emerald transition-transform group-hover:translate-x-1" />
            </Link>
          </div>

          {/* Dynamic Project Cards Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
            {showcaseProjects.map((proj) => {
              const progressPercent = Math.min(
                100,
                Math.round((proj.allocatedShares / (proj.totalShares || 1)) * 100)
              );
              const detailUrl = proj.ctaUrl || `/projects/${proj.projectCode.toLowerCase()}`;

              return (
                <div
                  key={proj.id}
                  className="bg-white rounded-2xl border border-slate-200/90 hover:border-brand-emerald/40 shadow-sm hover:shadow-md transition-all duration-300 flex flex-col justify-between overflow-hidden group"
                >
                  {/* Image Header with Badges */}
                  <div className="relative h-36 sm:h-40 overflow-hidden bg-slate-900">
                    <img
                      src={proj.imageUrl || "/images/landvest_hero.jpg"}
                      alt={proj.name}
                      className="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-500"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-slate-950/85 via-slate-950/25 to-transparent" />

                    {/* Top Badges */}
                    <div className="absolute top-2.5 left-2.5 right-2.5 flex items-center justify-between gap-2">
                      <span className="px-2.5 py-0.5 rounded-full text-[10px] font-mono font-black bg-[#040D1A]/85 backdrop-blur-md text-cyan-light border border-white/20 shadow-xs">
                        {proj.projectCode}
                      </span>
                      <span className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold backdrop-blur-md text-white border shadow-xs ${
                        proj.isUpcoming
                          ? "bg-amber-500/90 border-amber-400/40"
                          : "bg-emerald-500/90 border-emerald-400/40"
                      }`}>
                        <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse" />
                        <span>{isBangla ? proj.statusBadgeBn : proj.statusBadge}</span>
                      </span>
                    </div>

                    {/* Bottom Image Overlay Info */}
                    <div className="absolute bottom-2.5 left-2.5 right-2.5">
                      <span className="text-[10px] font-mono text-cyan-light font-bold flex items-center gap-1 drop-shadow">
                        <MapPin className="w-3 h-3 text-cyan shrink-0" />
                        <span className="truncate">{isBangla ? proj.locationBn : proj.location}</span>
                      </span>
                    </div>
                  </div>

                  {/* Card Body */}
                  <div className="p-4 space-y-3 flex-1 flex flex-col justify-between">
                    <div className="space-y-1.5">
                      <div className="flex items-center justify-between gap-2">
                        <span className="px-2 py-0.5 rounded-md text-[10px] font-bold uppercase tracking-wider bg-slate-100 text-slate-600">
                          {isBangla ? proj.categoryBn : proj.category}
                        </span>
                        <span className="text-[10px] font-mono font-bold text-slate-500">
                          {proj.isUpcoming
                            ? (isBangla ? `${proj.totalShares}টি শেয়ার লক্ষ্য` : `${proj.totalShares} Units Goal`)
                            : `${proj.totalShares - proj.allocatedShares} ${isBangla ? "ভাগ বাকি" : "Units Left"}`}
                        </span>
                      </div>

                      <Link href={detailUrl} className="block group-hover:text-brand-emerald transition-colors">
                        <h3 className="text-base font-black text-slate-900 tracking-tight leading-snug line-clamp-1">
                          {isBangla ? proj.nameBn : proj.name}
                        </h3>
                      </Link>
                    </div>

                    {/* Compact Key Metrics 2-Col Box */}
                    <div className="grid grid-cols-2 gap-2 p-2.5 rounded-xl bg-slate-50 border border-slate-200/70 text-xs">
                      <div>
                        <span className="text-[9px] text-slate-400 font-bold uppercase font-mono block">
                          {isBangla ? "প্রতি শেয়ার মূল্য" : "Per Share Price"}
                        </span>
                        <span className="font-mono font-black text-[#0066FF] text-sm block mt-0.5">
                          {formatBDT(proj.pricePerShare, { isBangla })}
                        </span>
                      </div>
                      <div>
                        <span className="text-[9px] text-slate-400 font-bold uppercase font-mono block">
                          {isBangla ? "প্রত্যাশিত ROI" : "Projected ROI"}
                        </span>
                        <span className="font-mono font-black text-emerald-600 text-sm block mt-0.5">
                          {proj.projectedRoiMin}% - {proj.projectedRoiMax}%
                        </span>
                      </div>
                    </div>

                    {/* Share Subscription Progress Bar */}
                    <div className="space-y-1 pt-0.5">
                      <div className="flex items-center justify-between text-[11px] font-bold text-slate-700">
                        <span>
                          {proj.isUpcoming
                            ? (isBangla ? "প্রি-বুকিং রেজিস্ট্রেশন চলমান" : "Pre-Booking Registration")
                            : (isBangla
                                ? `${proj.allocatedShares} / ${proj.totalShares} শেয়ার বরাদ্দ`
                                : `${proj.allocatedShares} / ${proj.totalShares} Subscribed`)}
                        </span>
                        <span className="text-brand-emerald font-mono font-black">
                          {proj.isUpcoming ? (isBangla ? "শীঘ্রই" : "Soon") : `${progressPercent}%`}
                        </span>
                      </div>
                      <div className="h-1.5 rounded-full bg-slate-100 overflow-hidden">
                        <div
                          className={`h-full rounded-full transition-all duration-700 ${
                            proj.isUpcoming
                              ? "bg-amber-400"
                              : "bg-gradient-to-r from-brand-forest via-brand-emerald to-cyan"
                          }`}
                          style={{ width: proj.isUpcoming ? "12%" : `${progressPercent}%` }}
                        />
                      </div>
                    </div>
                  </div>

                  {/* Compact Card Action Footer */}
                  <div className="p-3 px-4 bg-slate-50/80 border-t border-slate-100 flex items-center justify-between gap-2">
                    <span className="text-[10px] font-medium text-slate-500 flex items-center gap-1">
                      <ShieldCheck className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
                      <span className="truncate">
                        {isBangla ? proj.escrowBadgeBn : proj.escrowBadge}
                      </span>
                    </span>

                    <Link
                      href={detailUrl}
                      className="px-3.5 py-1.5 rounded-full bg-slate-900 hover:bg-brand-emerald text-white font-bold text-[11px] flex items-center gap-1 shadow-2xs transition-all group-hover:scale-[1.02] cursor-pointer shrink-0"
                    >
                      <span>
                        {isBangla ? proj.ctaTextBn : proj.ctaText}
                      </span>
                      <ArrowRight className="w-3 h-3 text-cyan-light transition-transform group-hover:translate-x-0.5" />
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
        </section>
      )}

      {/* =========================================================================
          6. LIVE FUND LEDGER & AUDITED EXPENSE VOUCHERS (Investors Only)
          ========================================================================= */}
      {isAuthenticated && (
        <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <TransparencyLedger />
        </section>
      )}

      {/* =========================================================================
          7. CMS-CONTROLLED CALL TO ACTION RIBBON
          ========================================================================= */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="p-8 sm:p-12 rounded-3xl bg-[#0A2540] hero-mesh-gradient text-white text-center sm:text-left flex flex-col sm:flex-row items-center justify-between gap-8 shadow-2xl relative overflow-hidden border border-slate-800">
          <div className="space-y-3 max-w-xl relative z-10">
            <span className="px-3.5 py-1 rounded-full text-[10px] font-mono font-bold bg-white/10 text-cyan uppercase tracking-wider border border-white/15">
              LIMITED 100 UNITS
            </span>
            <h3 className="text-2xl sm:text-3xl font-black text-white leading-tight">
              {isBangla
                ? home.conversionBanner.titleBn
                : home.conversionBanner.title}
            </h3>
            <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-normal">
              {isBangla
                ? home.conversionBanner.subtitleBn
                : home.conversionBanner.subtitle}
            </p>
          </div>

          <div className="flex flex-col sm:flex-row gap-3 w-full sm:w-auto relative z-10 shrink-0">
            <Link
              href={home.conversionBanner.ctaUrl || "/projects/landvest-100"}
              className="px-8 py-4 rounded-full bg-brand-emerald hover:bg-brand-forest text-white font-extrabold text-sm text-center shadow-lg shadow-brand-emerald/30 transition-all flex items-center justify-center gap-2 group"
            >
              <span>{isBangla ? home.conversionBanner.ctaTextBn : home.conversionBanner.ctaText}</span>
              <ArrowRight className="w-4 h-4 text-cyan-light transition-transform group-hover:translate-x-1" />
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
