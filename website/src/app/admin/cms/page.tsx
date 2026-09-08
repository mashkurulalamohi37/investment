"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  MasterCmsState,
  DEFAULT_MASTER_CMS,
  PLATFORM_ASSET_PRESETS,
  HomeLiveProjectCard,
  AboutImageItem,
  FaqItem,
  DocumentItem,
} from "@/types/cms";
import {
  Globe,
  Home,
  BookOpen,
  Layers,
  HelpCircle,
  FileText,
  PhoneCall,
  Image as ImageIcon,
  Plus,
  Trash2,
  Edit2,
  ExternalLink,
  Save,
  RotateCcw,
  CheckCircle2,
  Sparkles,
  MapPin,
  Eye,
  AlertCircle,
  ArrowUp,
  ArrowDown,
  Copy,
  Check,
  ShieldCheck,
  Building2,
  DollarSign,
  ToggleLeft,
  ToggleRight,
} from "lucide-react";

type CmsTab =
  | "global"
  | "home"
  | "about"
  | "howItWorks"
  | "faq"
  | "documents"
  | "contact"
  | "media";

export default function MasterCmsAdminPage() {
  const { isBangla } = useAuth();

  const [activeTab, setActiveTab] = useState<CmsTab>("home");
  const [cms, setCms] = useState<MasterCmsState>(DEFAULT_MASTER_CMS);
  const [loading, setLoading] = useState(true);
  const [isSaving, setIsSaving] = useState(false);
  const [toast, setToast] = useState<{ type: "success" | "error"; text: string } | null>(null);
  const [copiedUrl, setCopiedUrl] = useState<string | null>(null);

  // Edit Modals / Form States
  const [editingProject, setEditingProject] = useState<HomeLiveProjectCard | null>(null);
  const [editingImage, setEditingImage] = useState<AboutImageItem | null>(null);
  const [editingFaq, setEditingFaq] = useState<FaqItem | null>(null);
  const [editingDoc, setEditingDoc] = useState<DocumentItem | null>(null);

  // Load CMS data on mount
  useEffect(() => {
    async function loadCms() {
      try {
        const res = await fetch("/api/cms", { cache: "no-store" });
        const json = await res.json();
        if (json.success && json.data) {
          setCms(json.data);
          localStorage.setItem("swapnojatri_master_cms", JSON.stringify(json.data));
        } else {
          const cached = localStorage.getItem("swapnojatri_master_cms");
          if (cached) setCms(JSON.parse(cached));
        }
      } catch (err) {
        console.warn("Using local cache for Master CMS:", err);
        const cached = localStorage.getItem("swapnojatri_master_cms");
        if (cached) setCms(JSON.parse(cached));
      } finally {
        setLoading(false);
      }
    }
    loadCms();
  }, []);

  const showToast = (text: string, type: "success" | "error" = "success") => {
    setToast({ text, type });
    setTimeout(() => setToast(null), 3800);
  };

  const handleCopy = (text: string) => {
    navigator.clipboard.writeText(text);
    setCopiedUrl(text);
    setTimeout(() => setCopiedUrl(null), 2000);
    showToast(isBangla ? "লিঙ্ক কপি হয়েছে!" : "Image URL copied to clipboard!");
  };

  const handleSaveAll = async () => {
    setIsSaving(true);
    try {
      localStorage.setItem("swapnojatri_master_cms", JSON.stringify(cms));
      window.dispatchEvent(new CustomEvent("swapnojatri_cms_updated", { detail: cms }));

      const res = await fetch("/api/cms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ data: cms }),
      });
      const json = await res.json();
      if (json.success) {
        showToast(isBangla ? "সব পরিবর্তন সফলভাবে লাইভ ওয়েবসাইটে প্রকাশিত হয়েছে!" : "All CMS changes published to live website!");
      } else {
        showToast(json.message || "Failed to publish", "error");
      }
    } catch (err) {
      showToast(isBangla ? "লোকাল স্টোরেজে সংরক্ষিত হয়েছে।" : "Saved to local cache.", "success");
    } finally {
      setIsSaving(false);
    }
  };

  const handleResetFactory = async () => {
    if (
      !confirm(
        isBangla
          ? "আপনি কি নিশ্চিত যে সমস্ত কনটেন্ট ফ্যাক্টরি ডিফল্ট অবস্থায় ফিরিয়ে নিতে চান?"
          : "Are you sure you want to restore all CMS content to verified factory defaults?"
      )
    ) {
      return;
    }

    setIsSaving(true);
    try {
      const res = await fetch("/api/cms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "reset" }),
      });
      const json = await res.json();
      if (json.success && json.data) {
        setCms(json.data);
        localStorage.setItem("swapnojatri_master_cms", JSON.stringify(json.data));
        window.dispatchEvent(new CustomEvent("swapnojatri_cms_updated", { detail: json.data }));
        showToast(isBangla ? "ফ্যাক্টরি ডিফল্ট সফলভাবে রিস্টোর হয়েছে!" : "Factory defaults restored successfully!");
      }
    } catch (err) {
      showToast("Reset failed: " + String(err), "error");
    } finally {
      setIsSaving(false);
    }
  };

  // Helper updater functions
  const updateGlobal = (updater: (prev: typeof cms.global) => typeof cms.global) => {
    setCms((prev) => ({ ...prev, global: updater(prev.global) }));
  };

  const updateHome = (updater: (prev: typeof cms.home) => typeof cms.home) => {
    setCms((prev) => ({ ...prev, home: updater(prev.home) }));
  };

  const updateAbout = (updater: (prev: typeof cms.about) => typeof cms.about) => {
    setCms((prev) => ({ ...prev, about: updater(prev.about) }));
  };

  const updateHowItWorks = (updater: (prev: typeof cms.howItWorks) => typeof cms.howItWorks) => {
    setCms((prev) => ({ ...prev, howItWorks: updater(prev.howItWorks) }));
  };

  const updateFaq = (updater: (prev: typeof cms.faq) => typeof cms.faq) => {
    setCms((prev) => ({ ...prev, faq: updater(prev.faq) }));
  };

  const updateDocuments = (updater: (prev: typeof cms.documents) => typeof cms.documents) => {
    setCms((prev) => ({ ...prev, documents: updater(prev.documents) }));
  };

  const updateContact = (updater: (prev: typeof cms.contact) => typeof cms.contact) => {
    setCms((prev) => ({ ...prev, contact: updater(prev.contact) }));
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#06101E] flex items-center justify-center text-white">
        <div className="flex flex-col items-center gap-4">
          <div className="w-12 h-12 border-4 border-cyan-500 border-t-transparent rounded-full animate-spin" />
          <p className="text-slate-400 font-medium">
            {isBangla ? "মাস্টার CMS লোড হচ্ছে..." : "Loading Universal CMS Studio..."}
          </p>
        </div>
      </div>
    );
  }

  const tabs = [
    { id: "home", label: isBangla ? "হোমপেজ ও লাইভ প্রজেক্ট" : "Homepage & Live Projects", icon: Home },
    { id: "global", label: isBangla ? "ব্র্যান্ডিং ও ফুটার" : "Branding & Global", icon: Globe },
    { id: "about", label: isBangla ? "আমাদের গল্প" : "Our Story (/about)", icon: BookOpen },
    { id: "howItWorks", label: isBangla ? "কার্যপদ্ধতি" : "How It Works", icon: Layers },
    { id: "faq", label: isBangla ? "প্রশ্নোত্তর" : "FAQ Manager", icon: HelpCircle },
    { id: "documents", label: isBangla ? "ডকুমেন্টস ভল্ট" : "Legal Vault", icon: FileText },
    { id: "contact", label: isBangla ? "যোগাযোগ ও এসক্রো" : "Contact & Escrow", icon: PhoneCall },
    { id: "media", label: isBangla ? "মিডিয়া লাইব্রেরি" : "Media Presets", icon: ImageIcon },
  ];

  return (
    <div className="min-h-screen bg-[#040D1A] text-slate-100 font-sans pb-28">
      {/* Toast Notification */}
      {toast && (
        <div
          className={`fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-2xl border text-sm font-semibold transition-all animate-bounce ${
            toast.type === "success"
              ? "bg-emerald-950/90 text-emerald-200 border-emerald-500/50 shadow-emerald-950/50"
              : "bg-rose-950/90 text-rose-200 border-rose-500/50 shadow-rose-950/50"
          }`}
        >
          {toast.type === "success" ? <CheckCircle2 className="w-5 h-5 text-emerald-400" /> : <AlertCircle className="w-5 h-5 text-rose-400" />}
          {toast.text}
        </div>
      )}

      {/* Top Sticky Header with Unified Actions */}
      <header className="sticky top-0 z-40 bg-[#061529]/95 backdrop-blur-xl border-b border-slate-800/80 px-4 sm:px-8 py-4 shadow-xl shadow-black/30">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-cyan-500/10 border border-cyan-500/30 text-cyan-400">
              <Globe className="w-6 h-6" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h1 className="text-xl sm:text-2xl font-bold tracking-tight text-white">
                  {isBangla ? "ইউনিভার্সাল CMS কন্ট্রোল স্টুডিও" : "Universal CMS Control Studio"}
                </h1>
                <span className="text-[10px] px-2 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 font-mono font-semibold uppercase tracking-wider">
                  Live Sync
                </span>
              </div>
              <p className="text-xs text-slate-400">
                {isBangla
                  ? "ওয়েবসাইটের প্রতিটি পেজ, হোমপেজ প্রজেক্ট শোকেস ও ডকুমেন্টস নিয়ন্ত্রণ করুন"
                  : "Zero-code admin control for every single page, live project card, and legal record"}
              </p>
            </div>
          </div>

          {/* Quick Action Buttons */}
          <div className="flex items-center gap-2.5 shrink-0 flex-wrap">
            <Link
              href="/"
              target="_blank"
              className="inline-flex items-center gap-1.5 px-3.5 py-2 text-xs font-semibold rounded-lg bg-slate-800/80 hover:bg-slate-700 text-slate-300 hover:text-white border border-slate-700/60 transition-colors"
            >
              <Eye className="w-3.5 h-3.5 text-cyan-400" />
              {isBangla ? "লাইভ সাইট দেখুন" : "View Live Site"}
              <ExternalLink className="w-3 h-3 opacity-60" />
            </Link>

            <button
              onClick={handleResetFactory}
              disabled={isSaving}
              className="inline-flex items-center gap-1.5 px-3.5 py-2 text-xs font-semibold rounded-lg bg-rose-500/10 hover:bg-rose-500/20 text-rose-300 border border-rose-500/30 transition-colors disabled:opacity-50"
              title="Restore original factory content"
            >
              <RotateCcw className="w-3.5 h-3.5 text-rose-400" />
              {isBangla ? "ডিফল্ট রিস্টোর" : "Factory Reset"}
            </button>

            <button
              onClick={handleSaveAll}
              disabled={isSaving}
              className="inline-flex items-center gap-2 px-5 py-2 text-xs font-bold rounded-lg bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-400 hover:to-teal-500 text-white shadow-lg shadow-emerald-900/30 border border-emerald-400/40 transition-all transform active:scale-95 disabled:opacity-50"
            >
              {isSaving ? (
                <>
                  <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                  {isBangla ? "সংরক্ষণ হচ্ছে..." : "Publishing..."}
                </>
              ) : (
                <>
                  <Save className="w-4 h-4" />
                  {isBangla ? "সব পরিবর্তন সংরক্ষণ ও প্রকাশ করুন" : "Save & Publish All"}
                </>
              )}
            </button>
          </div>
        </div>

        {/* Tab Navigation Pill Strip */}
        <div className="max-w-7xl mx-auto mt-4 pt-2 border-t border-slate-800/60 overflow-x-auto scrollbar-none">
          <div className="flex items-center gap-1.5 min-w-max pb-1">
            {tabs.map((tab) => {
              const Icon = tab.icon;
              const isActive = activeTab === tab.id;
              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id as CmsTab)}
                  className={`flex items-center gap-2 px-3.5 py-2 rounded-lg text-xs font-semibold transition-all ${
                    isActive
                      ? "bg-cyan-500/20 text-cyan-300 border border-cyan-500/40 shadow-sm"
                      : "text-slate-400 hover:text-slate-200 hover:bg-slate-800/50 border border-transparent"
                  }`}
                >
                  <Icon className={`w-3.5 h-3.5 ${isActive ? "text-cyan-400" : "text-slate-500"}`} />
                  {tab.label}
                </button>
              );
            })}
          </div>
        </div>
      </header>

      {/* Main Studio Body Container */}
      <main className="max-w-7xl mx-auto px-4 sm:px-8 mt-6">
        {/* ========================================================================= */}
        {/* TAB 1: HOMEPAGE & LIVE PROJECTS SHOWCASE MANAGER                         */}
        {/* ========================================================================= */}
        {activeTab === "home" && (
          <div className="space-y-8 animate-fadeIn">
            {/* Live Projects Showcase Highlight Card */}
            <div className="p-6 rounded-2xl bg-gradient-to-b from-[#091F38] to-[#061529] border border-cyan-500/30 shadow-2xl shadow-cyan-950/20">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-5 border-b border-slate-700/60">
                <div className="flex items-center gap-3">
                  <div className="p-3 rounded-xl bg-cyan-500/10 border border-cyan-500/30 text-cyan-400">
                    <Layers className="w-6 h-6" />
                  </div>
                  <div>
                    <div className="flex items-center gap-2.5">
                      <h2 className="text-lg sm:text-xl font-bold text-white">
                        {isBangla ? "হোমপেজ লাইভ প্রজেক্ট শোকেস কন্ট্রোল" : "Homepage Live Projects Showcase Manager"}
                      </h2>
                      <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-cyan-500/20 text-cyan-300 border border-cyan-500/30">
                        Live Control
                      </span>
                    </div>
                    <p className="text-xs text-slate-400 mt-0.5">
                      {isBangla
                        ? "হোমপেজে কোন কোন প্রজেক্ট প্রদর্শিত হবে, তাদের ক্রম, স্ট্যাটাস ব্যাজ ও ডেটা রিয়েল-টাইমে নিয়ন্ত্রণ করুন"
                        : "Toggle project visibility on Homepage, order 1-2-3, override badges, target shares, and CTA links"}
                    </p>
                  </div>
                </div>

                {/* Master Showcase Toggle */}
                <div className="flex items-center gap-3 bg-slate-900/80 px-4 py-2.5 rounded-xl border border-slate-700">
                  <span className="text-xs font-semibold text-slate-300">
                    {isBangla ? "হোমপেজ শোকেস চালু/বন্ধ:" : "Section Active on Home:"}
                  </span>
                  <button
                    type="button"
                    onClick={() =>
                      updateHome((prev) => ({
                        ...prev,
                        liveProjectsSection: {
                          ...prev.liveProjectsSection,
                          enabled: !prev.liveProjectsSection.enabled,
                        },
                      }))
                    }
                    className={`flex items-center gap-1.5 px-3 py-1 rounded-lg text-xs font-bold transition-all ${
                      cms.home.liveProjectsSection.enabled
                        ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/40"
                        : "bg-slate-800 text-slate-400 border border-slate-700"
                    }`}
                  >
                    {cms.home.liveProjectsSection.enabled ? (
                      <>
                        <ToggleRight className="w-4 h-4 text-emerald-400" />
                        {isBangla ? "সক্রিয় (VISIBLE)" : "ENABLED"}
                      </>
                    ) : (
                      <>
                        <ToggleLeft className="w-4 h-4 text-slate-500" />
                        {isBangla ? "লুকানো (HIDDEN)" : "HIDDEN"}
                      </>
                    )}
                  </button>
                </div>
              </div>

              {/* Section Header Headings */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-5 p-4 rounded-xl bg-slate-900/60 border border-slate-800">
                <div>
                  <label className="block text-[11px] font-semibold text-slate-400 mb-1">
                    Section Title (English)
                  </label>
                  <input
                    type="text"
                    value={cms.home.liveProjectsSection.title}
                    onChange={(e) =>
                      updateHome((prev) => ({
                        ...prev,
                        liveProjectsSection: { ...prev.liveProjectsSection, title: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-cyan-500"
                  />
                </div>
                <div>
                  <label className="block text-[11px] font-semibold text-slate-400 mb-1">
                    Section Title (বাংলা)
                  </label>
                  <input
                    type="text"
                    value={cms.home.liveProjectsSection.titleBn}
                    onChange={(e) =>
                      updateHome((prev) => ({
                        ...prev,
                        liveProjectsSection: { ...prev.liveProjectsSection, titleBn: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-cyan-500"
                  />
                </div>

                <div>
                  <label className="block text-[11px] font-semibold text-slate-400 mb-1">
                    Section Subtitle (English)
                  </label>
                  <input
                    type="text"
                    value={cms.home.liveProjectsSection.subtitle}
                    onChange={(e) =>
                      updateHome((prev) => ({
                        ...prev,
                        liveProjectsSection: { ...prev.liveProjectsSection, subtitle: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-cyan-500"
                  />
                </div>
                <div>
                  <label className="block text-[11px] font-semibold text-slate-400 mb-1">
                    Section Subtitle (বাংলা)
                  </label>
                  <input
                    type="text"
                    value={cms.home.liveProjectsSection.subtitleBn}
                    onChange={(e) =>
                      updateHome((prev) => ({
                        ...prev,
                        liveProjectsSection: { ...prev.liveProjectsSection, subtitleBn: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-cyan-500"
                  />
                </div>
              </div>

              {/* Projects Cards List */}
              <div className="mt-6">
                <div className="flex items-center justify-between mb-3">
                  <h3 className="text-sm font-bold text-slate-200 uppercase tracking-wider flex items-center gap-2">
                    <Sparkles className="w-4 h-4 text-cyan-400" />
                    {isBangla ? "প্রকল্প কার্ডসমূহ (Showcase Cards)" : "Showcase Project Cards"}
                  </h3>
                  <button
                    type="button"
                    onClick={() => {
                      const newProj: HomeLiveProjectCard = {
                        id: `proj-${Date.now()}`,
                        projectCode: "PROJ-NEW",
                        showOnHome: true,
                        order: cms.home.liveProjectsSection.projects.length + 1,
                        statusBadge: "UPCOMING",
                        statusBadgeBn: "আসন্ন প্রকল্প",
                        imageUrl: "/images/landvest_hero.jpg",
                        name: "New Fractional Venture",
                        nameBn: "নতুন ফ্র্যাকশনাল প্রকল্প",
                        category: "COMMERCIAL REAL ESTATE",
                        categoryBn: "বাণিজ্যিক আবাসন",
                        location: "Dhaka Belt, Bangladesh",
                        locationBn: "ঢাকা সংলগ্ন এলাকা",
                        pricePerShare: 20000,
                        projectedRoiMin: 18,
                        projectedRoiMax: 22,
                        totalShares: 100,
                        allocatedShares: 0,
                        isUpcoming: true,
                        ctaText: "View Details →",
                        ctaTextBn: "বিস্তারিত দেখুন →",
                        ctaUrl: "/projects",
                        escrowBadge: "City Bank Escrow",
                        escrowBadgeBn: "সিটি ব্যাংক এসক্রো",
                      };
                      setEditingProject(newProj);
                    }}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold bg-cyan-500/20 hover:bg-cyan-500/30 text-cyan-300 border border-cyan-500/40"
                  >
                    <Plus className="w-3.5 h-3.5" />
                    {isBangla ? "নতুন প্রকল্প কার্ড যোগ করুন" : "Add Project Card"}
                  </button>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                  {cms.home.liveProjectsSection.projects.map((proj, idx) => {
                    const percent = Math.min(
                      100,
                      Math.round((proj.allocatedShares / (proj.totalShares || 1)) * 100)
                    );
                    return (
                      <div
                        key={proj.id}
                        className={`relative rounded-xl border p-4 transition-all flex flex-col justify-between ${
                          proj.showOnHome
                            ? "bg-[#06172C] border-slate-700/80 hover:border-cyan-500/60"
                            : "bg-[#040E1B] border-slate-800/60 opacity-60"
                        }`}
                      >
                        <div>
                          {/* Image & Badges */}
                          <div className="relative w-full h-36 rounded-lg overflow-hidden bg-slate-900 mb-3 group">
                            <img
                              src={proj.imageUrl}
                              alt={proj.name}
                              className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
                            />
                            <div className="absolute top-2 left-2 flex items-center gap-1.5">
                              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-black/75 text-cyan-300 border border-cyan-400/30 backdrop-blur-sm">
                                #{proj.order} {proj.projectCode}
                              </span>
                              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-emerald-950/80 text-emerald-300 border border-emerald-500/30 backdrop-blur-sm">
                                {isBangla ? proj.statusBadgeBn : proj.statusBadge}
                              </span>
                            </div>
                            <div className="absolute top-2 right-2">
                              <button
                                type="button"
                                onClick={() => {
                                  const updated = cms.home.liveProjectsSection.projects.map((p) =>
                                    p.id === proj.id ? { ...p, showOnHome: !p.showOnHome } : p
                                  );
                                  updateHome((prev) => ({
                                    ...prev,
                                    liveProjectsSection: { ...prev.liveProjectsSection, projects: updated },
                                  }));
                                }}
                                className={`text-[10px] font-bold px-2 py-0.5 rounded backdrop-blur-sm border transition-all ${
                                  proj.showOnHome
                                    ? "bg-emerald-500/80 text-white border-emerald-400"
                                    : "bg-rose-500/80 text-white border-rose-400"
                                }`}
                                title="Toggle display on home"
                              >
                                {proj.showOnHome ? "ON HOME" : "HIDDEN"}
                              </button>
                            </div>
                          </div>

                          {/* Title & Info */}
                          <h4 className="text-sm font-bold text-white leading-tight">
                            {isBangla ? proj.nameBn : proj.name}
                          </h4>
                          <p className="text-xs text-cyan-400 font-medium mt-0.5">
                            {isBangla ? proj.categoryBn : proj.category} • {isBangla ? proj.locationBn : proj.location}
                          </p>

                          {/* Financials */}
                          <div className="mt-3 grid grid-cols-2 gap-2 text-xs bg-slate-900/60 p-2 rounded-lg border border-slate-800">
                            <div>
                              <span className="text-[10px] text-slate-400 block">Share Price</span>
                              <span className="font-bold text-amber-400">৳{proj.pricePerShare.toLocaleString()}</span>
                            </div>
                            <div>
                              <span className="text-[10px] text-slate-400 block">Proj. ROI</span>
                              <span className="font-bold text-emerald-400">
                                {proj.projectedRoiMin}% - {proj.projectedRoiMax}%
                              </span>
                            </div>
                          </div>

                          {/* Progress */}
                          <div className="mt-2.5">
                            <div className="flex items-center justify-between text-[11px] text-slate-400 mb-1">
                              <span>
                                {proj.allocatedShares} / {proj.totalShares} Shares
                              </span>
                              <span className="font-bold text-slate-200">{percent}%</span>
                            </div>
                            <div className="w-full bg-slate-800 h-1.5 rounded-full overflow-hidden">
                              <div
                                className="bg-gradient-to-r from-cyan-500 to-emerald-400 h-full rounded-full transition-all"
                                style={{ width: `${percent}%` }}
                              />
                            </div>
                          </div>
                        </div>

                        {/* Controls & Ordering */}
                        <div className="mt-4 pt-3 border-t border-slate-800 flex items-center justify-between">
                          <div className="flex items-center gap-1">
                            <button
                              type="button"
                              disabled={idx === 0}
                              onClick={() => {
                                const list = [...cms.home.liveProjectsSection.projects];
                                const temp = list[idx - 1];
                                list[idx - 1] = list[idx];
                                list[idx] = temp;
                                list.forEach((p, i) => (p.order = i + 1));
                                updateHome((prev) => ({
                                  ...prev,
                                  liveProjectsSection: { ...prev.liveProjectsSection, projects: list },
                                }));
                              }}
                              className="p-1 rounded bg-slate-800 hover:bg-slate-700 text-slate-300 disabled:opacity-30"
                              title="Move card left"
                            >
                              <ArrowUp className="w-3.5 h-3.5 -rotate-90" />
                            </button>
                            <button
                              type="button"
                              disabled={idx === cms.home.liveProjectsSection.projects.length - 1}
                              onClick={() => {
                                const list = [...cms.home.liveProjectsSection.projects];
                                const temp = list[idx + 1];
                                list[idx + 1] = list[idx];
                                list[idx] = temp;
                                list.forEach((p, i) => (p.order = i + 1));
                                updateHome((prev) => ({
                                  ...prev,
                                  liveProjectsSection: { ...prev.liveProjectsSection, projects: list },
                                }));
                              }}
                              className="p-1 rounded bg-slate-800 hover:bg-slate-700 text-slate-300 disabled:opacity-30"
                              title="Move card right"
                            >
                              <ArrowDown className="w-3.5 h-3.5 -rotate-90" />
                            </button>
                          </div>

                          <div className="flex items-center gap-2">
                            <button
                              type="button"
                              onClick={() => setEditingProject(proj)}
                              className="inline-flex items-center gap-1 text-xs font-semibold text-cyan-400 hover:text-cyan-300 px-2 py-1 rounded bg-cyan-500/10 hover:bg-cyan-500/20 border border-cyan-500/30"
                            >
                              <Edit2 className="w-3 h-3" />
                              {isBangla ? "এডিট" : "Edit"}
                            </button>
                            <button
                              type="button"
                              onClick={() => {
                                if (confirm(isBangla ? "এই প্রজেক্ট কার্ডটি মুছে ফেলতে চান?" : "Delete this project card?")) {
                                  const filtered = cms.home.liveProjectsSection.projects.filter(
                                    (p) => p.id !== proj.id
                                  );
                                  filtered.forEach((p, i) => (p.order = i + 1));
                                  updateHome((prev) => ({
                                    ...prev,
                                    liveProjectsSection: { ...prev.liveProjectsSection, projects: filtered },
                                  }));
                                }
                              }}
                              className="p-1 text-rose-400 hover:text-rose-300 rounded bg-rose-500/10 hover:bg-rose-500/20 border border-rose-500/30"
                              title="Delete card"
                            >
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            {/* Hero Section CMS */}
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-5">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-800">
                <Sparkles className="w-5 h-5 text-amber-400" />
                <h3 className="text-base font-bold text-white">
                  {isBangla ? "১. হোমপেজ হিরো সেকশন" : "1. Homepage Hero Section"}
                </h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Tagline Badge (English)
                  </label>
                  <input
                    type="text"
                    value={cms.home.hero.tagline}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, tagline: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Tagline Badge (বাংলা)
                  </label>
                  <input
                    type="text"
                    value={cms.home.hero.taglineBn}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, taglineBn: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Main Headline (English)
                  </label>
                  <input
                    type="text"
                    value={cms.home.hero.headline}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, headline: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Main Headline (বাংলা)
                  </label>
                  <input
                    type="text"
                    value={cms.home.hero.headlineBn}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, headlineBn: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Subheadline (English)
                  </label>
                  <textarea
                    rows={2}
                    value={cms.home.hero.subheadline}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, subheadline: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Subheadline (বাংলা)
                  </label>
                  <textarea
                    rows={2}
                    value={cms.home.hero.subheadlineBn}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, subheadlineBn: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div className="md:col-span-2">
                  <label className="block text-xs font-semibold text-slate-300 mb-1">
                    Hero Background Image URL
                  </label>
                  <input
                    type="text"
                    value={cms.home.hero.bgImageUrl}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, bgImageUrl: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Primary Button Label</label>
                  <input
                    type="text"
                    value={cms.home.hero.primaryCtaText}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, primaryCtaText: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Primary Button Link</label>
                  <input
                    type="text"
                    value={cms.home.hero.primaryCtaUrl}
                    onChange={(e) =>
                      updateHome((prev) => ({ ...prev, hero: { ...prev.hero, primaryCtaUrl: e.target.value } }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
              </div>
            </div>

            {/* Metrics Ribbon CMS */}
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-800">
                <DollarSign className="w-5 h-5 text-emerald-400" />
                <h3 className="text-base font-bold text-white">
                  {isBangla ? "২. রিয়েল-টাইম মেট্রিক রিবন (৬টি কার্ড)" : "2. Real-Time Metrics Ribbon (6 Cards)"}
                </h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {cms.home.metrics.map((metric, i) => (
                  <div key={metric.id || i} className="p-3.5 rounded-xl bg-slate-900/80 border border-slate-800 space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-[10px] font-bold text-cyan-400 uppercase">Card #{i + 1}</span>
                      <input
                        type="text"
                        value={metric.color}
                        onChange={(e) => {
                          const updated = [...cms.home.metrics];
                          updated[i].color = e.target.value;
                          updateHome((prev) => ({ ...prev, metrics: updated }));
                        }}
                        className="text-[10px] bg-black/40 border border-slate-700 rounded px-2 py-0.5 text-slate-300 w-24"
                      />
                    </div>
                    <div>
                      <label className="block text-[10px] text-slate-400">Value (English & বাংলা)</label>
                      <div className="grid grid-cols-2 gap-1.5 mt-0.5">
                        <input
                          type="text"
                          value={metric.value}
                          onChange={(e) => {
                            const updated = [...cms.home.metrics];
                            updated[i].value = e.target.value;
                            updateHome((prev) => ({ ...prev, metrics: updated }));
                          }}
                          className="bg-[#051120] border border-slate-700 rounded px-2 py-1 text-xs text-white"
                        />
                        <input
                          type="text"
                          value={metric.valueBn}
                          onChange={(e) => {
                            const updated = [...cms.home.metrics];
                            updated[i].valueBn = e.target.value;
                            updateHome((prev) => ({ ...prev, metrics: updated }));
                          }}
                          className="bg-[#051120] border border-slate-700 rounded px-2 py-1 text-xs text-white"
                        />
                      </div>
                    </div>
                    <div>
                      <label className="block text-[10px] text-slate-400">Label (English & বাংলা)</label>
                      <div className="grid grid-cols-2 gap-1.5 mt-0.5">
                        <input
                          type="text"
                          value={metric.label}
                          onChange={(e) => {
                            const updated = [...cms.home.metrics];
                            updated[i].label = e.target.value;
                            updateHome((prev) => ({ ...prev, metrics: updated }));
                          }}
                          className="bg-[#051120] border border-slate-700 rounded px-2 py-1 text-xs text-white"
                        />
                        <input
                          type="text"
                          value={metric.labelBn}
                          onChange={(e) => {
                            const updated = [...cms.home.metrics];
                            updated[i].labelBn = e.target.value;
                            updateHome((prev) => ({ ...prev, metrics: updated }));
                          }}
                          className="bg-[#051120] border border-slate-700 rounded px-2 py-1 text-xs text-white"
                        />
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 2: GLOBAL BRANDING, TOP BAR & FOOTER LEGAL                            */}
        {/* ========================================================================= */}
        {activeTab === "global" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-5">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-800">
                <Globe className="w-5 h-5 text-cyan-400" />
                <h3 className="text-base font-bold text-white">
                  {isBangla ? "প্ল্যাটফর্ম পরিচয় ও ব্র্যান্ডিং" : "Platform Identity & Branding"}
                </h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Brand Name (English)</label>
                  <input
                    type="text"
                    value={cms.global.brandName}
                    onChange={(e) => updateGlobal((prev) => ({ ...prev, brandName: e.target.value }))}
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Brand Name (বাংলা)</label>
                  <input
                    type="text"
                    value={cms.global.brandNameBn}
                    onChange={(e) => updateGlobal((prev) => ({ ...prev, brandNameBn: e.target.value }))}
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Brand Subtitle (English)</label>
                  <input
                    type="text"
                    value={cms.global.brandSubtitle}
                    onChange={(e) => updateGlobal((prev) => ({ ...prev, brandSubtitle: e.target.value }))}
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Brand Subtitle (বাংলা)</label>
                  <input
                    type="text"
                    value={cms.global.brandSubtitleBn}
                    onChange={(e) => updateGlobal((prev) => ({ ...prev, brandSubtitleBn: e.target.value }))}
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>

                <div className="md:col-span-2">
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Platform Logo URL</label>
                  <input
                    type="text"
                    value={cms.global.logoUrl}
                    onChange={(e) => updateGlobal((prev) => ({ ...prev, logoUrl: e.target.value }))}
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
              </div>
            </div>

            {/* Top Announcement Bar */}
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                <div className="flex items-center gap-3">
                  <Sparkles className="w-5 h-5 text-amber-400" />
                  <h3 className="text-base font-bold text-white">Top Announcement Bar</h3>
                </div>
                <button
                  type="button"
                  onClick={() =>
                    updateGlobal((prev) => ({
                      ...prev,
                      announcement: { ...prev.announcement, enabled: !prev.announcement.enabled },
                    }))
                  }
                  className={`px-3 py-1 rounded-lg text-xs font-bold ${
                    cms.global.announcement.enabled
                      ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/40"
                      : "bg-slate-800 text-slate-400 border border-slate-700"
                  }`}
                >
                  {cms.global.announcement.enabled ? "ENABLED" : "DISABLED"}
                </button>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Message (English)</label>
                  <input
                    type="text"
                    value={cms.global.announcement.text}
                    onChange={(e) =>
                      updateGlobal((prev) => ({
                        ...prev,
                        announcement: { ...prev.announcement, text: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Message (বাংলা)</label>
                  <input
                    type="text"
                    value={cms.global.announcement.textBn}
                    onChange={(e) =>
                      updateGlobal((prev) => ({
                        ...prev,
                        announcement: { ...prev.announcement, textBn: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 3: OUR STORY PAGE CMS (/about)                                        */}
        {/* ========================================================================= */}
        {activeTab === "about" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-800">
                <ImageIcon className="w-5 h-5 text-cyan-400" />
                <h3 className="text-base font-bold text-white">Our Story Hero Visual</h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="md:col-span-2">
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Hero Image URL</label>
                  <input
                    type="text"
                    value={cms.about.heroImage.imageUrl}
                    onChange={(e) =>
                      updateAbout((prev) => ({
                        ...prev,
                        heroImage: { ...prev.heroImage, imageUrl: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
              </div>
            </div>

            {/* Gallery Images List */}
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                <h3 className="text-base font-bold text-white">Gallery Photos</h3>
                <button
                  type="button"
                  onClick={() => {
                    const newItem: AboutImageItem = {
                      id: `story-${Date.now()}`,
                      title: "New Field Asset",
                      titleBn: "নতুন ফিল্ড পরিদর্শন",
                      category: "REAL ESTATE",
                      categoryBn: "জমি ও আবাসন",
                      imageUrl: "/images/gallery_land.jpg",
                      caption: "GPS surveyed field at Washpur.",
                      captionBn: "ওয়াশপুরে জিপিএস জরিপ সম্পন্ন।",
                    };
                    setEditingImage(newItem);
                  }}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-cyan-500/20 text-cyan-300 border border-cyan-500/40"
                >
                  <Plus className="w-3.5 h-3.5 inline mr-1" />
                  Add Photo
                </button>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {cms.about.storyImages.map((img) => (
                  <div key={img.id} className="p-3.5 rounded-xl bg-slate-900/80 border border-slate-800 flex flex-col gap-3">
                    {/* Image Preview */}
                    <div className="w-full rounded-lg overflow-hidden bg-slate-950 relative" style={{ minHeight: "8rem" }}>
                      {img.imageUrl ? (
                        <img
                          src={img.imageUrl}
                          alt={img.title || "Gallery image"}
                          className="w-full object-cover"
                          style={{ height: "8rem" }}
                          onError={(e) => {
                            (e.target as HTMLImageElement).style.display = "none";
                            const parent = (e.target as HTMLImageElement).parentElement;
                            if (parent && !parent.querySelector(".img-fallback")) {
                              const fb = document.createElement("div");
                              fb.className = "img-fallback flex items-center justify-center h-32 text-slate-600 text-xs font-mono";
                              fb.textContent = "Image not found: " + img.imageUrl;
                              parent.appendChild(fb);
                            }
                          }}
                        />
                      ) : (
                        <div className="flex items-center justify-center h-32 text-slate-600 text-xs font-mono">
                          No image URL set
                        </div>
                      )}
                      {/* Category badge overlay */}
                      <span className="absolute top-2 left-2 text-[10px] font-bold px-2 py-0.5 rounded-full bg-cyan-900/90 text-cyan-300 border border-cyan-700/60">
                        {isBangla ? img.categoryBn || img.category : img.category}
                      </span>
                    </div>
                    {/* Title + Caption */}
                    <div className="space-y-1">
                      <h4 className="text-xs font-bold text-white leading-snug">
                        {isBangla ? (img.titleBn || img.title) : img.title}
                      </h4>
                      <p className="text-[11px] text-slate-400 line-clamp-2 leading-relaxed">
                        {isBangla ? (img.captionBn || img.caption) : img.caption}
                      </p>
                    </div>
                    {/* URL input for quick editing */}
                    <input
                      type="text"
                      value={img.imageUrl}
                      onChange={(e) => {
                        updateAbout((prev) => ({
                          ...prev,
                          storyImages: prev.storyImages.map((i) =>
                            i.id === img.id ? { ...i, imageUrl: e.target.value } : i
                          ),
                        }));
                      }}
                      placeholder="Image URL (e.g. /images/gallery_land.jpg)"
                      className="w-full bg-black/40 border border-slate-700 rounded-lg px-2.5 py-1.5 text-[11px] text-slate-300 font-mono focus:outline-none focus:border-cyan-500"
                    />
                    {/* Actions */}
                    <div className="pt-1 border-t border-slate-800 flex items-center justify-end gap-2">
                      <button
                        type="button"
                        onClick={() => setEditingImage(img)}
                        className="text-xs font-semibold text-cyan-400 px-2 py-1 rounded bg-cyan-500/10 border border-cyan-500/30 hover:bg-cyan-500/20"
                      >
                        Edit
                      </button>
                      <button
                        type="button"
                        onClick={() => {
                          if (confirm("Delete this photo?")) {
                            updateAbout((prev) => ({
                              ...prev,
                              storyImages: prev.storyImages.filter((i) => i.id !== img.id),
                            }));
                          }
                        }}
                        className="p-1 text-rose-400 rounded bg-rose-500/10 border border-rose-500/30 hover:bg-rose-500/20"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 4: HOW IT WORKS PAGE CMS (/how-it-works)                             */}
        {/* ========================================================================= */}
        {activeTab === "howItWorks" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-800">
                <Layers className="w-5 h-5 text-cyan-400" />
                <h3 className="text-base font-bold text-white">How It Works Header</h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Title (English)</label>
                  <input
                    type="text"
                    value={cms.howItWorks.header.title}
                    onChange={(e) =>
                      updateHowItWorks((prev) => ({
                        ...prev,
                        header: { ...prev.header, title: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Title (বাংলা)</label>
                  <input
                    type="text"
                    value={cms.howItWorks.header.titleBn}
                    onChange={(e) =>
                      updateHowItWorks((prev) => ({
                        ...prev,
                        header: { ...prev.header, titleBn: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 5: FAQ MANAGER CMS (/faq)                                             */}
        {/* ========================================================================= */}
        {activeTab === "faq" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                <div className="flex items-center gap-3">
                  <HelpCircle className="w-5 h-5 text-cyan-400" />
                  <h3 className="text-base font-bold text-white">FAQ Questions Manager</h3>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    const newFaq: FaqItem = {
                      id: `faq-${Date.now()}`,
                      category: "GENERAL",
                      q: "What makes Swapnojatri unique?",
                      qBn: "স্বপ্নযাত্রীর বিশেষত্ব কী?",
                      a: "Mandatory City Bank escrow supervision and GPS physical verification.",
                      aBn: "বাধ্যতামূলক সিটি ব্যাংক এসক্রো এবং বাস্তব সাইট জিপিএস যাচাইকরণ।",
                      order: cms.faq.items.length + 1,
                      active: true,
                    };
                    setEditingFaq(newFaq);
                  }}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-cyan-500/20 text-cyan-300 border border-cyan-500/40"
                >
                  <Plus className="w-3.5 h-3.5 inline mr-1" />
                  Add FAQ
                </button>
              </div>

              <div className="space-y-3">
                {cms.faq.items.map((item) => (
                  <div key={item.id} className="p-4 rounded-xl bg-slate-900/80 border border-slate-800 flex items-center justify-between gap-4">
                    <div>
                      <div className="flex items-center gap-2">
                        <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-cyan-500/10 text-cyan-300 border border-cyan-500/30">
                          {item.category}
                        </span>
                        <h4 className="text-sm font-bold text-white">{item.q}</h4>
                      </div>
                      <p className="text-xs text-slate-400 mt-1 line-clamp-1">{item.a}</p>
                    </div>

                    <div className="flex items-center gap-2 shrink-0">
                      <button
                        type="button"
                        onClick={() => {
                          const updated = cms.faq.items.map((f) =>
                            f.id === item.id ? { ...f, active: !f.active } : f
                          );
                          updateFaq((prev) => ({ ...prev, items: updated }));
                        }}
                        className={`text-xs font-bold px-2.5 py-1 rounded border ${
                          item.active
                            ? "bg-emerald-500/10 text-emerald-300 border-emerald-500/30"
                            : "bg-slate-800 text-slate-400 border-slate-700"
                        }`}
                      >
                        {item.active ? "ACTIVE" : "DRAFT"}
                      </button>
                      <button
                        type="button"
                        onClick={() => setEditingFaq(item)}
                        className="text-xs font-semibold text-cyan-400 px-2.5 py-1 rounded bg-cyan-500/10 border border-cyan-500/30"
                      >
                        Edit
                      </button>
                      <button
                        type="button"
                        onClick={() => {
                          if (confirm("Delete this FAQ item?")) {
                            updateFaq((prev) => ({
                              ...prev,
                              items: prev.items.filter((f) => f.id !== item.id),
                            }));
                          }
                        }}
                        className="p-1 text-rose-400 rounded bg-rose-500/10 border border-rose-500/30"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 6: LEGAL DOCUMENTS VAULT CMS (/documents)                            */}
        {/* ========================================================================= */}
        {activeTab === "documents" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl space-y-4">
              <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                <div className="flex items-center gap-3">
                  <FileText className="w-5 h-5 text-cyan-400" />
                  <h3 className="text-base font-bold text-white">Legal Documents Vault</h3>
                </div>
                <button
                  type="button"
                  onClick={() => {
                    const newDoc: DocumentItem = {
                      id: `doc-${Date.now()}`,
                      category: "DEED",
                      categoryBn: "আইনি দলিল",
                      title: "Certified Title Deed Record",
                      titleBn: "সার্টিফাইড মূল দলিল ও খতিয়ান",
                      type: "PDF",
                      size: "2.8 MB",
                      date: new Date().toISOString().split("T")[0],
                      fileUrl: "/documents/sample_deed.pdf",
                      hash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
                      visibility: "PUBLIC",
                    };
                    setEditingDoc(newDoc);
                  }}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold bg-cyan-500/20 text-cyan-300 border border-cyan-500/40"
                >
                  <Plus className="w-3.5 h-3.5 inline mr-1" />
                  Add Document
                </button>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {cms.documents.documents.map((doc) => (
                  <div key={doc.id} className="p-4 rounded-xl bg-slate-900/80 border border-slate-800 flex flex-col justify-between">
                    <div>
                      <div className="flex items-center justify-between gap-2 mb-2">
                        <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-cyan-500/10 text-cyan-300 border border-cyan-500/30">
                          {doc.category}
                        </span>
                        <span className="text-[10px] font-mono text-slate-400">{doc.size}</span>
                      </div>
                      <h4 className="text-sm font-bold text-white">{doc.title}</h4>
                      <p className="text-xs text-slate-400 mt-1">{isBangla ? doc.titleBn : doc.categoryBn}</p>
                      <div className="mt-2 text-[10px] font-mono text-slate-500 break-all bg-black/40 p-1.5 rounded">
                        SHA-256: {doc.hash.slice(0, 32)}...
                      </div>
                    </div>

                    <div className="mt-4 pt-3 border-t border-slate-800 flex items-center justify-between">
                      <span className={`text-[10px] font-bold px-2 py-0.5 rounded ${
                        doc.visibility === "INVESTOR_ONLY"
                          ? "bg-amber-500/10 text-amber-300 border border-amber-500/30"
                          : "bg-emerald-500/10 text-emerald-300 border border-emerald-500/30"
                      }`}>
                        {doc.visibility}
                      </span>

                      <div className="flex items-center gap-2">
                        <button
                          type="button"
                          onClick={() => setEditingDoc(doc)}
                          className="text-xs font-semibold text-cyan-400 px-2 py-1 rounded bg-cyan-500/10 border border-cyan-500/30"
                        >
                          Edit
                        </button>
                        <button
                          type="button"
                          onClick={() => {
                            if (confirm("Delete this document record?")) {
                              updateDocuments((prev) => ({
                                ...prev,
                                documents: prev.documents.filter((d) => d.id !== doc.id),
                              }));
                            }
                          }}
                          className="p-1 text-rose-400 rounded bg-rose-500/10 border border-rose-500/30"
                        >
                          <Trash2 className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 7: CONTACT & CITY BANK ESCROW CMS (/contact)                          */}
        {/* ========================================================================= */}
        {activeTab === "contact" && (
          <div className="space-y-8 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-gradient-to-b from-[#091F38] to-[#061529] border border-cyan-500/30 shadow-xl space-y-4">
              <div className="flex items-center gap-3 pb-3 border-b border-slate-700/60">
                <Building2 className="w-5 h-5 text-cyan-400" />
                <h3 className="text-base font-bold text-white">The City Bank PLC Escrow Passbook Record</h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Bank Name</label>
                  <input
                    type="text"
                    value={cms.contact.bankPassbook.bankName}
                    onChange={(e) =>
                      updateContact((prev) => ({
                        ...prev,
                        bankPassbook: { ...prev.bankPassbook, bankName: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Account Title</label>
                  <input
                    type="text"
                    value={cms.contact.bankPassbook.accountTitle}
                    onChange={(e) =>
                      updateContact((prev) => ({
                        ...prev,
                        bankPassbook: { ...prev.bankPassbook, accountTitle: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm text-white"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Account Number</label>
                  <input
                    type="text"
                    value={cms.contact.bankPassbook.accountNumber}
                    onChange={(e) =>
                      updateContact((prev) => ({
                        ...prev,
                        bankPassbook: { ...prev.bankPassbook, accountNumber: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm font-mono text-cyan-300"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-300 mb-1">Routing Number</label>
                  <input
                    type="text"
                    value={cms.contact.bankPassbook.routingNumber}
                    onChange={(e) =>
                      updateContact((prev) => ({
                        ...prev,
                        bankPassbook: { ...prev.bankPassbook, routingNumber: e.target.value },
                      }))
                    }
                    className="w-full bg-[#051120] border border-slate-700 rounded-lg px-3 py-2 text-sm font-mono text-cyan-300"
                  />
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ========================================================================= */}
        {/* TAB 8: MEDIA LIBRARY & PRESET PICKER                                      */}
        {/* ========================================================================= */}
        {activeTab === "media" && (
          <div className="space-y-6 animate-fadeIn">
            <div className="p-6 rounded-2xl bg-[#061529] border border-slate-800 shadow-xl">
              <div className="flex items-center justify-between pb-4 border-b border-slate-800">
                <div className="flex items-center gap-3">
                  <ImageIcon className="w-5 h-5 text-cyan-400" />
                  <h3 className="text-base font-bold text-white">Platform Media Library</h3>
                </div>
                <span className="text-xs text-slate-400">Click to copy URL</span>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 mt-6">
                {PLATFORM_ASSET_PRESETS.map((asset, i) => {
                  const isCopied = copiedUrl === asset.url;
                  return (
                    <div
                      key={i}
                      className="p-3.5 rounded-xl bg-slate-900/80 border border-slate-800 flex flex-col justify-between"
                    >
                      <div>
                        <div className="relative w-full h-36 rounded-lg overflow-hidden bg-slate-950 mb-3">
                          <img src={asset.url} alt={asset.name} className="w-full h-full object-cover" />
                        </div>
                        <h4 className="text-xs font-bold text-white">{isBangla ? asset.nameBn : asset.name}</h4>
                        <p className="text-[11px] text-slate-400 truncate">{asset.url}</p>
                      </div>

                      <div className="mt-3 pt-2 border-t border-slate-800 flex items-center justify-between">
                        <button
                          type="button"
                          onClick={() => handleCopy(asset.url)}
                          className={`text-xs font-bold px-3 py-1 rounded ${
                            isCopied ? "bg-emerald-500 text-white" : "bg-cyan-500/10 text-cyan-300 border border-cyan-500/30"
                          }`}
                        >
                          {isCopied ? "Copied!" : "Copy URL"}
                        </button>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        )}
      </main>

      {/* ========================================================================= */}
      {/* MODAL: EDIT / ADD HOMEPAGE LIVE PROJECT CARD                              */}
      {/* ========================================================================= */}
      {editingProject && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4 overflow-y-auto">
          <div className="bg-[#081B30] border border-cyan-500/40 rounded-2xl w-full max-w-2xl p-6 shadow-2xl space-y-4 my-8">
            <div className="flex items-center justify-between pb-3 border-b border-slate-700">
              <h3 className="text-base font-bold text-white flex items-center gap-2">
                <Layers className="w-4 h-4 text-cyan-400" />
                Edit Homepage Live Project Card
              </h3>
              <button onClick={() => setEditingProject(null)} className="text-slate-400 hover:text-white">✕</button>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 max-h-[70vh] overflow-y-auto pr-1">
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Project Code</label>
                <input
                  type="text"
                  value={editingProject.projectCode}
                  onChange={(e) => setEditingProject({ ...editingProject, projectCode: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white font-mono"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Display Order</label>
                <input
                  type="number"
                  value={editingProject.order}
                  onChange={(e) => setEditingProject({ ...editingProject, order: Number(e.target.value) })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>

              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Name (English)</label>
                <input
                  type="text"
                  value={editingProject.name}
                  onChange={(e) => setEditingProject({ ...editingProject, name: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Name (বাংলা)</label>
                <input
                  type="text"
                  value={editingProject.nameBn}
                  onChange={(e) => setEditingProject({ ...editingProject, nameBn: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>

              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Status Badge (English)</label>
                <input
                  type="text"
                  value={editingProject.statusBadge}
                  onChange={(e) => setEditingProject({ ...editingProject, statusBadge: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-emerald-400 font-bold"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Status Badge (বাংলা)</label>
                <input
                  type="text"
                  value={editingProject.statusBadgeBn}
                  onChange={(e) => setEditingProject({ ...editingProject, statusBadgeBn: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-emerald-400 font-bold"
                />
              </div>

              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Price Per Share (৳)</label>
                <input
                  type="number"
                  value={editingProject.pricePerShare}
                  onChange={(e) => setEditingProject({ ...editingProject, pricePerShare: Number(e.target.value) })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-amber-400 font-bold"
                />
              </div>

              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">ROI Min %</label>
                  <input
                    type="number"
                    step="0.1"
                    value={editingProject.projectedRoiMin}
                    onChange={(e) => setEditingProject({ ...editingProject, projectedRoiMin: Number(e.target.value) })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">ROI Max %</label>
                  <input
                    type="number"
                    step="0.1"
                    value={editingProject.projectedRoiMax}
                    onChange={(e) => setEditingProject({ ...editingProject, projectedRoiMax: Number(e.target.value) })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
              </div>

              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Allocated Shares</label>
                <input
                  type="number"
                  value={editingProject.allocatedShares}
                  onChange={(e) => setEditingProject({ ...editingProject, allocatedShares: Number(e.target.value) })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Total Shares</label>
                <input
                  type="number"
                  value={editingProject.totalShares}
                  onChange={(e) => setEditingProject({ ...editingProject, totalShares: Number(e.target.value) })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>

              <div className="sm:col-span-2">
                <label className="block text-[11px] text-slate-300 mb-1">Card Image URL</label>
                <input
                  type="text"
                  value={editingProject.imageUrl}
                  onChange={(e) => setEditingProject({ ...editingProject, imageUrl: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>

              <div>
                <label className="block text-[11px] text-slate-300 mb-1">CTA URL Link</label>
                <input
                  type="text"
                  value={editingProject.ctaUrl}
                  onChange={(e) => setEditingProject({ ...editingProject, ctaUrl: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">CTA Text</label>
                <input
                  type="text"
                  value={editingProject.ctaText}
                  onChange={(e) => setEditingProject({ ...editingProject, ctaText: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
            </div>

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-slate-700">
              <button
                type="button"
                onClick={() => setEditingProject(null)}
                className="px-4 py-1.5 rounded-lg text-xs font-semibold bg-slate-800 text-slate-300 hover:bg-slate-700"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={() => {
                  const existingIdx = cms.home.liveProjectsSection.projects.findIndex(
                    (p) => p.id === editingProject.id
                  );
                  let updatedList = [...cms.home.liveProjectsSection.projects];
                  if (existingIdx >= 0) {
                    updatedList[existingIdx] = editingProject;
                  } else {
                    updatedList.push(editingProject);
                  }
                  updateHome((prev) => ({
                    ...prev,
                    liveProjectsSection: { ...prev.liveProjectsSection, projects: updatedList },
                  }));
                  setEditingProject(null);
                  showToast("Project card updated locally. Click 'Save & Publish All' to make it live!");
                }}
                className="px-5 py-1.5 rounded-lg text-xs font-bold bg-cyan-500 hover:bg-cyan-400 text-black shadow-lg"
              >
                Apply Changes
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL: EDIT / ADD ABOUT PHOTO ALBUM ITEM                                  */}
      {/* ========================================================================= */}
      {editingImage && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-[#081B30] border border-cyan-500/40 rounded-2xl w-full max-w-lg p-6 shadow-2xl space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-slate-700">
              <h3 className="text-base font-bold text-white">Edit Gallery Photo</h3>
              <button onClick={() => setEditingImage(null)} className="text-slate-400 hover:text-white">✕</button>
            </div>

            <div className="space-y-3">
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Image URL</label>
                <input
                  type="text"
                  value={editingImage.imageUrl}
                  onChange={(e) => setEditingImage({ ...editingImage, imageUrl: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">Title (EN)</label>
                  <input
                    type="text"
                    value={editingImage.title}
                    onChange={(e) => setEditingImage({ ...editingImage, title: e.target.value })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">Title (BN)</label>
                  <input
                    type="text"
                    value={editingImage.titleBn}
                    onChange={(e) => setEditingImage({ ...editingImage, titleBn: e.target.value })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
              </div>
            </div>

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-slate-700">
              <button
                type="button"
                onClick={() => setEditingImage(null)}
                className="px-4 py-1.5 rounded-lg text-xs font-semibold bg-slate-800 text-slate-300 hover:bg-slate-700"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={() => {
                  const idx = cms.about.storyImages.findIndex((img) => img.id === editingImage.id);
                  let list = [...cms.about.storyImages];
                  if (idx >= 0) list[idx] = editingImage;
                  else list.push(editingImage);
                  updateAbout((prev) => ({ ...prev, storyImages: list }));
                  setEditingImage(null);
                  showToast("Photo updated!");
                }}
                className="px-5 py-1.5 rounded-lg text-xs font-bold bg-cyan-500 hover:bg-cyan-400 text-black"
              >
                Apply
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL: EDIT / ADD FAQ ITEM                                                */}
      {/* ========================================================================= */}
      {editingFaq && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-[#081B30] border border-cyan-500/40 rounded-2xl w-full max-w-lg p-6 shadow-2xl space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-slate-700">
              <h3 className="text-base font-bold text-white">Edit FAQ Item</h3>
              <button onClick={() => setEditingFaq(null)} className="text-slate-400 hover:text-white">✕</button>
            </div>

            <div className="space-y-3">
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Category</label>
                <select
                  value={editingFaq.category}
                  onChange={(e) => setEditingFaq({ ...editingFaq, category: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                >
                  <option value="GENERAL">GENERAL</option>
                  <option value="SHARES">SHARES</option>
                  <option value="SECURITY">SECURITY</option>
                  <option value="RETURNS">RETURNS</option>
                  <option value="DOCS">DOCS</option>
                </select>
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Question (EN)</label>
                <input
                  type="text"
                  value={editingFaq.q}
                  onChange={(e) => setEditingFaq({ ...editingFaq, q: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Question (বাংলা)</label>
                <input
                  type="text"
                  value={editingFaq.qBn}
                  onChange={(e) => setEditingFaq({ ...editingFaq, qBn: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Answer (EN)</label>
                <textarea
                  rows={3}
                  value={editingFaq.a}
                  onChange={(e) => setEditingFaq({ ...editingFaq, a: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Answer (বাংলা)</label>
                <textarea
                  rows={3}
                  value={editingFaq.aBn}
                  onChange={(e) => setEditingFaq({ ...editingFaq, aBn: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
            </div>

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-slate-700">
              <button
                type="button"
                onClick={() => setEditingFaq(null)}
                className="px-4 py-1.5 rounded-lg text-xs font-semibold bg-slate-800 text-slate-300 hover:bg-slate-700"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={() => {
                  const idx = cms.faq.items.findIndex((f) => f.id === editingFaq.id);
                  let list = [...cms.faq.items];
                  if (idx >= 0) list[idx] = editingFaq;
                  else list.push(editingFaq);
                  updateFaq((prev) => ({ ...prev, items: list }));
                  setEditingFaq(null);
                  showToast("FAQ item updated!");
                }}
                className="px-5 py-1.5 rounded-lg text-xs font-bold bg-cyan-500 hover:bg-cyan-400 text-black"
              >
                Apply
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ========================================================================= */}
      {/* MODAL: EDIT / ADD LEGAL DOCUMENT                                          */}
      {/* ========================================================================= */}
      {editingDoc && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-[#081B30] border border-cyan-500/40 rounded-2xl w-full max-w-lg p-6 shadow-2xl space-y-4">
            <div className="flex items-center justify-between pb-3 border-b border-slate-700">
              <h3 className="text-base font-bold text-white">Edit Legal Document</h3>
              <button onClick={() => setEditingDoc(null)} className="text-slate-400 hover:text-white">✕</button>
            </div>

            <div className="space-y-3">
              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">Category</label>
                  <input
                    type="text"
                    value={editingDoc.category}
                    onChange={(e) => setEditingDoc({ ...editingDoc, category: e.target.value })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
                <div>
                  <label className="block text-[11px] text-slate-300 mb-1">File Size</label>
                  <input
                    type="text"
                    value={editingDoc.size}
                    onChange={(e) => setEditingDoc({ ...editingDoc, size: e.target.value })}
                    className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                  />
                </div>
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">Document Title</label>
                <input
                  type="text"
                  value={editingDoc.title}
                  onChange={(e) => setEditingDoc({ ...editingDoc, title: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">File Download / View URL</label>
                <input
                  type="text"
                  value={editingDoc.fileUrl}
                  onChange={(e) => setEditingDoc({ ...editingDoc, fileUrl: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs text-white"
                />
              </div>
              <div>
                <label className="block text-[11px] text-slate-300 mb-1">SHA-256 Checksum Hash</label>
                <input
                  type="text"
                  value={editingDoc.hash}
                  onChange={(e) => setEditingDoc({ ...editingDoc, hash: e.target.value })}
                  className="w-full bg-[#051120] border border-slate-700 rounded px-2.5 py-1.5 text-xs font-mono text-cyan-300"
                />
              </div>
              <div className="flex items-center gap-2 pt-1">
                <input
                  type="checkbox"
                  id="investorOnly"
                  checked={editingDoc.visibility === "INVESTOR_ONLY"}
                  onChange={(e) =>
                    setEditingDoc({
                      ...editingDoc,
                      visibility: e.target.checked ? "INVESTOR_ONLY" : "PUBLIC",
                    })
                  }
                  className="rounded bg-slate-900 border-slate-700"
                />
                <label htmlFor="investorOnly" className="text-xs text-slate-300 font-semibold cursor-pointer">
                  Require Verified Investor Login to Access
                </label>
              </div>
            </div>

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-slate-700">
              <button
                type="button"
                onClick={() => setEditingDoc(null)}
                className="px-4 py-1.5 rounded-lg text-xs font-semibold bg-slate-800 text-slate-300 hover:bg-slate-700"
              >
                Cancel
              </button>
              <button
                type="button"
                onClick={() => {
                  const idx = cms.documents.documents.findIndex((d) => d.id === editingDoc.id);
                  let list = [...cms.documents.documents];
                  if (idx >= 0) list[idx] = editingDoc;
                  else list.push(editingDoc);
                  updateDocuments((prev) => ({ ...prev, documents: list }));
                  setEditingDoc(null);
                  showToast("Legal document updated!");
                }}
                className="px-5 py-1.5 rounded-lg text-xs font-bold bg-cyan-500 hover:bg-cyan-400 text-black"
              >
                Apply
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
