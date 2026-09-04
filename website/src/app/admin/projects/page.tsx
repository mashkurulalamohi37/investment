"use client";

import React, { useState } from "react";
import Link from "next/link";
import { formatBDT } from "@/lib/utils/currency";
import { useAuth } from "@/lib/auth/AuthContext";
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
} from "lucide-react";

export default function AdminProjectsPage() {
  const { isBangla } = useAuth();

  const [projects, setProjects] = useState([
    {
      id: "proj-lv-100",
      code: "LV100",
      name: "LandVest 100",
      name_bn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর)",
      category: "REAL_ESTATE",
      location: "Washpur Tower Road, Bosila, Dhaka",
      location_bn: "ওয়াশপুর টাওয়ার রোড, বসিলা, ঢাকা",
      targetFund: 2550000,
      pricePerShare: 25500,
      totalShares: 100,
      allocatedShares: 74,
      projectedRoiMin: 18.5,
      projectedRoiMax: 22.0,
      status: "OPEN",
    },
    {
      id: "proj-agro-01",
      code: "AGRO-S1",
      name: "Smart Organic Agro Farming (Season 1)",
      name_bn: "স্মার্ট অর্গানিক এগ্রো ফার্মিং (সিজন ১)",
      category: "AGRICULTURAL",
      location: "Singair Agro Belt, Manikganj",
      location_bn: "সিংগাইর এগ্রো বেল্ট, মানিকগঞ্জ",
      targetFund: 1500000,
      pricePerShare: 15000,
      totalShares: 100,
      allocatedShares: 42,
      projectedRoiMin: 20.0,
      projectedRoiMax: 24.5,
      status: "OPEN",
    },
    {
      id: "proj-dairy-02",
      code: "DAIRY-01",
      name: "Modern Dairy & Cattle Breed Project",
      name_bn: "আধুনিক ডেইরি ও সমন্বিত ক্যাটল প্রকল্প",
      category: "AGRICULTURAL",
      location: "Savar Dairy Zone, Dhaka",
      location_bn: "সাভার ডেইরি জোন, ঢাকা",
      targetFund: 3000000,
      pricePerShare: 30000,
      totalShares: 100,
      allocatedShares: 0,
      projectedRoiMin: 16.0,
      projectedRoiMax: 20.0,
      status: "UPCOMING",
    },
  ]);

  const [showModal, setShowModal] = useState(false);
  const [name, setName] = useState("");
  const [code, setCode] = useState("");
  const [category, setCategory] = useState("REAL_ESTATE");
  const [location, setLocation] = useState("");
  const [targetFund, setTargetFund] = useState("");
  const [totalShares, setTotalShares] = useState("100");
  const [pricePerShare, setPricePerShare] = useState("");
  const [roiMin, setRoiMin] = useState("18.0");
  const [roiMax, setRoiMax] = useState("22.0");

  const handleCreateProject = (e: React.FormEvent) => {
    e.preventDefault();
    const newProj = {
      id: `proj-${Date.now()}`,
      code: code.toUpperCase() || "NEW-01",
      name,
      name_bn: name,
      category,
      location,
      location_bn: location,
      targetFund: parseFloat(targetFund) || 2000000,
      pricePerShare: parseFloat(pricePerShare) || 20000,
      totalShares: parseInt(totalShares, 10) || 100,
      allocatedShares: 0,
      projectedRoiMin: parseFloat(roiMin) || 18,
      projectedRoiMax: parseFloat(roiMax) || 22,
      status: "OPEN",
    };
    setProjects([newProj, ...projects]);
    setShowModal(false);
    setName("");
    setCode("");
    setLocation("");
    setTargetFund("");
    setPricePerShare("");
  };

  return (
    <div className="space-y-4 sm:space-y-5">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3.5 border-b border-slate-200">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2 py-0.5 rounded text-[10px] font-mono font-bold bg-[#EBF3FF] text-[#0066FF] border border-[#0066FF]/20">
              {isBangla ? "মোট ৩টি প্রজেক্ট" : "3 TOTAL PROJECTS"}
            </span>
            <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
              {isBangla ? "২টি চলমান" : "2 LIVE"}
            </span>
          </div>
          <h1 className="text-xl sm:text-2xl font-black text-slate-900 tracking-tight mt-0.5">
            {isBangla ? "প্রজেক্ট স্পেকট্রাম ও সম্পদ ব্যবস্থাপনা" : "Project Spectrum & Asset Manager"}
          </h1>
          <p className="text-xs text-slate-500 font-medium">
            {isBangla
              ? "মাল্টি-প্রজেক্ট ক্রাউডফান্ডিং পোর্টফোলিও এবং শেয়ার বণ্টন তদারকি ও কনফিগারেশন"
              : "Create, configure, and monitor multi-project crowdfunding portfolios and share distributions"}
          </p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="self-start sm:self-auto inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white font-bold text-xs shadow-sm shadow-[#0066FF]/20 transition-all cursor-pointer"
        >
          <PlusCircle className="w-4 h-4 text-white" />
          <span>{isBangla ? "নতুন প্রজেক্ট চালু করুন" : "Launch New Project"}</span>
        </button>
      </div>

      {/* Projects Catalog Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {projects.map((proj) => {
          const percent = ((proj.allocatedShares / proj.totalShares) * 100).toFixed(0);
          return (
            <div
              key={proj.id}
              className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 sm:p-4.5 space-y-4 flex flex-col justify-between"
            >
              <div className="space-y-2.5">
                <div className="flex items-center justify-between">
                  <span className="px-2 py-0.5 rounded text-[11px] font-mono font-bold bg-slate-100 text-slate-800 border border-slate-200">
                    {proj.code}
                  </span>
                  <span
                    className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${
                      proj.status === "OPEN"
                        ? "bg-emerald-50 text-emerald-800 border border-emerald-200"
                        : "bg-blue-50 text-blue-800 border border-blue-200"
                    }`}
                  >
                    {proj.status === "OPEN"
                      ? isBangla ? "চলমান" : "OPEN"
                      : isBangla ? "আসন্ন" : "UPCOMING"}
                  </span>
                </div>

                <div>
                  <h3 className="text-base font-bold text-slate-900 line-clamp-1">
                    {isBangla ? proj.name_bn || proj.name : proj.name}
                  </h3>
                  <p className="text-[11px] text-slate-500 flex items-center gap-1 mt-0.5">
                    <MapPin className="w-3 h-3 text-slate-400 shrink-0" />
                    <span className="truncate">{isBangla ? proj.location_bn || proj.location : proj.location}</span>
                  </p>
                </div>

                {/* Progress Bar */}
                <div className="space-y-1 pt-1">
                  <div className="flex justify-between text-xs font-semibold">
                    <span className="text-slate-500 text-[11px]">
                      {isBangla
                        ? `বরাদ্দ: ${proj.allocatedShares}/${proj.totalShares} ভাগ`
                        : `Allocated: ${proj.allocatedShares}/${proj.totalShares} Shares`}
                    </span>
                    <span className="text-[#0066FF] font-bold text-[11px]">{percent}%</span>
                  </div>
                  <div className="h-2 rounded-full bg-slate-100 overflow-hidden border border-slate-200/60">
                    <div
                      className="h-full bg-[#0066FF] rounded-full transition-all duration-300"
                      style={{ width: `${percent}%` }}
                    />
                  </div>
                </div>

                {/* Financial Summary */}
                <div className="grid grid-cols-2 gap-2.5 pt-2.5 border-t border-slate-100 text-xs">
                  <div>
                    <span className="text-slate-500 block text-[10px]">
                      {isBangla ? "প্রতি শেয়ার মূল্য:" : "Unit Value:"}
                    </span>
                    <span className="text-slate-900 font-bold block text-xs sm:text-sm">
                      {formatBDT(proj.pricePerShare, { isBangla })}
                    </span>
                  </div>
                  <div>
                    <span className="text-slate-500 block text-[10px]">
                      {isBangla ? "মোট তহবিল লক্ষ্য:" : "Target Fund:"}
                    </span>
                    <span className="text-slate-900 font-bold block text-xs sm:text-sm">
                      {formatBDT(proj.targetFund, { isBangla })}
                    </span>
                  </div>
                </div>
              </div>

              <div className="pt-2.5 border-t border-slate-100 flex items-center justify-between text-xs">
                <span className="text-emerald-700 font-bold text-[11px]">
                  {proj.projectedRoiMin}% - {proj.projectedRoiMax}% ROI
                </span>
                <span className="text-slate-500 text-[11px] font-medium">
                  {proj.totalShares - proj.allocatedShares} {isBangla ? "টি শেয়ার বাকি" : "Shares Open"}
                </span>
              </div>
            </div>
          );
        })}
      </div>

      {/* Launch New Project Modal */}
      {showModal && (
        <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-xs flex items-center justify-center p-4">
          <div className="bg-white border border-slate-200 shadow-2xl rounded-2xl max-w-lg w-full p-5 sm:p-6 space-y-4">
            <div className="flex items-center justify-between pb-2.5 border-b border-slate-100">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Sparkles className="w-4 h-4 text-[#0066FF]" />
                <span>{isBangla ? "নতুন প্রজেক্ট তৈরি করুন" : "Launch New Investment Project"}</span>
              </h3>
              <button
                onClick={() => setShowModal(false)}
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
                    onChange={(e) => setCategory(e.target.value)}
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
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
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
                    className="w-full px-3 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-900 focus:outline-none focus:border-[#0066FF]"
                  />
                </div>
              </div>

              <div className="pt-2 flex items-center justify-end gap-2.5">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-4 py-2 rounded-xl text-slate-600 hover:bg-slate-100 text-xs font-bold"
                >
                  {isBangla ? "বাতিল" : "Cancel"}
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 rounded-xl bg-[#0066FF] hover:bg-[#0052CC] text-white text-xs font-bold shadow-sm shadow-[#0066FF]/20"
                >
                  {isBangla ? "প্রজেক্ট সংরক্ষণ করুন" : "Save Project"}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
