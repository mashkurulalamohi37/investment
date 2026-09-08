"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
import { Project, ProjectGalleryItem, ProjectDocumentItem } from "@/types/api";
import {
  Layers,
  PlusCircle,
  Building2,
  CheckCircle2,
  MapPin,
  Clock,
  Sprout,
  Users,
  Edit,
  ArrowRight,
  Sparkles,
  TrendingUp,
  ExternalLink,
  Settings2,
  FileText,
  Image as ImageIcon,
  Save,
  X,
  ShieldCheck,
  Coins,
  PieChart,
} from "lucide-react";

export default function AdminProjectsPage() {
  const { isBangla } = useAuth();

  const [projects, setProjects] = useState<Project[]>([]);
  const [loading, setLoading] = useState(true);

  // New Project Modal State
  const [showCreateModal, setShowCreateModal] = useState(false);

  // CMS Edit Modal State
  const [editingProject, setEditingProject] = useState<Project | null>(null);
  const [cmsTab, setCmsTab] = useState<"GENERAL" | "HERO" | "FINANCIALS" | "MEDIA" | "DOCS">("GENERAL");
  const [savingCms, setSavingCms] = useState(false);
  const [saveSuccess, setSaveSuccess] = useState(false);

  // Create Form State
  const [name, setName] = useState("");
  const [code, setCode] = useState("");
  const [category, setCategory] = useState<"REAL_ESTATE" | "AGRICULTURAL" | "COMMERCIAL">("REAL_ESTATE");
  const [location, setLocation] = useState("");
  const [targetFund, setTargetFund] = useState("");
  const [totalShares, setTotalShares] = useState("100");
  const [pricePerShare, setPricePerShare] = useState("");
  const [roiMin, setRoiMin] = useState("18.0");
  const [roiMax, setRoiMax] = useState("22.0");

  const fetchProjects = async () => {
    try {
      setLoading(true);
      const res = await fetch("/api/projects");
      const json = await res.json();
      if (json.success && json.data) {
        setProjects(json.data);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProjects();
  }, []);

  const handleCreateProject = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const res = await fetch("/api/projects", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name,
          name_bn: name,
          code: code.toUpperCase() || "NEW-01",
          category,
          location,
          location_bn: location,
          target_fund: parseFloat(targetFund) || 2000000,
          price_per_share: parseFloat(pricePerShare) || 20000,
          total_shares: parseInt(totalShares, 10) || 100,
          projected_roi_min: parseFloat(roiMin) || 18,
          projected_roi_max: parseFloat(roiMax) || 22,
          status: "OPEN",
          hero_quote: "ছোট বিনিয়োগ, বড় ভবিষ্যৎ...",
          hero_tagline: "আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা",
          hero_image_url: "/images/landvest_hero.jpg",
          map_image_url: "/images/washpur_map.svg",
        }),
      });
      const data = await res.json();
      if (data.success) {
        setShowCreateModal(false);
        setName("");
        setCode("");
        setLocation("");
        setTargetFund("");
        setPricePerShare("");
        fetchProjects();
      }
    } catch (err) {
      console.error("Create project error:", err);
    }
  };

  const handleSaveCMS = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingProject) return;

    setSavingCms(true);
    setSaveSuccess(false);

    try {
      const res = await fetch(`/api/projects/${editingProject.id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(editingProject),
      });
      const data = await res.json();
      if (data.success) {
        setSaveSuccess(true);
        fetchProjects();
        setTimeout(() => setSaveSuccess(false), 3000);
      }
    } catch (err) {
      console.error("Failed to save project CMS:", err);
    } finally {
      setSavingCms(false);
    }
  };

  return (
    <div className="space-y-4 sm:space-y-5 font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? `মোট ${projects.length}টি প্রজেক্ট` : `${projects.length} TOTAL PROJECTS`}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
              {isBangla ? "CMS কনফিগারেশন সক্রিয়" : "CMS CONTROL ACTIVE"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "প্রজেক্ট স্পেকট্রাম ও CMS কনটেন্ট ম্যানেজার" : "Project Spectrum & CMS Content Manager"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "প্রজেক্টের তথ্য, ল্যান্ডস্কেপ হিরো ব্যানার, আর্থিক প্যারামিটার ও ডকুমেন্ট সরাসরি কাস্টমাইজ করুন"
              : "Manage per-project dynamic landing pages, hero banners, financial parameters, and legal documents"}
          </p>
        </div>

        <button
          onClick={() => setShowCreateModal(true)}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-4 h-4 text-white" />
          <span>{isBangla ? "নতুন প্রজেক্ট তৈরি করুন" : "Launch New Project"}</span>
        </button>
      </div>

      {/* Projects Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {loading ? (
          <div className="col-span-full py-12 text-center text-slate-400 text-xs">
            Loading project spectrum...
          </div>
        ) : (
          projects.map((proj) => {
            const price = Number(proj.price_per_share) || 25500;
            const target = Number(proj.target_fund) || 2550000;
            const total = Number(proj.total_shares) || 100;
            const allocated = Number(proj.allocated_shares) || 0;
            const available = Math.max(0, total - allocated);
            const progress = Math.round((allocated / total) * 100);

            return (
              <div
                key={proj.id}
                className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-5 flex flex-col justify-between space-y-4 hover:border-slate-300 transition-all group"
              >
                <div className="space-y-3">
                  {/* Top Badges */}
                  <div className="flex items-center justify-between">
                    <span className="font-mono text-xs font-bold text-[#0066FF] bg-blue-50 border border-blue-200/60 px-2 py-0.5 rounded-md">
                      {proj.code}
                    </span>
                    <span
                      className={`text-[10px] font-bold px-2 py-0.5 rounded-full border ${
                        proj.status === "OPEN"
                          ? "bg-emerald-50 text-emerald-700 border-emerald-200"
                          : "bg-slate-100 text-slate-600 border-slate-200"
                      }`}
                    >
                      {proj.status === "OPEN"
                        ? isBangla ? "চলমান" : "Open"
                        : isBangla ? "আসন্ন / বন্ধ" : proj.status}
                    </span>
                  </div>

                  {/* Title & Location */}
                  <div>
                    <h3 className="font-bold text-slate-900 text-base group-hover:text-[#0066FF] transition-colors line-clamp-1">
                      {isBangla ? proj.name_bn || proj.name : proj.name}
                    </h3>
                    <p className="text-xs text-slate-500 flex items-center gap-1 mt-0.5 truncate">
                      <MapPin className="w-3 h-3 text-slate-400 shrink-0" />
                      <span>{isBangla ? proj.location_bn || proj.location : proj.location}</span>
                    </p>
                  </div>

                  {/* Share Progress */}
                  <div className="space-y-1">
                    <div className="flex items-center justify-between text-[11px] text-slate-500 font-medium">
                      <span>{isBangla ? "বিক্রি অগ্রগতি:" : "Subscription:"}</span>
                      <span className="font-mono font-bold text-slate-900">{allocated} / {total} ({progress}%)</span>
                    </div>
                    <div className="h-1.5 rounded-full bg-slate-100 overflow-hidden">
                      <div
                        className="h-full bg-gradient-to-r from-[#0066FF] to-cyan rounded-full"
                        style={{ width: `${progress}%` }}
                      />
                    </div>
                  </div>

                  {/* Financial Mini Grid */}
                  <div className="grid grid-cols-2 gap-2 pt-2 border-t border-slate-100 text-xs">
                    <div>
                      <span className="text-slate-400 text-[10px] block">
                        {isBangla ? "প্রতি শেয়ার:" : "Per Share:"}
                      </span>
                      <span className="font-bold text-[#0066FF] block font-mono">
                        {formatBDT(price, { isBangla })}
                      </span>
                    </div>
                    <div>
                      <span className="text-slate-400 text-[10px] block">
                        {isBangla ? "প্রত্যাশিত ROI:" : "Target ROI:"}
                      </span>
                      <span className="font-bold text-emerald-600 block font-mono">
                        {proj.projected_roi_min}% - {proj.projected_roi_max}%
                      </span>
                    </div>
                  </div>
                </div>

                {/* Bottom Action Bar */}
                <div className="pt-3 border-t border-slate-100 flex items-center justify-between gap-2">
                  <button
                    type="button"
                    onClick={() => {
                      setEditingProject({ ...proj });
                      setCmsTab("GENERAL");
                    }}
                    className="flex-1 py-2 px-3 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold text-xs flex items-center justify-center gap-1.5 transition-all cursor-pointer"
                  >
                    <Settings2 className="w-3.5 h-3.5 text-[#0066FF]" />
                    <span>{isBangla ? "CMS কন্ট্রোল / এডিট" : "CMS Control"}</span>
                  </button>

                  <Link
                    href={`/projects/${proj.code || proj.id}`}
                    target="_blank"
                    className="p-2 rounded-xl bg-blue-50 hover:bg-blue-100 text-[#0066FF] border border-blue-200 transition-all cursor-pointer"
                    title={isBangla ? "লাইভ পেজ দেখুন" : "View Live Page"}
                  >
                    <ExternalLink className="w-4 h-4" />
                  </Link>
                </div>
              </div>
            );
          })
        )}
      </div>

      {/* =======================================================================
          CMS EDIT MODAL (Comprehensive per-project content manager)
          ======================================================================= */}
      {editingProject && (
        <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-xs flex items-center justify-center p-3 sm:p-4 overflow-y-auto">
          <div className="bg-white border border-slate-200 shadow-2xl rounded-3xl max-w-3xl w-full p-5 sm:p-7 space-y-5 my-8">
            {/* Modal Header */}
            <div className="flex items-center justify-between pb-3 border-b border-slate-100">
              <div className="flex items-center gap-2.5">
                <div className="w-9 h-9 rounded-xl bg-blue-50 text-[#0066FF] flex items-center justify-center">
                  <Settings2 className="w-5 h-5" />
                </div>
                <div>
                  <h2 className="text-base sm:text-lg font-black text-slate-900">
                    {isBangla ? "প্রজেক্ট CMS কন্ট্রোল প্যানেল" : "Project CMS Content Studio"}
                  </h2>
                  <p className="text-[11px] text-slate-500 font-mono">
                    {editingProject.name} ({editingProject.code})
                  </p>
                </div>
              </div>

              <button
                onClick={() => setEditingProject(null)}
                className="w-8 h-8 rounded-full hover:bg-slate-100 text-slate-400 hover:text-slate-700 flex items-center justify-center cursor-pointer transition-all"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            {/* Tab Navigation */}
            <div className="flex flex-wrap gap-1.5 p-1 bg-slate-100 rounded-xl text-xs font-bold">
              <button
                type="button"
                onClick={() => setCmsTab("GENERAL")}
                className={`px-3 py-1.5 rounded-lg transition-all cursor-pointer ${
                  cmsTab === "GENERAL" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
                }`}
              >
                {isBangla ? "১. বেসিক তথ্য" : "1. General Info"}
              </button>
              <button
                type="button"
                onClick={() => setCmsTab("HERO")}
                className={`px-3 py-1.5 rounded-lg transition-all cursor-pointer ${
                  cmsTab === "HERO" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
                }`}
              >
                {isBangla ? "২. হিরো ও স্লোগান" : "2. Hero & Slogans"}
              </button>
              <button
                type="button"
                onClick={() => setCmsTab("FINANCIALS")}
                className={`px-3 py-1.5 rounded-lg transition-all cursor-pointer ${
                  cmsTab === "FINANCIALS" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
                }`}
              >
                {isBangla ? "৩. শেয়ার ও মেট্রিক্স" : "3. Financials & Units"}
              </button>
              <button
                type="button"
                onClick={() => setCmsTab("MEDIA")}
                className={`px-3 py-1.5 rounded-lg transition-all cursor-pointer ${
                  cmsTab === "MEDIA" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
                }`}
              >
                {isBangla ? "৪. গ্যালারি ও ছবি" : "4. Gallery Media"}
              </button>
              <button
                type="button"
                onClick={() => setCmsTab("DOCS")}
                className={`px-3 py-1.5 rounded-lg transition-all cursor-pointer ${
                  cmsTab === "DOCS" ? "bg-white text-[#0066FF] shadow-xs" : "text-slate-600 hover:text-slate-900"
                }`}
              >
                {isBangla ? "৫. ডকুমেন্টস (PDF)" : "5. Legal Docs"}
              </button>
            </div>

            {/* CMS Form Body */}
            <form onSubmit={handleSaveCMS} className="space-y-4 text-xs">
              {/* TAB 1: GENERAL INFO */}
              {cmsTab === "GENERAL" && (
                <div className="space-y-3">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "প্রকল্পের নাম (English) *" : "Project Name (English) *"}
                      </label>
                      <input
                        type="text"
                        required
                        value={editingProject.name}
                        onChange={(e) => setEditingProject({ ...editingProject, name: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "প্রকল্পের নাম (বাংলা) *" : "Project Name (Bangla) *"}
                      </label>
                      <input
                        type="text"
                        required
                        value={editingProject.name_bn || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, name_bn: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "প্রজেক্ট কোড *" : "Project Code *"}
                      </label>
                      <input
                        type="text"
                        required
                        value={editingProject.code}
                        onChange={(e) => setEditingProject({ ...editingProject, code: e.target.value.toUpperCase() })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono uppercase focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "ক্যাটাগরি" : "Category"}
                      </label>
                      <select
                        value={editingProject.category}
                        onChange={(e) => setEditingProject({ ...editingProject, category: e.target.value as any })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      >
                        <option value="REAL_ESTATE">Real Estate / Land</option>
                        <option value="AGRICULTURAL">Agricultural / Agro</option>
                        <option value="COMMERCIAL">Commercial Venture</option>
                      </select>
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "স্ট্যাটাস" : "Status"}
                      </label>
                      <select
                        value={editingProject.status}
                        onChange={(e) => setEditingProject({ ...editingProject, status: e.target.value as any })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      >
                        <option value="OPEN">OPEN (চলমান)</option>
                        <option value="UPCOMING">UPCOMING (আসন্ন)</option>
                        <option value="FUNDED">FUNDED (পূর্ণ)</option>
                        <option value="COMPLETED">COMPLETED (সম্পন্ন)</option>
                      </select>
                    </div>
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "লোকেশন (English)" : "Location (English)"}
                      </label>
                      <input
                        type="text"
                        value={editingProject.location}
                        onChange={(e) => setEditingProject({ ...editingProject, location: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "লোকেশন (বাংলা)" : "Location (Bangla)"}
                      </label>
                      <input
                        type="text"
                        value={editingProject.location_bn || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, location_bn: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block font-bold text-slate-700 mb-1">
                      {isBangla ? "গুগল ম্যাপ লিঙ্ক" : "Google Maps URL"}
                    </label>
                    <input
                      type="url"
                      placeholder="https://maps.google.com/..."
                      value={editingProject.map_url || ""}
                      onChange={(e) => setEditingProject({ ...editingProject, map_url: e.target.value })}
                      className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                    />
                  </div>
                </div>
              )}

              {/* TAB 2: HERO & SLOGANS */}
              {cmsTab === "HERO" && (
                <div className="space-y-3">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "হিরো ট্যাগলাইন (উপরে ডান পাশে)" : "Hero Tagline (Top Right)"}
                      </label>
                      <input
                        type="text"
                        placeholder="আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা"
                        value={editingProject.hero_tagline || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, hero_tagline: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "হাইলাইট উদ্ধৃতি (Quote)" : "Highlight Slogan Quote"}
                      </label>
                      <input
                        type="text"
                        placeholder="ছোট বিনিয়োগ, বড় ভবিষ্যৎ..."
                        value={editingProject.hero_quote || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, hero_quote: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block font-bold text-slate-700 mb-1">
                      {isBangla ? "হিরো ল্যান্ডস্কেপ ব্যাকগ্রাউন্ড ছবি (URL)" : "Hero Background Image (URL)"}
                    </label>
                    <input
                      type="text"
                      placeholder="/images/landvest_hero.jpg"
                      value={editingProject.hero_image_url || ""}
                      onChange={(e) => setEditingProject({ ...editingProject, hero_image_url: e.target.value })}
                      className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                    />
                  </div>

                  <div>
                    <label className="block font-bold text-slate-700 mb-1">
                      {isBangla ? "প্রকল্প সম্পর্কে পূর্ণ বিবরণ (বাংলা)" : "About Project Description (Bangla)"}
                    </label>
                    <textarea
                      rows={3}
                      value={editingProject.description_bn || ""}
                      onChange={(e) => setEditingProject({ ...editingProject, description_bn: e.target.value })}
                      className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                    />
                  </div>
                </div>
              )}

              {/* TAB 3: FINANCIALS & UNITS */}
              {cmsTab === "FINANCIALS" && (
                <div className="space-y-3">
                  <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "প্রতি শেয়ার মূল্য (BDT)" : "Share Price (BDT)"}
                      </label>
                      <input
                        type="number"
                        value={editingProject.price_per_share}
                        onChange={(e) => setEditingProject({ ...editingProject, price_per_share: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono font-bold focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "মোট শেয়ার সংখ্যা" : "Total Units"}
                      </label>
                      <input
                        type="number"
                        value={editingProject.total_shares}
                        onChange={(e) => setEditingProject({ ...editingProject, total_shares: Number(e.target.value) })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono font-bold focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "বিক্রি হওয়া শেয়ার" : "Subscribed Units"}
                      </label>
                      <input
                        type="number"
                        value={editingProject.allocated_shares}
                        onChange={(e) => setEditingProject({ ...editingProject, allocated_shares: Number(e.target.value) })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono font-bold focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "মোট মূলধন লক্ষ্য (BDT)" : "Target Fund"}
                      </label>
                      <input
                        type="number"
                        value={editingProject.target_fund}
                        onChange={(e) => setEditingProject({ ...editingProject, target_fund: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono font-bold focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "ROI সর্বনিম্ন (%)" : "Min ROI (%)"}
                      </label>
                      <input
                        type="number"
                        step="0.1"
                        value={editingProject.projected_roi_min}
                        onChange={(e) => setEditingProject({ ...editingProject, projected_roi_min: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "ROI সর্বোচ্চ (%)" : "Max ROI (%)"}
                      </label>
                      <input
                        type="number"
                        step="0.1"
                        value={editingProject.projected_roi_max}
                        onChange={(e) => setEditingProject({ ...editingProject, projected_roi_max: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "প্রকল্প মেয়াদ" : "Tenure / Duration"}
                      </label>
                      <input
                        type="text"
                        placeholder="৩ - ৫ বছর (আনুমানিক)"
                        value={editingProject.tenure || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, tenure: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                    <div>
                      <label className="block font-bold text-slate-700 mb-1">
                        {isBangla ? "বিনিয়োগের ধরন" : "Investment Type"}
                      </label>
                      <input
                        type="text"
                        placeholder="প্রফিট শেয়ার"
                        value={editingProject.investment_type || ""}
                        onChange={(e) => setEditingProject({ ...editingProject, investment_type: e.target.value })}
                        className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-hidden focus:border-[#0066FF]"
                      />
                    </div>
                  </div>
                </div>
              )}

              {/* TAB 4: GALLERY MEDIA */}
              {cmsTab === "MEDIA" && (
                <div className="space-y-3">
                  <p className="text-slate-500 text-[11px]">
                    {isBangla
                      ? "প্রকল্পের গ্যালারি সেকশনে প্রদর্শিত ছবি এবং তাদের লেবেল কনফিগার করুন:"
                      : "Configure the 3 photos and captions shown in the Project Gallery Carousel:"}
                  </p>

                  <div className="space-y-2.5">
                    {[0, 1, 2].map((idx) => {
                      const currentGallery = editingProject.gallery_images || [];
                      const item = currentGallery[idx] || { title: "", image_url: "" };

                      return (
                        <div key={idx} className="p-3 rounded-2xl bg-slate-50 border border-slate-200 grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                          <div>
                            <label className="block text-[10px] font-bold text-slate-600 mb-0.5">
                              {isBangla ? `ছবি #${idx + 1} শিরোনাম` : `Photo #${idx + 1} Caption`}
                            </label>
                            <input
                              type="text"
                              placeholder={idx === 0 ? "বর্তমান জমির অবস্থা" : idx === 1 ? "উন্নয়ন সম্ভাবনা" : "ভবিষ্যতের সম্ভাবনা"}
                              value={item.title}
                              onChange={(e) => {
                                const newArr = [...currentGallery];
                                newArr[idx] = { ...item, title: e.target.value };
                                setEditingProject({ ...editingProject, gallery_images: newArr });
                              }}
                              className="w-full px-2.5 py-1.5 rounded-lg bg-white border border-slate-200 text-xs"
                            />
                          </div>
                          <div>
                            <label className="block text-[10px] font-bold text-slate-600 mb-0.5">
                              {isBangla ? `ছবি #${idx + 1} URL` : `Photo #${idx + 1} URL / Path`}
                            </label>
                            <input
                              type="text"
                              placeholder="/images/gallery_land.jpg"
                              value={item.image_url}
                              onChange={(e) => {
                                const newArr = [...currentGallery];
                                newArr[idx] = { ...item, image_url: e.target.value };
                                setEditingProject({ ...editingProject, gallery_images: newArr });
                              }}
                              className="w-full px-2.5 py-1.5 rounded-lg bg-white border border-slate-200 text-xs"
                            />
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}

              {/* TAB 5: LEGAL DOCS */}
              {cmsTab === "DOCS" && (
                <div className="space-y-3">
                  <p className="text-slate-500 text-[11px]">
                    {isBangla
                      ? "বিনিয়োগকারীদের জন্য ডাউনলোডযোগ্য লিগ্যাল ও তথ্যমূলক PDF ফাইলসমূহ:"
                      : "Configure downloadable legal prospectuses and contracts for investors:"}
                  </p>

                  <div className="space-y-2.5">
                    {[0, 1, 2].map((idx) => {
                      const currentDocs = editingProject.documents || [];
                      const item = currentDocs[idx] || { title: "", file_url: "", type: "PDF" };

                      return (
                        <div key={idx} className="p-3 rounded-2xl bg-slate-50 border border-slate-200 grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                          <div>
                            <label className="block text-[10px] font-bold text-slate-600 mb-0.5">
                              {isBangla ? `ডকুমেন্ট #${idx + 1} নাম` : `Document #${idx + 1} Title`}
                            </label>
                            <input
                              type="text"
                              placeholder={idx === 0 ? "প্রকল্প পরিচিতি (PDF)" : idx === 1 ? "বিনিয়োগ চুক্তি (PDF)" : "FAQ (PDF)"}
                              value={item.title}
                              onChange={(e) => {
                                const newArr = [...currentDocs];
                                newArr[idx] = { ...item, title: e.target.value, type: "PDF" };
                                setEditingProject({ ...editingProject, documents: newArr });
                              }}
                              className="w-full px-2.5 py-1.5 rounded-lg bg-white border border-slate-200 text-xs"
                            />
                          </div>
                          <div>
                            <label className="block text-[10px] font-bold text-slate-600 mb-0.5">
                              {isBangla ? `ডকুমেন্ট #${idx + 1} URL` : `Document #${idx + 1} File URL`}
                            </label>
                            <input
                              type="text"
                              placeholder="/documents/prospectus.pdf"
                              value={item.file_url}
                              onChange={(e) => {
                                const newArr = [...currentDocs];
                                newArr[idx] = { ...item, file_url: e.target.value, type: "PDF" };
                                setEditingProject({ ...editingProject, documents: newArr });
                              }}
                              className="w-full px-2.5 py-1.5 rounded-lg bg-white border border-slate-200 text-xs"
                            />
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}

              {/* Status Message */}
              {saveSuccess && (
                <div className="p-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-800 font-bold flex items-center gap-2">
                  <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                  <span>{isBangla ? "প্রকল্পের CMS তথ্য সফলভাবে আপডেট হয়েছে!" : "Project CMS updated successfully!"}</span>
                </div>
              )}

              {/* Action Buttons */}
              <div className="pt-3 border-t border-slate-100 flex items-center justify-between gap-3">
                <Link
                  href={`/projects/${editingProject.code || editingProject.id}`}
                  target="_blank"
                  className="inline-flex items-center gap-1.5 text-xs font-bold text-[#0066FF] hover:underline"
                >
                  <ExternalLink className="w-3.5 h-3.5" />
                  <span>{isBangla ? "লাইভ পেজ প্রিভিউ করুন ↗" : "Preview Live Page ↗"}</span>
                </Link>

                <div className="flex items-center gap-2">
                  <button
                    type="button"
                    onClick={() => setEditingProject(null)}
                    className="px-4 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 font-bold text-xs text-slate-700 transition-all cursor-pointer"
                  >
                    {isBangla ? "বাতিল" : "Cancel"}
                  </button>

                  <button
                    type="submit"
                    disabled={savingCms}
                    className="px-5 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] font-bold text-xs text-white shadow-sm shadow-[#0066FF]/20 flex items-center gap-1.5 transition-all cursor-pointer disabled:opacity-50"
                  >
                    <Save className="w-3.5 h-3.5" />
                    <span>
                      {savingCms
                        ? isBangla ? "সংরক্ষণ হচ্ছে..." : "Saving..."
                        : isBangla ? "CMS পরিবর্তন সংরক্ষণ করুন" : "Save Changes"}
                    </span>
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* =======================================================================
          LAUNCH NEW PROJECT MODAL
          ======================================================================= */}
      {showCreateModal && (
        <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-white border border-slate-200 shadow-2xl rounded-2xl max-w-lg w-full p-5 sm:p-6 space-y-4">
            <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Sparkles className="w-4 h-4 text-[#0066FF]" />
                <span>{isBangla ? "নতুন প্রজেক্ট তৈরি করুন" : "Launch New Investment Project"}</span>
              </h3>
              <button
                onClick={() => setShowCreateModal(false)}
                className="text-slate-400 hover:text-slate-700 text-base font-bold cursor-pointer"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleCreateProject} className="space-y-3 text-xs font-semibold text-slate-700">
              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "প্রজেক্টের নাম" : "Project Title"}
                </label>
                <input
                  type="text"
                  required
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="e.g. LandVest 200 (Hemayetpur Growth Zone)"
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "প্রজেক্ট কোড" : "Project Code"}
                  </label>
                  <input
                    type="text"
                    required
                    value={code}
                    onChange={(e) => setCode(e.target.value)}
                    placeholder="LV200"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 uppercase focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "ক্যাটাগরি" : "Category"}
                  </label>
                  <select
                    value={category}
                    onChange={(e) => setCategory(e.target.value as any)}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  >
                    <option value="REAL_ESTATE">{isBangla ? "রিয়েল এস্টেট" : "Real Estate / Land"}</option>
                    <option value="AGRICULTURAL">{isBangla ? "এগ্রিকালচারাল" : "Agro / Livestock"}</option>
                    <option value="COMMERCIAL">{isBangla ? "বাণিজ্যিক" : "Commercial Venture"}</option>
                  </select>
                </div>
              </div>

              <div>
                <label className="block mb-1 text-slate-600">
                  {isBangla ? "অবস্থান / লোকেশন" : "Location"}
                </label>
                <input
                  type="text"
                  required
                  value={location}
                  onChange={(e) => setLocation(e.target.value)}
                  placeholder="e.g. Hemayetpur, Savar, Dhaka"
                  className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "মোট মূলধন (BDT)" : "Target Fund (BDT)"}
                  </label>
                  <input
                    type="number"
                    required
                    value={targetFund}
                    onChange={(e) => setTargetFund(e.target.value)}
                    placeholder="2550000"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "প্রতি শেয়ার মূল্য (BDT)" : "Price Per Share"}
                  </label>
                  <input
                    type="number"
                    required
                    value={pricePerShare}
                    onChange={(e) => setPricePerShare(e.target.value)}
                    placeholder="25500"
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="block mb-1 text-slate-600">
                    {isBangla ? "মোট শেয়ার" : "Total Shares"}
                  </label>
                  <input
                    type="number"
                    value={totalShares}
                    onChange={(e) => setTotalShares(e.target.value)}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    ROI Min (%)
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    value={roiMin}
                    onChange={(e) => setRoiMin(e.target.value)}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="block mb-1 text-slate-600">
                    ROI Max (%)
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    value={roiMax}
                    onChange={(e) => setRoiMax(e.target.value)}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 font-mono focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
              </div>

              <div className="pt-2 flex items-center justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setShowCreateModal(false)}
                  className="px-4 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 font-bold text-xs text-slate-700 transition-all cursor-pointer"
                >
                  {isBangla ? "বাতিল" : "Cancel"}
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] font-bold text-xs text-white shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
                >
                  {isBangla ? "প্রজেক্ট চালু করুন" : "Launch Project"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
