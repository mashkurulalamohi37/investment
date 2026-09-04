"use client";

import React, { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  LayoutDashboard,
  Coins,
  TrendingUp,
  UserCheck,
  Headphones,
  LogOut,
  PlusCircle,
  ShieldCheck,
  Home,
  Lock,
  ChevronRight,
  Globe,
  Menu,
  X,
} from "lucide-react";

export default function DashboardNav() {
  const pathname = usePathname();
  const { user, logout, isBangla, toggleLanguage } = useAuth();
  const [mobileOpen, setMobileOpen] = useState(false);

  const primaryLinks = [
    {
      href: "/dashboard",
      label: isBangla ? "ড্যাশবোর্ড" : "Overview",
      icon: LayoutDashboard,
    },
    {
      href: "/dashboard/investments",
      label: isBangla ? "আমার বিনিয়োগ" : "My Portfolio",
      icon: Coins,
      badge: isBangla ? "৪টি শেয়ার" : "4 Shares",
      badgeColor: "bg-[#EBF3FF] text-[#0066FF]",
    },
    {
      href: "/dashboard/investments/new",
      label: isBangla ? "নতুন শেয়ার ক্রয়" : "Invest in Shares",
      icon: PlusCircle,
      badge: isBangla ? "নতুন" : "New",
      badgeColor: "bg-emerald-50 text-emerald-700 border border-emerald-200/60",
      highlight: true,
    },
    {
      href: "/dashboard/distributions",
      label: isBangla ? "লভ্যাংশ ও লেনদেন" : "Transactions & Profit",
      icon: TrendingUp,
    },
  ];

  const secondaryLinks = [
    {
      href: "/dashboard/profile/kyc",
      label: isBangla ? "প্রোফাইল ও নিরাপত্তা" : "Profile & Security",
      icon: UserCheck,
      verified: true,
    },
    {
      href: "/dashboard/support",
      label: isBangla ? "সহায়তা ও সাপোর্ট" : "Help & Support",
      icon: Headphones,
    },
  ];

  // Helper for initials
  const getInitials = (name?: string) => {
    if (!name) return "TI";
    const parts = name.trim().split(" ");
    if (parts.length >= 2) return `${parts[0][0]}${parts[1][0]}`.toUpperCase();
    return name.slice(0, 2).toUpperCase();
  };

  const navContent = (
    <div className="flex flex-col justify-between h-full p-4 lg:p-5 font-sans">
      <div className="space-y-4">
        {/* Official Brand Header */}
        <div className="flex items-center justify-between pb-3.5 border-b border-white/10 px-1">
          <Link href="/" className="flex items-center gap-2.5 group">
            <div className="w-8 h-8 shrink-0 relative transition-transform duration-200 group-hover:scale-105">
              <img
                src="/swapnojatri_logo.svg"
                alt="স্বপ্নযাত্রী"
                className="w-full h-full object-contain filter drop-shadow-sm"
              />
            </div>
            <div className="flex flex-col">
              <span className="font-bold text-base text-white leading-tight group-hover:text-[#00B4D8] transition-colors">
                {isBangla ? "স্বপ্নযাত্রী" : "Swapnojatri"}
              </span>
              <span className="text-[11px] font-semibold text-[#00B4D8]">
                {isBangla ? "ইনভেস্টমেন্ট প্ল্যাটফর্ম" : "Investment Platform"}
              </span>
            </div>
          </Link>

          <div className="flex items-center gap-1.5">
            {/* Language Switcher */}
            <button
              onClick={toggleLanguage}
              className="flex items-center gap-1 px-2.5 py-1 rounded-xl bg-white/10 hover:bg-white/20 text-[#00B4D8] border border-white/10 text-xs font-bold transition-all cursor-pointer"
              title={isBangla ? "Switch to English" : "বাংলায় পরিবর্তন করুন"}
            >
              <Globe className="w-3.5 h-3.5 text-[#00B4D8]" />
              <span>{isBangla ? "EN" : "বাং"}</span>
            </button>

            {/* Back to Home */}
            <Link
              href="/"
              className="p-1.5 rounded-xl bg-white/5 hover:bg-white/10 text-slate-300 hover:text-white transition-colors"
              title="Return to public website"
            >
              <Home className="w-4 h-4" />
            </Link>

            {/* Mobile Close Button */}
            <button
              onClick={() => setMobileOpen(false)}
              className="md:hidden p-1.5 rounded-xl bg-white/10 text-white hover:bg-white/20"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* User Card */}
        <div className="p-2.5 rounded-2xl bg-[#0F2F57]/80 border border-white/10 flex items-center gap-2.5 shadow-sm">
          <div className="w-9 h-9 rounded-xl bg-gradient-to-tr from-[#0066FF] to-[#00B4D8] flex items-center justify-center text-white font-extrabold text-xs shadow-md shrink-0">
            {getInitials(user?.full_name || "Tariqul Islam")}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-1.5">
              <span className="font-bold text-xs text-white truncate block">
                {user?.full_name || (isBangla ? "তারিকুল ইসলাম চৌধুরী" : "Tariqul Islam Chowdhury")}
              </span>
              <span className="shrink-0 w-2 h-2 rounded-full bg-emerald-400"></span>
            </div>
            <span className="text-[10px] text-slate-400 block truncate">
              {isBangla ? "ভিআইপি শেয়ারহোল্ডার" : "VIP Shareholder (4 Lots)"}
            </span>
          </div>
        </div>

        {/* Primary Menu */}
        <div className="space-y-1">
          <span className="text-[10px] font-mono font-bold text-slate-400 px-2 tracking-wider uppercase block">
            {isBangla ? "পোর্টফোলিও মেন্যু" : "PORTFOLIO OPS"}
          </span>
          {primaryLinks.map((item) => {
            const isActive = pathname === item.href;
            const Icon = item.icon;
            return (
              <Link
                key={item.href}
                href={item.href}
                onClick={() => setMobileOpen(false)}
                className={`flex items-center justify-between px-3 py-2 rounded-xl text-xs font-bold transition-all duration-150 ${
                  isActive
                    ? "bg-[#0066FF] text-white shadow-md shadow-blue-500/20"
                    : "text-slate-300 hover:bg-white/5 hover:text-white"
                }`}
              >
                <div className="flex items-center gap-2.5">
                  <Icon className={`w-4 h-4 ${isActive ? "text-white" : "text-slate-400"}`} />
                  <span>{item.label}</span>
                </div>
                {item.badge && (
                  <span
                    className={`text-[10px] px-1.5 py-0.5 rounded-md font-extrabold ${
                      isActive ? "bg-white/20 text-white" : item.badgeColor
                    }`}
                  >
                    {item.badge}
                  </span>
                )}
              </Link>
            );
          })}
        </div>

        {/* Secondary Menu */}
        <div className="space-y-1 pt-2 border-t border-white/10">
          <span className="text-[10px] font-mono font-bold text-slate-400 px-2 tracking-wider uppercase block">
            {isBangla ? "অ্যাকাউন্ট ও নিরাপত্তা" : "ACCOUNT & TRUST"}
          </span>
          {secondaryLinks.map((item) => {
            const isActive = pathname === item.href;
            const Icon = item.icon;
            return (
              <Link
                key={item.href}
                href={item.href}
                onClick={() => setMobileOpen(false)}
                className={`flex items-center justify-between px-3 py-2 rounded-xl text-xs font-bold transition-all duration-150 ${
                  isActive
                    ? "bg-[#0066FF] text-white shadow-md shadow-blue-500/20"
                    : "text-slate-300 hover:bg-white/5 hover:text-white"
                }`}
              >
                <div className="flex items-center gap-2.5">
                  <Icon className={`w-4 h-4 ${isActive ? "text-white" : "text-slate-400"}`} />
                  <span>{item.label}</span>
                </div>
                {item.verified && (
                  <span className="text-[9px] px-1.5 py-0.5 rounded bg-emerald-500/20 text-emerald-300 font-bold">
                    ✓ {isBangla ? "যাচাইকৃত" : "Verified"}
                  </span>
                )}
              </Link>
            );
          })}
        </div>
      </div>

      {/* Footer / Logout */}
      <div className="space-y-3 pt-3 border-t border-white/10">
        <button
          onClick={() => {
            logout();
            setMobileOpen(false);
          }}
          className="w-full flex items-center justify-between px-3 py-2 rounded-xl text-xs font-bold text-red-300 hover:bg-red-500/10 hover:text-red-200 transition-colors cursor-pointer"
        >
          <div className="flex items-center gap-2.5">
            <LogOut className="w-4 h-4" />
            <span>{isBangla ? "লগআউট করুন" : "Sign Out"}</span>
          </div>
          <ChevronRight className="w-3.5 h-3.5 opacity-50" />
        </button>

        <div className="p-2 rounded-xl bg-white/5 border border-white/5 flex items-center gap-2 text-[10px] text-slate-400">
          <ShieldCheck className="w-3.5 h-3.5 text-[#00B4D8] shrink-0" />
          <span className="truncate">{isBangla ? "সিটি ব্যাংক এসক্রো সুরক্ষিত" : "The City Bank Escrow Protected"}</span>
        </div>
      </div>
    </div>
  );

  return (
    <>
      {/* Mobile Top Header Bar */}
      <div className="md:hidden flex items-center justify-between px-4 py-3 bg-[#0A2540] text-white border-b border-[#153456] w-full shrink-0 z-30 shadow-md">
        <Link href="/" className="flex items-center gap-2">
          <div className="w-7 h-7 shrink-0 relative">
            <img src="/swapnojatri_logo.svg" alt="Swapnojatri" className="w-full h-full object-contain" />
          </div>
          <span className="font-bold text-sm text-white">{isBangla ? "স্বপ্নযাত্রী পোর্টাল" : "Investor Portal"}</span>
        </Link>
        <div className="flex items-center gap-2">
          <button
            onClick={toggleLanguage}
            className="px-2 py-1 rounded-lg bg-white/10 text-xs font-bold text-[#00B4D8]"
          >
            {isBangla ? "EN" : "বাং"}
          </button>
          <button
            onClick={() => setMobileOpen(!mobileOpen)}
            className="p-1.5 rounded-lg bg-white/10 text-white hover:bg-white/20"
          >
            {mobileOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
          </button>
        </div>
      </div>

      {/* Mobile Drawer Overlay */}
      {mobileOpen && (
        <div className="fixed inset-0 z-50 md:hidden bg-slate-900/60 backdrop-blur-xs flex">
          <div className="w-72 max-w-[85vw] bg-[#0A2540] text-white h-full shadow-2xl overflow-y-auto animate-in slide-in-from-left duration-200">
            {navContent}
          </div>
          <div className="flex-1" onClick={() => setMobileOpen(false)} />
        </div>
      )}

      {/* Desktop Persistent Sidebar */}
      <aside className="hidden md:flex w-64 lg:w-72 bg-[#0A2540] text-white border-r border-[#153456] flex-col h-screen overflow-y-auto shrink-0 relative z-20 font-sans shadow-xl">
        {navContent}
      </aside>
    </>
  );
}
