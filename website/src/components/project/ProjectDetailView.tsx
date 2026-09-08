"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Project } from "@/types/api";
import ShareMatrixGrid from "@/components/project/ShareMatrixGrid";
import TransparencyLedger from "@/components/project/TransparencyLedger";
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
  Users,
  Handshake,
  Download,
  FileText,
  Clock,
  PieChart,
  Calculator,
  ChevronLeft,
  ChevronRight,
  ExternalLink,
  ClipboardList,
  FolderDown,
  Scale,
  BadgeCheck,
  Sprout,
  Landmark,
  Phone,
  MessageCircle,
  Image as ImageIcon,
} from "lucide-react";

interface ProjectDetailViewProps {
  project: Project;
}

export default function ProjectDetailView({ project }: ProjectDetailViewProps) {
  const { isBangla, isAuthenticated } = useAuth();

  const pricePerShare = Number(project.price_per_share) || 25500;
  const totalShares = Number(project.total_shares) || 100;
  const allocatedShares = Number(project.allocated_shares) || 74;
  const availableShares = Math.max(0, totalShares - allocatedShares);
  const allocatedPercent = Math.round((allocatedShares / totalShares) * 100);

  // Stepper State for Calculator
  const [shares, setShares] = useState(1);
  const minShares = Number(project.min_shares) || 1;
  const maxShares = Number(project.max_shares) || 4;

  const handleDecrement = () => {
    if (shares > minShares) setShares(shares - 1);
  };
  const handleIncrement = () => {
    if (shares < maxShares) setShares(shares + 1);
  };

  const totalAmount = shares * pricePerShare;

  // Gallery slider state
  const defaultGallery = [
    {
      title: isBangla ? "বর্তমান জমির অবস্থা" : "Current Land Condition",
      image_url: "/images/gallery_land.jpg",
    },
    {
      title: isBangla ? "এলাকার উন্নয়ন সম্ভাবনা" : "Area Development Potential",
      image_url: "/images/gallery_road.jpg",
    },
    {
      title: isBangla ? "ভবিষ্যতের সম্ভাবনা" : "Future Project Vision",
      image_url: "/images/gallery_future.jpg",
    },
  ];

  const galleryList = project.gallery_images && project.gallery_images.length > 0
    ? project.gallery_images
    : defaultGallery;

  const [activeSlide, setActiveSlide] = useState(0);

  const prevSlide = () => {
    setActiveSlide((prev) => (prev === 0 ? galleryList.length - 1 : prev - 1));
  };
  const nextSlide = () => {
    setActiveSlide((prev) => (prev === galleryList.length - 1 ? 0 : prev + 1));
  };

  // Map view tab switcher
  const [mapTab, setMapTab] = useState<"LIVE" | "PLAN">("LIVE");

  const mapQuery = project.code === "LV100"
    ? "Washpur, Bosila Bridge, Dhaka, Bangladesh"
    : project.code === "AGRO-S1"
    ? "Singair, Manikganj, Dhaka Division, Bangladesh"
    : project.code === "DAIRY-01"
    ? "Savar Dairy Zone, Savar, Dhaka, Bangladesh"
    : `${project.location || "Dhaka"}, Bangladesh`;

  const googleMapsEmbedUrl = `https://maps.google.com/maps?q=${encodeURIComponent(
    mapQuery
  )}&t=&z=14&ie=UTF8&iwloc=&output=embed`;

  // Documents list
  const defaultDocuments = [
    {
      title: isBangla ? "প্রকল্প পরিচিতি (PDF)" : "Project Prospectus (PDF)",
      file_url: "/documents/prospectus.pdf",
      size: "2.4 MB",
    },
    {
      title: isBangla ? "বিনিয়োগ চুক্তি (PDF)" : "Investment Agreement (PDF)",
      file_url: "/documents/agreement.pdf",
      size: "1.8 MB",
    },
    {
      title: isBangla ? "FAQ ও প্রশ্নোত্তর (PDF)" : "Project FAQ (PDF)",
      file_url: "/documents/faq.pdf",
      size: "850 KB",
    },
  ];

  const docList = project.documents && project.documents.length > 0
    ? project.documents
    : defaultDocuments;

  const isUpcoming = project.status === "UPCOMING";
  const investUrl = isUpcoming
    ? isAuthenticated
      ? `/dashboard/investments/new?project=${project.id || project.code}&shares=${shares}&mode=prebook`
      : `/login?redirect=/dashboard/investments/new?project=${project.id || project.code}&shares=${shares}&mode=prebook`
    : isAuthenticated
    ? `/dashboard/investments/new?project=${project.id || project.code}&shares=${shares}`
    : `/login?redirect=/dashboard/investments/new?project=${project.id || project.code}&shares=${shares}`;

  return (
    <div className="max-w-7xl mx-auto px-3 sm:px-6 lg:px-8 py-6 sm:py-10 space-y-10 font-sans overflow-x-clip">
      {/* =========================================================================
          1. HERO HEADER WITH LANDSCAPE GRAPHIC
          ========================================================================= */}
      <div className="relative rounded-3xl overflow-hidden shadow-2xl border border-slate-200/80 bg-[#040D1A] text-white min-h-[380px] sm:min-h-[440px] flex flex-col justify-between p-6 sm:p-10 lg:p-12">
        {/* Background Landscape Photo */}
        <div className="absolute inset-0 z-0 pointer-events-none">
          <img
            src={project.hero_image_url || "/images/landvest_hero.jpg"}
            alt={project.name}
            className="w-full h-full object-cover object-center"
          />
          {/* Layered Gradient Overlays */}
          <div className="absolute inset-0 bg-gradient-to-r from-[#040D1A]/95 via-[#040D1A]/85 to-transparent sm:to-[#040D1A]/20" />
          <div className="absolute inset-0 bg-gradient-to-t from-[#040D1A]/90 via-transparent to-[#040D1A]/30" />
        </div>

        {/* Top Bar inside Hero */}
        <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-center gap-2">
            <span className="px-3 py-1 rounded-full text-xs font-mono font-black bg-white/20 backdrop-blur-md text-white border border-white/30 shadow-xs">
              {project.code || "LV100"}
            </span>
            {project.status === "OPEN" ? (
              <span className="px-3 py-1 rounded-full text-xs font-bold bg-emerald-500/20 backdrop-blur-md text-emerald-300 border border-emerald-400/40 flex items-center gap-1.5">
                <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
                <span>{isBangla ? "লাইভ প্রজেক্ট" : "LIVE PROJECT"}</span>
              </span>
            ) : isUpcoming ? (
              <span className="px-3 py-1 rounded-full text-xs font-bold bg-amber-500/25 backdrop-blur-md text-amber-300 border border-amber-400/50 flex items-center gap-1.5">
                <span className="w-2 h-2 rounded-full bg-amber-400" />
                <span>{isBangla ? "আসন্ন প্রকল্প" : "UPCOMING PROJECT"}</span>
              </span>
            ) : (
              <span className="px-3 py-1 rounded-full text-xs font-bold bg-slate-500/20 backdrop-blur-md text-slate-300 border border-slate-400/40 flex items-center gap-1.5">
                <span>{isBangla ? "সম্পন্ন" : "CLOSED"}</span>
              </span>
            )}
          </div>

          {/* Tagline on top-right */}
          <div className="text-left sm:text-right">
            <span className="text-base sm:text-lg lg:text-xl font-bold italic tracking-wide text-cyan-light drop-shadow-md font-display">
              {project.hero_tagline || (isBangla ? "আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা" : "Today's trust is tomorrow's safe address")}
            </span>
          </div>
        </div>

        {/* Hero Main Content */}
        <div className="relative z-10 max-w-2xl space-y-3.5 my-auto pt-6 pb-8">
          <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black tracking-tight text-white drop-shadow-md">
            {isBangla ? project.name_bn || project.name : project.name}
          </h1>

          <p className="text-xs sm:text-sm text-slate-200 flex items-center gap-2 font-medium drop-shadow-sm">
            <MapPin className="w-4 h-4 text-cyan shrink-0" />
            <span>{isBangla ? project.location_bn || project.location : project.location}</span>
          </p>

          <p className="text-xs sm:text-sm text-slate-300 leading-relaxed font-normal max-w-xl">
            {isBangla ? project.description_bn || project.description : project.description}
          </p>

          <div className="pt-2">
            <span className="text-base sm:text-xl font-extrabold text-[#70C5FF] italic drop-shadow-sm">
              “{project.hero_quote || (isBangla ? "ছোট বিনিয়োগ, বড় ভবিষ্যৎ..." : "Small investment, grand future...")}”
            </span>
          </div>
        </div>
      </div>

      {/* =========================================================================
          2. FLOATING METRICS RIBBON
          ========================================================================= */}
      <div className="relative z-20 -mt-8 sm:-mt-12 mx-2 sm:mx-6 rounded-2xl bg-white border border-slate-200 shadow-xl p-3 sm:p-5">
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3 sm:gap-4 items-center divide-y sm:divide-y-0 sm:divide-x divide-slate-100">
          {/* Unit Price */}
          <div className="p-2 sm:px-3 text-center sm:text-left">
            <span className="text-[11px] font-semibold text-slate-500 uppercase tracking-wider block">
              {isBangla ? "প্রতি শেয়ার" : "Per Share"}
            </span>
            <span className="text-lg sm:text-xl font-black text-[#0066FF] font-mono block mt-0.5">
              {formatBDT(pricePerShare, { isBangla })}
            </span>
          </div>

          {/* Expected ROI */}
          <div className="p-2 sm:px-3 text-center sm:text-left">
            <span className="text-[11px] font-semibold text-slate-500 uppercase tracking-wider block">
              {isBangla ? "প্রত্যাশিত ROI" : "Target ROI"}
            </span>
            <span className="text-lg sm:text-xl font-black text-emerald-600 font-mono block mt-0.5">
              {project.projected_roi_min}% - {project.projected_roi_max}%
            </span>
          </div>

          {/* Total Shares */}
          <div className="p-2 sm:px-3 text-center sm:text-left">
            <span className="text-[11px] font-semibold text-slate-500 uppercase tracking-wider block">
              {isBangla ? "মোট শেয়ার" : "Total Shares"}
            </span>
            <span className="text-lg sm:text-xl font-black text-slate-900 font-mono block mt-0.5">
              {totalShares} {isBangla ? "টি" : "Units"}
            </span>
          </div>

          {/* Sold Shares */}
          <div className="p-2 sm:px-3 text-center sm:text-left">
            <span className="text-[11px] font-semibold text-slate-500 uppercase tracking-wider block">
              {isBangla ? "এখন পর্যন্ত বিক্রি" : "Subscribed"}
            </span>
            <span className="text-lg sm:text-xl font-black text-slate-900 font-mono block mt-0.5">
              {allocatedShares} {isBangla ? "টি" : "Units"}
            </span>
          </div>

          {/* Available Shares */}
          <div className="p-2 sm:px-3 text-center sm:text-left">
            <span className="text-[11px] font-semibold text-slate-500 uppercase tracking-wider block">
              {isBangla ? "অবশিষ্ট শেয়ার" : "Remaining"}
            </span>
            <span className="text-lg sm:text-xl font-black text-amber-600 font-mono block mt-0.5">
              {availableShares} {isBangla ? "টি" : "Units"}
            </span>
          </div>

          {/* Status Badge */}
          <div className="p-2 sm:px-3 flex items-center justify-center sm:justify-end">
            {project.status === "OPEN" ? (
              <span className="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full text-xs font-bold bg-emerald-50 text-emerald-800 border border-emerald-200 shadow-2xs">
                <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
                <span>{isBangla ? "চলমান" : "Open"}</span>
              </span>
            ) : isUpcoming ? (
              <span className="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full text-xs font-bold bg-amber-50 text-amber-800 border border-amber-200 shadow-2xs">
                <span className="w-2 h-2 rounded-full bg-amber-500" />
                <span>{isBangla ? "আসন্ন" : "Upcoming"}</span>
              </span>
            ) : (
              <span className="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full text-xs font-bold bg-slate-100 text-slate-700 border border-slate-200 shadow-2xs">
                <span>{isBangla ? "সম্পন্ন" : "Closed"}</span>
              </span>
            )}
          </div>
        </div>
      </div>

      {/* =========================================================================
          3. MAIN CONTENT: 2-COLUMN BALANCED DECISION GRID (7 COLS LEFT / 5 COLS RIGHT)
          ========================================================================= */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start pt-2">
        {/* =======================================================================
            LEFT COLUMN (7 COLS)
            ======================================================================= */}
        <div className="lg:col-span-7 space-y-8">
          {/* 1. About Project & 4 Bento Trust Cards */}
          <div className="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-6 shadow-sm">
            <div className="space-y-2">
              <h2 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight">
                {isBangla ? "প্রকল্প সম্পর্কে" : "About the Project"}
              </h2>
              <p className="text-xs sm:text-sm text-slate-600 leading-relaxed">
                {isBangla
                  ? project.description_bn || project.description
                  : project.description || project.description_bn}
              </p>
            </div>

            {/* 4 Bento Feature Cards */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-center">
              <div className="p-4 rounded-2xl bg-blue-50/60 border border-blue-100 space-y-2 flex flex-col items-center justify-center">
                <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center">
                  <ShieldCheck className="w-5 h-5" />
                </div>
                <span className="text-xs font-bold text-slate-800 block">
                  {isBangla ? "নিরাপদ ও স্বচ্ছ প্রক্রিয়া" : "Secure & Transparent"}
                </span>
              </div>

              <div className="p-4 rounded-2xl bg-blue-50/60 border border-blue-100 space-y-2 flex flex-col items-center justify-center">
                <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center">
                  <Users className="w-5 h-5" />
                </div>
                <span className="text-xs font-bold text-slate-800 block">
                  {isBangla ? "ছোট বিনিয়োগে বড় সুযোগ" : "Micro-Equity Access"}
                </span>
              </div>

              <div className="p-4 rounded-2xl bg-blue-50/60 border border-blue-100 space-y-2 flex flex-col items-center justify-center">
                <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center">
                  {project.category === "AGRICULTURAL" ? (
                    <Sprout className="w-5 h-5" />
                  ) : (
                    <TrendingUp className="w-5 h-5" />
                  )}
                </div>
                <span className="text-xs font-bold text-slate-800 block">
                  {project.category === "AGRICULTURAL"
                    ? isBangla ? "মৌসুমী ও নিয়মিত মুনাফা" : "Seasonal Crop & Dairy Yields"
                    : isBangla ? "দীর্ঘমেয়াদি মূল্য বৃদ্ধি" : "High Appreciation"}
                </span>
              </div>

              <div className="p-4 rounded-2xl bg-blue-50/60 border border-blue-100 space-y-2 flex flex-col items-center justify-center">
                <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center">
                  <Handshake className="w-5 h-5" />
                </div>
                <span className="text-xs font-bold text-slate-800 block">
                  {isBangla ? "বিশ্বাস ও সহযোগিতার ভিত্তি" : "Mutual Trust & Growth"}
                </span>
              </div>
            </div>
          </div>

          {/* 2. Share Sales Progress */}
          <div className="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-4 shadow-sm">
            <div className="flex items-center justify-between">
              <h3 className="text-base sm:text-lg font-bold text-slate-900">
                {isBangla ? "শেয়ার বিক্রির অগ্রগতি" : "Subscription Progress"}
              </h3>
              <span className="text-sm font-black text-[#0066FF] font-mono">
                {allocatedPercent}%
              </span>
            </div>

            <div className="space-y-2">
              <div className="flex items-center justify-between text-xs font-medium text-slate-500">
                <span>
                  {allocatedShares} / {totalShares} {isBangla ? "শেয়ার বিক্রি" : "Shares Subscribed"}
                </span>
                <span>
                  {availableShares} {isBangla ? "টি বাকি" : "Units Left"}
                </span>
              </div>

              <div className="w-full h-3 rounded-full bg-slate-100 overflow-hidden p-0.5 border border-slate-200/60">
                <div
                  className="h-full rounded-full bg-gradient-to-r from-[#0066FF] to-cyan transition-all duration-700"
                  style={{ width: `${Math.min(100, allocatedPercent)}%` }}
                />
              </div>
            </div>
          </div>

          {/* 3. Location & Interactive Map */}
          <div className="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-5 shadow-sm">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-100">
              <div className="flex items-center gap-2.5">
                <div className="w-9 h-9 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center shrink-0">
                  <MapPin className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="text-base sm:text-lg font-black text-slate-900 tracking-tight">
                    {isBangla ? "প্রকল্পের অবস্থান ও ম্যাপ" : "Project Location & Map"}
                  </h3>
                  <p className="text-xs text-slate-500 font-medium">
                    {isBangla ? project.location_bn || project.location : project.location}
                  </p>
                </div>
              </div>

              {/* View Switcher Tabs & External Link */}
              <div className="flex items-center gap-2 self-start sm:self-auto">
                <div className="inline-flex p-1 rounded-xl bg-slate-100 border border-slate-200 text-xs font-bold">
                  <button
                    type="button"
                    onClick={() => setMapTab("LIVE")}
                    className={`px-3 py-1 rounded-lg transition-all cursor-pointer ${
                      mapTab === "LIVE"
                        ? "bg-white text-[#0066FF] shadow-xs font-extrabold"
                        : "text-slate-600 hover:text-slate-900"
                    }`}
                  >
                    {isBangla ? "লাইভ গুগল ম্যাপ" : "Live Map"}
                  </button>
                  <button
                    type="button"
                    onClick={() => setMapTab("PLAN")}
                    className={`px-3 py-1 rounded-lg transition-all cursor-pointer ${
                      mapTab === "PLAN"
                        ? "bg-white text-[#0066FF] shadow-xs font-extrabold"
                        : "text-slate-600 hover:text-slate-900"
                    }`}
                  >
                    {isBangla ? "সাইট রুট প্ল্যান" : "Route Plan"}
                  </button>
                </div>

                <a
                  href={project.map_url || `https://maps.google.com/?q=${encodeURIComponent(mapQuery)}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-xs transition-all cursor-pointer"
                  title="Open in Google Maps"
                >
                  <ExternalLink className="w-3.5 h-3.5" />
                  <span className="hidden sm:inline">{isBangla ? "ম্যাপে খুলুন" : "Google Maps"}</span>
                </a>
              </div>
            </div>

            {/* Map Frame Container (100% Crystal Clear & Interactive) */}
            <div className="relative rounded-2xl overflow-hidden border border-slate-200 shadow-inner h-72 sm:h-88 lg:h-96 bg-slate-100">
              {mapTab === "LIVE" ? (
                <iframe
                  title="Project Location Map"
                  src={googleMapsEmbedUrl}
                  className="w-full h-full border-0"
                  loading="lazy"
                  allowFullScreen
                  referrerPolicy="no-referrer-when-downgrade"
                />
              ) : (
                <div className="relative w-full h-full flex items-center justify-center bg-slate-50 p-2">
                  <img
                    src={project.map_image_url || "/images/washpur_map.svg"}
                    alt="Site Route Plan"
                    className="w-full h-full object-contain"
                  />
                </div>
              )}
            </div>

            {/* Map Footnote & Direction Badges */}
            <div className="flex flex-wrap items-center justify-between gap-3 text-xs text-slate-600 pt-1">
              <div className="flex items-center gap-2">
                <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
                <span className="font-semibold text-slate-700">
                  {isBangla ? "যাচাইকৃত অবস্থান:" : "Verified Site:"}{" "}
                  <strong className="text-slate-900 font-bold">
                    {isBangla ? project.location_bn || project.location : project.location}
                  </strong>
                </span>
              </div>
              <span className="text-[11px] font-mono text-slate-400">
                GPS Verified • Sub-Registry Jurisdiction
              </span>
            </div>
          </div>
        </div>

        {/* =======================================================================
            RIGHT COLUMN (5 COLS - BALANCED COMPACT DECISION SUITE)
            ======================================================================= */}
        <div className="lg:col-span-5 space-y-6">
          {/* Card 1: Calculator Widget */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-xl p-5 sm:p-6 space-y-5 relative overflow-hidden transition-all duration-300">
            <div className="absolute top-0 left-0 right-0 h-1 bg-[#0066FF]" />

            <div className="flex items-center gap-2 pb-2 border-b border-slate-100">
              <Calculator className="w-5 h-5 text-[#0066FF]" />
              <h3 className="font-bold text-slate-900 text-base">
                {isUpcoming
                  ? isBangla ? "প্রি-বুকিং লট হিসাব" : "Pre-Booking Estimate"
                  : isBangla ? "আপনার বিনিয়োগ হিসাব করুন" : "Calculate Investment"}
              </h3>
            </div>

            {/* Stepper Control */}
            <div className="space-y-3">
              <span className="text-xs font-semibold text-slate-600 block">
                {isBangla ? "শেয়ারের সংখ্যা নির্বাচন করুন:" : "Select Number of Shares:"}
              </span>

              <div className="flex items-center justify-between p-2.5 rounded-2xl bg-slate-50 border border-slate-200">
                <div className="flex items-center gap-2">
                  <button
                    type="button"
                    onClick={handleDecrement}
                    disabled={shares <= minShares}
                    className="w-9 h-9 rounded-xl bg-white border border-slate-200 hover:bg-slate-100 font-black text-slate-700 flex items-center justify-center transition-all cursor-pointer disabled:opacity-30 disabled:cursor-not-allowed shadow-2xs"
                  >
                    -
                  </button>
                  <span className="w-8 text-center font-black text-slate-900 text-base font-mono">
                    {shares}
                  </span>
                  <button
                    type="button"
                    onClick={handleIncrement}
                    disabled={shares >= maxShares}
                    className="w-9 h-9 rounded-xl bg-white border border-slate-200 hover:bg-slate-100 font-black text-slate-700 flex items-center justify-center transition-all cursor-pointer disabled:opacity-30 disabled:cursor-not-allowed shadow-2xs"
                  >
                    +
                  </button>
                </div>

                <div className="text-right">
                  <span className="text-base sm:text-lg font-black text-[#0066FF] font-mono block">
                    = {formatBDT(totalAmount, { isBangla })}
                  </span>
                </div>
              </div>
            </div>

            {/* Mini Breakdown Box */}
            <div className="grid grid-cols-2 gap-2 p-3 rounded-xl bg-blue-50/50 border border-blue-100 text-xs">
              <div>
                <span className="text-slate-500 text-[10px] block font-medium">
                  {isBangla ? "প্রতি শেয়ার:" : "Per Share:"}
                </span>
                <span className="font-bold text-slate-800">
                  {formatBDT(pricePerShare, { isBangla })}
                </span>
              </div>
              <div className="text-right">
                <span className="text-slate-500 text-[10px] block font-medium">
                  {isBangla ? "মোট বিনিয়োগ:" : "Total Investment:"}
                </span>
                <span className="font-black text-[#0066FF]">
                  {formatBDT(totalAmount, { isBangla })}
                </span>
              </div>
            </div>

            {/* Direct Investment CTA Button */}
            <Link
              href={investUrl}
              className="w-full py-3 px-4 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-black text-xs sm:text-sm flex items-center justify-center gap-2 shadow-md shadow-[#0066FF]/25 transition-all cursor-pointer hover:scale-[1.01]"
            >
              <span>
                {isUpcoming
                  ? isBangla ? "প্রি-বুকিং / আগ্রহ প্রকাশ করুন →" : "Pre-Book / Express Interest →"
                  : isBangla ? "এখনই বিনিয়োগ করুন →" : "Invest Now →"}
              </span>
            </Link>
          </div>

          {/* Card 2: Quick Facts */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-sm p-5 sm:p-6 space-y-4">
            <div className="flex items-center gap-2 pb-2 border-b border-slate-100">
              <ClipboardList className="w-4 h-4 text-[#0066FF]" />
              <h3 className="font-bold text-slate-900 text-sm sm:text-base">
                {isBangla ? "প্রকল্পের সংক্ষিপ্ত তথ্য" : "Quick Facts"}
              </h3>
            </div>

            <div className="space-y-2.5 text-xs">
              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <Calendar className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "প্রকল্পের নাম:" : "Project Name:"}</span>
                </span>
                <span className="font-bold text-slate-900">{project.name}</span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <MapPin className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "লোকেশন:" : "Location:"}</span>
                </span>
                <span className="font-bold text-slate-900">{project.location_bn || project.location}</span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <PieChart className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "মোট শেয়ার:" : "Total Shares:"}</span>
                </span>
                <span className="font-bold text-slate-900 font-mono">{totalShares} {isBangla ? "টি" : "Units"}</span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <Coins className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "প্রতি শেয়ার:" : "Per Share:"}</span>
                </span>
                <span className="font-black text-[#0066FF] font-mono">{formatBDT(pricePerShare, { isBangla })}</span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <TrendingUp className="w-3.5 h-3.5 text-emerald-600" />
                  <span>{isBangla ? "প্রত্যাশিত ROI:" : "Target ROI:"}</span>
                </span>
                <span className="font-bold text-emerald-600 font-mono">{project.projected_roi_min}% - {project.projected_roi_max}%</span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <Clock className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "মেয়াদ:" : "Duration:"}</span>
                </span>
                <span className="font-bold text-slate-900">
                  {project.tenure || (isBangla ? "৩ - ৫ বছর (আনুমানিক)" : "3 - 5 Years")}
                </span>
              </div>

              <div className="flex items-center justify-between py-1 border-b border-slate-50">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <FileText className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "বিনিয়োগের ধরন:" : "Investment Type:"}</span>
                </span>
                <span className="font-bold text-slate-900">
                  {project.investment_type || (isBangla ? "প্রফিট শেয়ার" : "Profit Sharing")}
                </span>
              </div>

              <div className="flex items-center justify-between py-1">
                <span className="text-slate-500 flex items-center gap-1.5 font-medium">
                  <ShieldCheck className="w-3.5 h-3.5 text-slate-400" />
                  <span>{isBangla ? "ঝুঁকি:" : "Risk Profile:"}</span>
                </span>
                <span className="font-bold text-slate-900">
                  {project.risk_level || (isBangla ? "বাজার পরিস্থিতি অনুসারে" : "Market Dependent")}
                </span>
              </div>
            </div>
          </div>

          {/* Card 3: Documents */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-sm p-5 sm:p-6 space-y-4">
            <div className="flex items-center justify-between pb-2 border-b border-slate-100">
              <div className="flex items-center gap-2">
                <FolderDown className="w-4 h-4 text-[#0066FF]" />
                <h3 className="font-bold text-slate-900 text-sm sm:text-base">
                  {isBangla ? "ডকুমেন্টস" : "Legal Documents"}
                </h3>
              </div>
              <Link href="/documents" className="text-xs font-bold text-[#0066FF] hover:underline">
                {isBangla ? "সব দেখুন" : "View All"}
              </Link>
            </div>

            <div className="space-y-2">
              {docList.map((doc, i) => (
                <div
                  key={i}
                  className="p-2.5 rounded-xl bg-slate-50 border border-slate-200/80 flex items-center justify-between text-xs hover:bg-blue-50/50 transition-colors"
                >
                  <div className="flex items-center gap-2 min-w-0">
                    <FileText className="w-4 h-4 text-red-500 shrink-0" />
                    <span className="font-bold text-slate-800 truncate">{doc.title}</span>
                  </div>
                  <button
                    type="button"
                    onClick={() => alert(`Downloading verified document:\n${doc.title}`)}
                    className="w-7 h-7 rounded-lg bg-white border border-slate-200 text-slate-600 hover:text-[#0066FF] flex items-center justify-center shrink-0 shadow-2xs transition-all cursor-pointer"
                  >
                    <Download className="w-3.5 h-3.5" />
                  </button>
                </div>
              ))}
            </div>
          </div>

          {/* Card 4: Bank Escrow & Fiduciary Safety Guarantee */}
          <div className="bg-gradient-to-br from-[#0A2540] to-[#040D1A] rounded-3xl p-5 sm:p-6 text-white space-y-4 shadow-lg border border-slate-800">
            <div className="flex items-center gap-2.5 pb-2 border-b border-white/10">
              <div className="w-8 h-8 rounded-xl bg-cyan-500/20 text-cyan-400 flex items-center justify-center shrink-0">
                <Landmark className="w-4 h-4" />
              </div>
              <div>
                <h3 className="font-bold text-sm sm:text-base text-white">
                  {isBangla ? "ব্যাংক এসক্রো ও নিরাপত্তা নিশ্চয়তা" : "Bank Escrow & Investor Protection"}
                </h3>
                <span className="text-[10px] text-cyan-300 font-mono">The City Bank PLC • Segregated Account</span>
              </div>
            </div>

            <div className="space-y-2.5 text-xs text-slate-300">
              <div className="flex items-start gap-2">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400 shrink-0 mt-0.5" />
                <span className="leading-snug">
                  {isBangla
                    ? "সকল সাবস্ক্রিপশন তহবিল সরাসরি দ্য সিটি ব্যাংক পিএলসি এসক্রো অ্যাকাউন্টে সংরক্ষিত থাকে।"
                    : "All investor subscriptions held securely in segregated City Bank PLC escrow account."}
                </span>
              </div>
              <div className="flex items-start gap-2">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400 shrink-0 mt-0.5" />
                <span className="leading-snug">
                  {isBangla
                    ? "আইনি দলিল ও রেজিস্ট্রি যাচাইয়ের পরেই কেবল ধাপে ধাপে ফান্ড রিলিজ করা হয়।"
                    : "Funds released strictly milestone-by-milestone upon verified sub-registry execution."}
                </span>
              </div>
              <div className="flex items-start gap-2">
                <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400 shrink-0 mt-0.5" />
                <span className="leading-snug">
                  {isBangla
                    ? "ন্যূনতম শেয়ার লক্ষ্যমাত্রা অপূর্ণ থাকলে ১০০% মূলধন সরাসরি ফেরত পাওয়ার নিশ্চয়তা।"
                    : "100% principal refund protection if subscription threshold is not fully met."}
                </span>
              </div>
            </div>
          </div>

          {/* Card 5: Guided Site Visit Booking & Advisor Support */}
          <div className="bg-white rounded-3xl border border-slate-200 shadow-sm p-5 sm:p-6 space-y-4">
            <div className="flex items-center gap-2.5 pb-2 border-b border-slate-100">
              <div className="w-8 h-8 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center shrink-0">
                <Phone className="w-4 h-4" />
              </div>
              <div>
                <h3 className="font-bold text-slate-900 text-sm sm:text-base">
                  {isBangla ? "সাইট ভিজিট ও বিনিয়োগ পরামর্শ" : "Guided Site Visit & Advisory"}
                </h3>
                <span className="text-[10px] text-slate-500 font-medium">
                  {isBangla ? "সরাসরি প্রতিনিধি ও সাইট পরিদর্শন" : "Free chauffeur visit & advisor hotline"}
                </span>
              </div>
            </div>

            <p className="text-xs text-slate-600 leading-relaxed">
              {isBangla
                ? "বিনিয়োগের পূর্বে স্বচক্ষে জমি দেখতে চান? প্রতি শুক্র ও শনিবার আমাদের নিজস্ব ব্যবস্থাপনায় বিনামূল্যে সাইট পরিদর্শনের সুবিধা রয়েছে।"
                : "Want to inspect the site before investing? We organize complimentary chauffeur-guided site tours every Friday and Saturday."}
            </p>

            <div className="grid grid-cols-2 gap-2 pt-1">
              <a
                href="https://wa.me/8801700000000?text=Hello%20I%20am%20interested%20in%20a%20site%20visit"
                target="_blank"
                rel="noopener noreferrer"
                className="py-2.5 px-3 rounded-xl bg-emerald-50 hover:bg-emerald-100 text-emerald-700 font-bold text-xs flex items-center justify-center gap-1.5 border border-emerald-200/70 transition-all cursor-pointer"
              >
                <MessageCircle className="w-3.5 h-3.5 text-emerald-600" />
                <span>{isBangla ? "হোয়াটসঅ্যাপ" : "WhatsApp"}</span>
              </a>
              <a
                href="tel:+8801700000000"
                className="py-2.5 px-3 rounded-xl bg-blue-50 hover:bg-blue-100 text-[#0066FF] font-bold text-xs flex items-center justify-center gap-1.5 border border-blue-200/70 transition-all cursor-pointer"
              >
                <Phone className="w-3.5 h-3.5 text-[#0066FF]" />
                <span>{isBangla ? "হটলাইন কল" : "Call Advisor"}</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      {/* =========================================================================
          4. FULL-WIDTH PROJECT POTENTIAL & VISUAL GALLERY SHOWCASE (12 COLS)
          ========================================================================= */}
      <div className="w-full bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-6 shadow-sm">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-100">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center shrink-0">
              <ImageIcon className="w-5 h-5" />
            </div>
            <div>
              <h3 className="text-lg sm:text-xl font-black text-slate-900 tracking-tight">
                {isBangla ? "প্রকল্পের সম্ভাব্য চিত্র ও গ্যালারি" : "Project Potential & Visual Gallery"}
              </h3>
              <p className="text-xs text-slate-500 mt-0.5">
                {isBangla
                  ? "জমির বর্তমান অবস্থা, অবকাঠামোগত অগ্রগতি ও ভবিষ্যৎ রূপরেখা"
                  : "Current site condition, infrastructure progress, and development masterplan"}
              </p>
            </div>
          </div>

          {/* Slider Nav Controls */}
          <div className="flex items-center gap-2 self-start sm:self-auto">
            <span className="text-xs font-mono font-bold text-slate-600 bg-slate-100 px-3 py-1.5 rounded-xl border border-slate-200">
              {activeSlide + 1} / {galleryList.length}
            </span>
            <button
              type="button"
              onClick={prevSlide}
              className="w-9 h-9 rounded-full border border-slate-200 bg-white hover:bg-slate-50 flex items-center justify-center text-slate-700 transition-all cursor-pointer hover:border-[#0066FF] hover:text-[#0066FF] shadow-2xs"
              aria-label="Previous slide"
            >
              <ChevronLeft className="w-4 h-4" />
            </button>
            <button
              type="button"
              onClick={nextSlide}
              className="w-9 h-9 rounded-full border border-slate-200 bg-white hover:bg-slate-50 flex items-center justify-center text-slate-700 transition-all cursor-pointer hover:border-[#0066FF] hover:text-[#0066FF] shadow-2xs"
              aria-label="Next slide"
            >
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Featured Cinema-Stage Image (Wide Full Width) */}
        <div className="relative rounded-2xl overflow-hidden border border-slate-200 shadow-md h-72 sm:h-96 lg:h-[460px] bg-slate-950 group">
          <img
            src={galleryList[activeSlide]?.image_url}
            alt={galleryList[activeSlide]?.title}
            className="w-full h-full object-cover transition-all duration-500 group-hover:scale-105"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-slate-950/85 via-transparent to-transparent pointer-events-none" />

          {/* Title & Badge Overlay */}
          <div className="absolute bottom-4 sm:bottom-6 left-4 sm:left-6 right-4 sm:right-6 flex items-center justify-between pointer-events-none">
            <div className="px-4 py-2 rounded-xl bg-black/70 backdrop-blur-md text-xs sm:text-sm font-bold text-white shadow-lg border border-white/20">
              <span>{galleryList[activeSlide]?.title}</span>
            </div>
            <span className="hidden sm:inline px-3 py-1.5 rounded-xl bg-white/20 backdrop-blur-md text-xs font-mono font-bold text-white border border-white/30">
              Slide {activeSlide + 1} of {galleryList.length}
            </span>
          </div>

          {/* Prev / Next On-Image Buttons */}
          <button
            type="button"
            onClick={prevSlide}
            className="absolute left-3 sm:left-5 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-black/50 hover:bg-black/80 text-white backdrop-blur-md flex items-center justify-center transition-all cursor-pointer opacity-80 hover:opacity-100 shadow-lg"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>
          <button
            type="button"
            onClick={nextSlide}
            className="absolute right-3 sm:right-5 top-1/2 -translate-y-1/2 w-10 h-10 rounded-full bg-black/50 hover:bg-black/80 text-white backdrop-blur-md flex items-center justify-center transition-all cursor-pointer opacity-80 hover:opacity-100 shadow-lg"
          >
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>

        {/* Interactive Thumbnail Strip */}
        <div className="grid grid-cols-3 gap-3 sm:gap-4 pt-1">
          {galleryList.map((item, idx) => (
            <button
              key={idx}
              type="button"
              onClick={() => setActiveSlide(idx)}
              className={`relative rounded-2xl overflow-hidden border-2 transition-all h-20 sm:h-28 group cursor-pointer text-left ${
                activeSlide === idx
                  ? "border-[#0066FF] shadow-md ring-2 ring-[#0066FF]/25 scale-[1.01]"
                  : "border-slate-200 opacity-70 hover:opacity-100"
              }`}
            >
              <img
                src={item.image_url}
                alt={item.title}
                className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
              <div className="absolute bottom-2 left-2 right-2">
                <span className="px-2 py-0.5 rounded bg-black/60 backdrop-blur-xs text-[11px] font-bold text-white block text-center truncate">
                  {item.title}
                </span>
              </div>
            </button>
          ))}
        </div>

        {/* Pagination Dots */}
        <div className="flex items-center justify-center gap-1.5 pt-1">
          {galleryList.map((_, i) => (
            <button
              key={i}
              type="button"
              onClick={() => setActiveSlide(i)}
              className={`h-2 rounded-full transition-all cursor-pointer ${
                activeSlide === i ? "w-6 bg-[#0066FF]" : "w-2 bg-slate-200 hover:bg-slate-300"
              }`}
            />
          ))}
        </div>
      </div>

      {/* =========================================================================
          5. FULL-WIDTH PROJECT ROADMAP & KEY MILESTONES (12 COLS)
          ========================================================================= */}
      {project.milestones && project.milestones.length > 0 && (
        <div className="w-full bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 space-y-6 shadow-sm">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-100">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-blue-100 text-[#0066FF] flex items-center justify-center shrink-0">
                <Clock className="w-5 h-5" />
              </div>
              <div>
                <h3 className="text-lg sm:text-xl font-black text-slate-900 tracking-tight">
                  {isBangla ? "প্রকল্পের রোডম্যাপ ও মাইলস্টোন" : "Project Roadmap & Key Milestones"}
                </h3>
                <p className="text-xs text-slate-500 mt-0.5">
                  {isBangla
                    ? "বাস্তবায়নের প্রতিটি ধাপ, ভূমি নিবন্ধন এবং হস্তান্তর সময়সীমা"
                    : "Transparent execution milestones, land registration, and handover timeline"}
                </p>
              </div>
            </div>
            <span className="px-3.5 py-1.5 rounded-full text-xs font-bold bg-blue-50 text-[#0066FF] border border-blue-200/60 self-start sm:self-auto">
              {project.milestones.length} {isBangla ? "টি ধাপ বাস্তবায়নাধীন" : "Execution Phases"}
            </span>
          </div>

          {/* Responsive Multi-Column Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 pt-1">
            {project.milestones.map((m, idx) => (
              <div
                key={m.id || idx}
                className="bg-slate-50/90 hover:bg-white rounded-2xl p-5 border border-slate-200/80 hover:border-blue-200 shadow-2xs hover:shadow-sm transition-all flex flex-col justify-between space-y-3"
              >
                <div className="space-y-2.5">
                  <div className="flex items-center justify-between gap-2">
                    <div className="flex items-center gap-2">
                      <div
                        className={`w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold shrink-0 ${
                          m.is_completed
                            ? "bg-emerald-100 text-emerald-700 border border-emerald-300"
                            : "bg-blue-100 text-[#0066FF] border border-blue-200"
                        }`}
                      >
                        {m.is_completed ? (
                          <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                        ) : (
                          <span>{m.sequence || idx + 1}</span>
                        )}
                      </div>
                      <span className="text-[11px] font-mono font-bold text-slate-400 uppercase">
                        {isBangla ? `ধাপ 0${idx + 1}` : `Phase 0${idx + 1}`}
                      </span>
                    </div>

                    {m.is_completed ? (
                      <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">
                        {isBangla ? "সম্পন্ন" : "Completed"}
                      </span>
                    ) : (
                      <span className="px-2.5 py-0.5 rounded-full text-[10px] font-bold bg-amber-100 text-amber-800">
                        {isBangla ? "চলমান / পরিকল্পিত" : "In Progress"}
                      </span>
                    )}
                  </div>

                  <h4 className="text-sm sm:text-base font-black text-slate-900 leading-snug">
                    {isBangla ? m.title_bn || m.title : m.title}
                  </h4>

                  {(m.description_bn || m.description) && (
                    <p className="text-xs text-slate-600 leading-relaxed">
                      {isBangla ? m.description_bn || m.description : m.description}
                    </p>
                  )}
                </div>

                {m.milestone_date && (
                  <div className="pt-2 border-t border-slate-200/60 flex items-center gap-1.5 text-[11px] text-slate-500 font-medium">
                    <Calendar className="w-3.5 h-3.5 text-slate-400" />
                    <span>{m.milestone_date}</span>
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* =========================================================================
          6. RETAINED INSTITUTIONAL TRANSPARENCY MODULES
          ========================================================================= */}
      <section className="space-y-6 pt-4">
        <ShareMatrixGrid
          totalShares={totalShares}
          allocatedShares={allocatedShares}
          pricePerShare={pricePerShare}
          projectName={project.name}
          projectNameBn={project.name_bn}
          projectCode={project.code}
        />
        <TransparencyLedger />
      </section>

      {/* =========================================================================
          7. BOTTOM CONVERSION BANNER
          ========================================================================= */}
      <div className="rounded-3xl bg-gradient-to-r from-emerald-50 via-teal-50 to-blue-50 border border-emerald-200/60 p-6 sm:p-8 flex flex-col md:flex-row items-center justify-between gap-6 shadow-sm">
        <div className="flex flex-col sm:flex-row items-center gap-4 text-center sm:text-left">
          <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-2xl overflow-hidden border-2 border-white shadow-md shrink-0">
            <img
              src="/images/seedling_growth.jpg"
              alt="Growth"
              className="w-full h-full object-cover"
            />
          </div>
          <div className="space-y-1">
            <h3 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight">
              {project.bottom_cta_title || (isBangla ? "আপনার টাকারও একটি স্বপ্ন আছে" : "Your capital deserves to grow")}
            </h3>
            <p className="text-xs sm:text-sm text-slate-600 font-medium">
              {project.bottom_cta_subtitle || (isBangla ? "চলুন, একসাথে গড়ি নিরাপদ ভবিষ্যৎ।" : "Together, building a secure and transparent future.")}
            </p>
          </div>
        </div>

        <div className="flex flex-col items-center sm:items-end gap-1.5 shrink-0">
          <Link
            href={investUrl}
            className="px-8 py-3.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-black text-xs sm:text-sm shadow-md shadow-[#0066FF]/25 flex items-center gap-2 transition-all cursor-pointer hover:scale-[1.02]"
          >
            <span>
              {isUpcoming
                ? isBangla ? "প্রি-বুকিং / আগ্রহ প্রকাশ করুন →" : "Pre-Book / Express Interest →"
                : isBangla ? "এখনই বিনিয়োগ করুন →" : "Invest Now →"}
            </span>
          </Link>
          <span className="text-[11px] text-slate-500 font-medium">
            💙 {isBangla ? "একটি ছোট সিদ্ধান্ত, একটি বড় পরিবর্তনের শুরু" : "One small decision, beginning of a big change"}
          </span>
        </div>
      </div>
    </div>
  );
}
