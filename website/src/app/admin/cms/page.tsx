"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  AboutPageCmsConfig,
  AboutImageItem,
  DEFAULT_ABOUT_CMS,
  PLATFORM_ASSET_PRESETS,
} from "@/types/cms";
import {
  LayoutTemplate,
  Image as ImageIcon,
  Plus,
  Trash2,
  Edit2,
  ExternalLink,
  Save,
  RotateCcw,
  CheckCircle2,
  Sparkles,
  Layers,
  MapPin,
  Eye,
  AlertCircle,
  Upload,
} from "lucide-react";

export default function AdminCmsPage() {
  const { isBangla } = useAuth();

  const [cmsConfig, setCmsConfig] = useState<AboutPageCmsConfig>(DEFAULT_ABOUT_CMS);
  const [loading, setLoading] = useState(true);
  const [isSaving, setIsSaving] = useState(false);
  const [toast, setToast] = useState<{ type: "success" | "error"; text: string } | null>(null);

  // Edit / Add Modal State
  const [editingImage, setEditingImage] = useState<AboutImageItem | null>(null);
  const [isAddingNew, setIsAddingNew] = useState(false);

  // New Image Form
  const [formImage, setFormImage] = useState<AboutImageItem>({
    id: "",
    title: "",
    titleBn: "",
    category: "REAL ESTATE",
    categoryBn: "জমি ও আবাসন",
    imageUrl: "/images/landvest_hero.jpg",
    caption: "",
    captionBn: "",
  });

  // Load from API or LocalStorage
  useEffect(() => {
    async function loadCms() {
      try {
        const res = await fetch("/api/cms/about");
        const json = await res.json();
        if (json.success && json.data) {
          setCmsConfig(json.data);
          localStorage.setItem("swapnojatri_about_cms", JSON.stringify(json.data));
        } else {
          const cached = localStorage.getItem("swapnojatri_about_cms");
          if (cached) setCmsConfig(JSON.parse(cached));
        }
      } catch (err) {
        console.warn("Using local cache for About CMS:", err);
        const cached = localStorage.getItem("swapnojatri_about_cms");
        if (cached) setCmsConfig(JSON.parse(cached));
      } finally {
        setLoading(false);
      }
    }
    loadCms();
  }, []);

  const showToast = (text: string, type: "success" | "error" = "success") => {
    setToast({ text, type });
    setTimeout(() => setToast(null), 3500);
  };

  const handleSaveAll = async () => {
    setIsSaving(true);
    try {
      localStorage.setItem("swapnojatri_about_cms", JSON.stringify(cmsConfig));
      const res = await fetch("/api/cms/about", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ data: cmsConfig }),
      });
      const json = await res.json();
      if (json.success) {
        showToast(isBangla ? "সব ছবি ও কন্টেন্ট সফলভাবে সংরক্ষিত হয়েছে!" : "About Page visuals saved and published!");
      } else {
        showToast(json.message || "Failed to publish", "error");
      }
    } catch (err) {
      showToast(isBangla ? "লোকাল স্টোরেজে সংরক্ষিত হয়েছে।" : "Saved to local cache.", "success");
    } finally {
      setIsSaving(false);
    }
  };

  const handleResetDefaults = () => {
    if (confirm(isBangla ? "আপনি কি ডিফল্ট ছবি ও কন্টেন্টে রিসেট করতে চান?" : "Reset all About page media to verified defaults?")) {
      setCmsConfig({ ...DEFAULT_ABOUT_CMS });
      localStorage.setItem("swapnojatri_about_cms", JSON.stringify(DEFAULT_ABOUT_CMS));
      showToast(isBangla ? "ডিফল্ট সেটিংসে রিসেট হয়েছে।" : "Reset to default media presets.");
    }
  };

  // Hero edits
  const handleHeroChange = (field: string, val: string) => {
    setCmsConfig((prev) => ({
      ...prev,
      heroImage: {
        ...prev.heroImage,
        [field]: val,
      },
    }));
  };

  // Gallery CRUD
  const handleDeleteImage = (id: string) => {
    if (confirm(isBangla ? "এই ছবিটি গ্যালারি থেকে মুছে ফেলতে চান?" : "Delete this image from About gallery?")) {
      setCmsConfig((prev) => ({
        ...prev,
        storyImages: prev.storyImages.filter((img) => img.id !== id),
      }));
      showToast(isBangla ? "ছবি মুছে ফেলা হয়েছে।" : "Image removed.");
    }
  };

  const openAddModal = () => {
    setFormImage({
      id: `story-${Date.now()}`,
      title: "",
      titleBn: "",
      category: "REAL ESTATE",
      categoryBn: "জমি ও আবাসন",
      imageUrl: "/images/landvest_hero.jpg",
      caption: "",
      captionBn: "",
    });
    setIsAddingNew(true);
    setEditingImage(null);
  };

  const openEditModal = (item: AboutImageItem) => {
    setFormImage({ ...item });
    setEditingImage(item);
    setIsAddingNew(false);
  };

  const handleSaveModalImage = (e: React.FormEvent) => {
    e.preventDefault();
    if (!formImage.imageUrl || !formImage.title) {
      alert("Please provide at least a title and image URL");
      return;
    }

    if (editingImage) {
      setCmsConfig((prev) => ({
        ...prev,
        storyImages: prev.storyImages.map((img) => (img.id === formImage.id ? formImage : img)),
      }));
      showToast(isBangla ? "ছবি সফলভাবে আপডেট করা হয়েছে।" : "Image details updated.");
    } else {
      setCmsConfig((prev) => ({
        ...prev,
        storyImages: [...prev.storyImages, formImage],
      }));
      showToast(isBangla ? "নতুন ছবি সফলভাবে যোগ করা হয়েছে।" : "New image added to gallery.");
    }

    setEditingImage(null);
    setIsAddingNew(false);
  };

  return (
    <div className="space-y-8 max-w-6xl pb-16">
      {/* Toast */}
      {toast && (
        <div
          className={`fixed bottom-6 right-6 z-50 px-5 py-3 rounded-2xl text-xs sm:text-sm font-bold shadow-2xl flex items-center gap-2 border transition-all animate-in fade-in slide-in-from-bottom-2 ${
            toast.type === "success"
              ? "bg-slate-900 text-white border-emerald-500/50"
              : "bg-red-900 text-white border-red-500"
          }`}
        >
          <CheckCircle2 className="w-4 h-4 text-emerald-400" />
          <span>{toast.text}</span>
        </div>
      )}

      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4 border-b border-slate-200">
        <div>
          <div className="inline-flex items-center gap-2 px-2.5 py-0.5 rounded-full text-xs font-bold uppercase tracking-wider bg-blue-50 text-[#0066FF] border border-blue-200/60 mb-1.5">
            <Sparkles className="w-3.5 h-3.5" />
            <span>{isBangla ? "আমাদের গল্প / CMS কন্ট্রোল" : "Our Story Media CMS"}</span>
          </div>
          <h1 className="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
            {isBangla ? "আমাদের গল্প ও দর্শন (About Page) ছবি ব্যবস্থাপনা" : "About Page Visual Story & CMS"}
          </h1>
          <p className="text-xs sm:text-sm text-slate-500 max-w-2xl">
            {isBangla
              ? "ওয়েবসাইটের /about পেজের প্রধান ফিচার ছবি, সাইট অ্যালবাম ও বিবরণ অ্যাডমিন প্যানেল থেকে সরাসরি পরিবর্তন ও নিয়ন্ত্রণ করুন।"
              : "Control the featured story visual, ground inspection album, and captions displayed on the public /about page."}
          </p>
        </div>

        <div className="flex items-center gap-2.5 shrink-0">
          <Link
            href="/about"
            target="_blank"
            className="px-3.5 py-2 rounded-xl bg-white hover:bg-slate-50 border border-slate-200 text-xs font-bold text-slate-700 flex items-center gap-1.5 shadow-2xs transition-all cursor-pointer"
          >
            <ExternalLink className="w-3.5 h-3.5 text-[#0066FF]" />
            <span>{isBangla ? "পাবলিক পেজ দেখুন" : "View Live Page"}</span>
          </Link>

          <button
            type="button"
            onClick={handleResetDefaults}
            className="px-3.5 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold flex items-center gap-1.5 transition-all cursor-pointer"
            title="Reset to default seed data"
          >
            <RotateCcw className="w-3.5 h-3.5" />
            <span className="hidden sm:inline">{isBangla ? "রিসেট" : "Reset"}</span>
          </button>

          <button
            type="button"
            onClick={handleSaveAll}
            disabled={isSaving}
            className="px-5 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold flex items-center gap-1.5 shadow-md shadow-[#0066FF]/20 transition-all cursor-pointer disabled:opacity-50"
          >
            <Save className="w-3.5 h-3.5" />
            <span>{isSaving ? (isBangla ? "সংরক্ষণ হচ্ছে..." : "Publishing...") : isBangla ? "সংরক্ষণ ও প্রকাশ" : "Save & Publish"}</span>
          </button>
        </div>
      </div>

      {/* SECTION 1: FEATURED STORY HERO IMAGE */}
      <div className="bg-white rounded-3xl border border-slate-200/90 shadow-sm p-6 sm:p-7 space-y-6">
        <div className="flex items-center justify-between pb-3 border-b border-slate-100">
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-blue-50 text-[#0066FF] flex items-center justify-center">
              <ImageIcon className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-base sm:text-lg font-bold text-slate-900">
                {isBangla ? "১. প্রধান স্টোরি ব্যানার ছবি (Featured Story Visual)" : "1. Featured Story Hero Media"}
              </h2>
              <p className="text-xs text-slate-500">
                {isBangla
                  ? "আমাদের মূল দর্শন সেকশনের সাথে প্রদর্শিত মূল প্রকল্পের ভিজ্যুয়াল"
                  : "Shown alongside Our Core Philosophy on the /about page"}
              </p>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
          {/* Live Preview Box */}
          <div className="lg:col-span-5 space-y-2">
            <span className="text-xs font-bold text-slate-700 flex items-center gap-1">
              <Eye className="w-3.5 h-3.5 text-[#0066FF]" />
              <span>{isBangla ? "লাইভ ভিজ্যুয়াল প্রিভিউ" : "Live Visual Preview"}</span>
            </span>
            <div className="relative rounded-2xl overflow-hidden border border-slate-200 shadow-md h-52 sm:h-60 bg-slate-950 group">
              <img
                src={cmsConfig.heroImage.imageUrl}
                alt="Featured Story"
                className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-slate-950/85 via-slate-950/20 to-transparent pointer-events-none" />

              {/* Top Badge */}
              <div className="absolute top-3 left-3">
                <span className="px-2.5 py-1 rounded-full text-[10px] font-mono font-bold bg-[#040D1A]/80 backdrop-blur-md text-cyan-light border border-white/20 shadow-xs">
                  {isBangla ? cmsConfig.heroImage.badgeBn || cmsConfig.heroImage.badge : cmsConfig.heroImage.badge}
                </span>
              </div>

              {/* Bottom Caption */}
              <div className="absolute bottom-3 left-3 right-3">
                <p className="text-xs text-white/90 font-medium line-clamp-2 drop-shadow">
                  {isBangla ? cmsConfig.heroImage.captionBn || cmsConfig.heroImage.caption : cmsConfig.heroImage.caption}
                </p>
              </div>
            </div>
          </div>

          {/* Controls */}
          <div className="lg:col-span-7 space-y-4">
            <div>
              <label className="text-xs font-bold text-slate-700 block mb-1.5">
                {isBangla ? "ছবির লিঙ্ক (Image URL):" : "Image URL:"}
              </label>
              <input
                type="text"
                value={cmsConfig.heroImage.imageUrl}
                onChange={(e) => handleHeroChange("imageUrl", e.target.value)}
                placeholder="/images/hero_investment_bg.jpg or https://..."
                className="w-full px-3.5 py-2 text-xs rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF] font-mono"
              />
            </div>

            {/* Quick Presets Picker */}
            <div>
              <span className="text-[11px] font-bold text-slate-500 block mb-1.5">
                {isBangla ? "প্ল্যাটফর্ম ভেরিফাইড প্রিসেট থেকে বাছাই করুন:" : "Quick Preset Library:"}
              </span>
              <div className="flex flex-wrap gap-1.5">
                {PLATFORM_ASSET_PRESETS.map((preset, idx) => (
                  <button
                    key={idx}
                    type="button"
                    onClick={() => handleHeroChange("imageUrl", preset.url)}
                    className={`px-2.5 py-1 rounded-lg text-[10px] font-bold border transition-all cursor-pointer ${
                      cmsConfig.heroImage.imageUrl === preset.url
                        ? "bg-[#0066FF] text-white border-[#0066FF]"
                        : "bg-slate-100 hover:bg-slate-200 text-slate-700 border-slate-200"
                    }`}
                  >
                    {isBangla ? preset.nameBn : preset.name}
                  </button>
                ))}
              </div>
            </div>

            {/* Badge Inputs */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="text-[11px] font-bold text-slate-600 block mb-1">Badge (English):</label>
                <input
                  type="text"
                  value={cmsConfig.heroImage.badge}
                  onChange={(e) => handleHeroChange("badge", e.target.value)}
                  className="w-full px-3 py-1.5 text-xs rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>
              <div>
                <label className="text-[11px] font-bold text-slate-600 block mb-1">ব্যাজ (বাংলা):</label>
                <input
                  type="text"
                  value={cmsConfig.heroImage.badgeBn}
                  onChange={(e) => handleHeroChange("badgeBn", e.target.value)}
                  className="w-full px-3 py-1.5 text-xs rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>
            </div>

            {/* Caption Inputs */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <label className="text-[11px] font-bold text-slate-600 block mb-1">Caption (English):</label>
                <textarea
                  rows={2}
                  value={cmsConfig.heroImage.caption}
                  onChange={(e) => handleHeroChange("caption", e.target.value)}
                  className="w-full px-3 py-1.5 text-xs rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>
              <div>
                <label className="text-[11px] font-bold text-slate-600 block mb-1">ক্যাপশন (বাংলা):</label>
                <textarea
                  rows={2}
                  value={cmsConfig.heroImage.captionBn}
                  onChange={(e) => handleHeroChange("captionBn", e.target.value)}
                  className="w-full px-3 py-1.5 text-xs rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* SECTION 2: STORY VISUAL ALBUM & FIELD GALLERY */}
      <div className="bg-white rounded-3xl border border-slate-200/90 shadow-sm p-6 sm:p-7 space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-slate-100">
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
              <Layers className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-base sm:text-lg font-bold text-slate-900">
                {isBangla ? "২. বাস্তব প্রকল্প ও সাইট অ্যালবাম (Ground Reality Album)" : "2. Visual Ground Reality Gallery"}
              </h2>
              <p className="text-xs text-slate-500">
                {isBangla
                  ? "/about পেজে প্রদর্শিত জমির অবস্থা, এগ্রো ও অবকাঠামো উন্নয়নের ছবি ও বিবরণ"
                  : "Curated photo album highlighting real project milestones and assets on /about"}
              </p>
            </div>
          </div>

          <button
            type="button"
            onClick={openAddModal}
            className="px-4 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold flex items-center gap-1.5 shadow-sm transition-all cursor-pointer shrink-0"
          >
            <Plus className="w-4 h-4" />
            <span>{isBangla ? "নতুন ছবি যোগ করুন" : "Add New Image"}</span>
          </button>
        </div>

        {/* Gallery Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {cmsConfig.storyImages.map((img) => (
            <div
              key={img.id}
              className="bg-slate-50 rounded-2xl border border-slate-200/80 overflow-hidden flex flex-col justify-between group shadow-2xs hover:shadow-md transition-all"
            >
              {/* Thumbnail */}
              <div className="relative h-36 bg-slate-900 overflow-hidden">
                <img
                  src={img.imageUrl}
                  alt={img.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-slate-950/80 via-transparent to-transparent" />
                <span className="absolute top-2 left-2 px-2 py-0.5 rounded text-[9px] font-bold uppercase tracking-wider bg-[#040D1A]/80 text-cyan-light border border-white/20">
                  {isBangla ? img.categoryBn || img.category : img.category}
                </span>
              </div>

              {/* Body */}
              <div className="p-3.5 space-y-1.5 flex-1 flex flex-col justify-between">
                <div>
                  <h4 className="text-xs font-bold text-slate-900 line-clamp-1">
                    {isBangla ? img.titleBn || img.title : img.title}
                  </h4>
                  <p className="text-[11px] text-slate-500 line-clamp-2 font-normal leading-relaxed mt-1">
                    {isBangla ? img.captionBn || img.caption : img.caption}
                  </p>
                </div>

                {/* Actions */}
                <div className="pt-2 border-t border-slate-200/60 flex items-center justify-between gap-2">
                  <button
                    type="button"
                    onClick={() => openEditModal(img)}
                    className="text-xs font-bold text-[#0066FF] hover:underline flex items-center gap-1 cursor-pointer"
                  >
                    <Edit2 className="w-3 h-3" />
                    <span>{isBangla ? "সম্পাদনা" : "Edit"}</span>
                  </button>

                  <button
                    type="button"
                    onClick={() => handleDeleteImage(img.id)}
                    className="text-xs font-bold text-red-600 hover:text-red-700 flex items-center gap-1 cursor-pointer"
                  >
                    <Trash2 className="w-3 h-3" />
                    <span>{isBangla ? "মুছুন" : "Delete"}</span>
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* MODAL: ADD / EDIT GALLERY IMAGE */}
      {(isAddingNew || editingImage) && (
        <div className="fixed inset-0 z-50 bg-slate-950/60 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl max-w-xl w-full border border-slate-200 shadow-2xl p-6 sm:p-7 space-y-5 animate-in fade-in zoom-in-95">
            <div className="flex items-center justify-between pb-3 border-b border-slate-100">
              <h3 className="font-extrabold text-slate-900 text-base sm:text-lg">
                {editingImage
                  ? isBangla ? "ছবি তথ্য সম্পাদনা" : "Edit Image Details"
                  : isBangla ? "নতুন ছবি যুক্ত করুন" : "Add New Image to About Gallery"}
              </h3>
              <button
                type="button"
                onClick={() => {
                  setEditingImage(null);
                  setIsAddingNew(false);
                }}
                className="w-7 h-7 rounded-full bg-slate-100 hover:bg-slate-200 text-slate-700 flex items-center justify-center text-xs font-bold cursor-pointer"
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSaveModalImage} className="space-y-4 text-xs">
              {/* Image Preview & URL */}
              <div>
                <label className="font-bold text-slate-700 block mb-1">Image URL / Path:</label>
                <div className="flex gap-2">
                  <input
                    type="text"
                    required
                    value={formImage.imageUrl}
                    onChange={(e) => setFormImage({ ...formImage, imageUrl: e.target.value })}
                    className="flex-1 px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF] font-mono"
                    placeholder="/images/gallery_land.jpg or https://..."
                  />
                </div>
              </div>

              {/* Quick Presets for Modal */}
              <div>
                <span className="text-[10px] font-bold text-slate-500 block mb-1">Select from Platform Presets:</span>
                <div className="flex flex-wrap gap-1">
                  {PLATFORM_ASSET_PRESETS.map((p, i) => (
                    <button
                      key={i}
                      type="button"
                      onClick={() => setFormImage({ ...formImage, imageUrl: p.url })}
                      className="px-2 py-0.5 rounded text-[10px] bg-slate-100 hover:bg-slate-200 text-slate-700 border border-slate-200 cursor-pointer"
                    >
                      {p.name.split(" ")[0]} ({p.category})
                    </button>
                  ))}
                </div>
              </div>

              {/* Titles */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="font-bold text-slate-700 block mb-1">Title (English):</label>
                  <input
                    type="text"
                    required
                    value={formImage.title}
                    onChange={(e) => setFormImage({ ...formImage, title: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                    placeholder="e.g. Ground Inspection at Site"
                  />
                </div>
                <div>
                  <label className="font-bold text-slate-700 block mb-1">শিরোনাম (বাংলা):</label>
                  <input
                    type="text"
                    value={formImage.titleBn}
                    onChange={(e) => setFormImage({ ...formImage, titleBn: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                    placeholder="যেমন: সাইট পরিদর্শন ও সীমানা প্রাচীর"
                  />
                </div>
              </div>

              {/* Categories */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="font-bold text-slate-700 block mb-1">Category (English):</label>
                  <input
                    type="text"
                    value={formImage.category}
                    onChange={(e) => setFormImage({ ...formImage, category: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                  />
                </div>
                <div>
                  <label className="font-bold text-slate-700 block mb-1">ক্যাটাগরি (বাংলা):</label>
                  <input
                    type="text"
                    value={formImage.categoryBn}
                    onChange={(e) => setFormImage({ ...formImage, categoryBn: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                  />
                </div>
              </div>

              {/* Captions */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="font-bold text-slate-700 block mb-1">Caption (English):</label>
                  <textarea
                    rows={2}
                    value={formImage.caption}
                    onChange={(e) => setFormImage({ ...formImage, caption: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                    placeholder="Short description..."
                  />
                </div>
                <div>
                  <label className="font-bold text-slate-700 block mb-1">ক্যাপশন (বাংলা):</label>
                  <textarea
                    rows={2}
                    value={formImage.captionBn}
                    onChange={(e) => setFormImage({ ...formImage, captionBn: e.target.value })}
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 focus:outline-hidden focus:border-[#0066FF]"
                    placeholder="সংক্ষিপ্ত বিবরণ..."
                  />
                </div>
              </div>

              {/* Submit Buttons */}
              <div className="flex items-center justify-end gap-2 pt-3 border-t border-slate-100">
                <button
                  type="button"
                  onClick={() => {
                    setEditingImage(null);
                    setIsAddingNew(false);
                  }}
                  className="px-4 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold transition-all cursor-pointer"
                >
                  {isBangla ? "বাতিল" : "Cancel"}
                </button>
                <button
                  type="submit"
                  className="px-5 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold transition-all cursor-pointer shadow-md"
                >
                  {editingImage ? (isBangla ? "আপডেট করুন" : "Update") : isBangla ? "যুক্ত করুন" : "Add Image"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
