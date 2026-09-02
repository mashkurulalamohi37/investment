"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  LayoutDashboard,
  Coins,
  TrendingUp,
  FileCheck2,
  UserCheck,
  Headphones,
  LogOut,
  PlusCircle,
  ShieldCheck,
  Home,
} from "lucide-react";

export default function DashboardNav() {
  const pathname = usePathname();
  const { user, logout, isBangla } = useAuth();

  const links = [
    { href: "/dashboard", label: isBangla ? "ড্যাশবোর্ড" : "Overview", icon: LayoutDashboard },
    { href: "/dashboard/investments", label: isBangla ? "আমার বিনিয়োগ" : "My Investments", icon: Coins },
    { href: "/dashboard/investments/new", label: isBangla ? "নতুন শেয়ার ক্রয়" : "Invest in Shares", icon: PlusCircle, highlight: true },
    { href: "/dashboard/distributions", label: isBangla ? "লভ্যাংশ হিসেব" : "Distributions", icon: TrendingUp },
    { href: "/dashboard/profile/kyc", label: isBangla ? "এনআইডি ও কেওয়াইসি" : "KYC Compliance", icon: UserCheck },
    { href: "/dashboard/support", label: isBangla ? "সহায়তা ডেস্ক" : "Support", icon: Headphones },
  ];

  return (
    <aside className="w-64 bg-white border-r border-slate-200/90 flex flex-col justify-between p-4 min-h-screen">
      <div className="space-y-6">
        {/* Brand & Home Link */}
        <div className="flex items-center justify-between pb-4 border-b border-slate-100 px-2">
          <Link href="/" className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-gradient-emerald flex items-center justify-center font-bold text-gold text-base">
              SJ
            </div>
            <span className="font-bold text-base text-slate-900">Swapnojatri</span>
          </Link>
          <Link href="/" className="p-1.5 text-slate-400 hover:text-slate-700 rounded-lg hover:bg-slate-100" title="Back to Website">
            <Home className="w-4 h-4" />
          </Link>
        </div>

        {/* User Card */}
        <div className="p-3 rounded-xl bg-slate-50 border border-slate-200/80 space-y-1">
          <span className="text-xs font-bold text-slate-900 block truncate">
            {user?.full_name || "Verified Investor"}
          </span>
          <span className="text-[11px] text-slate-500 font-mono block">
            {user?.phone || "+8801712345678"}
          </span>
          <div className="pt-1 flex items-center gap-1 text-[10px] font-bold text-emerald-800">
            <ShieldCheck className="w-3.5 h-3.5 text-jade" />
            <span>KYC VERIFIED</span>
          </div>
        </div>

        {/* Navigation Links */}
        <nav className="space-y-1">
          {links.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                className={`flex items-center gap-3 px-3.5 py-2.5 rounded-xl text-xs sm:text-sm font-semibold transition-all ${
                  isActive
                    ? "bg-brand-forest text-white shadow-sm shadow-brand-forest/20"
                    : link.highlight
                    ? "bg-gold/15 text-gold-dark hover:bg-gold/25 font-bold"
                    : "text-slate-600 hover:bg-slate-50 hover:text-slate-900"
                }`}
              >
                <link.icon className={`w-4 h-4 ${isActive ? "text-gold" : ""}`} />
                <span>{link.label}</span>
              </Link>
            );
          })}
        </nav>
      </div>

      {/* Logout Button */}
      <div className="pt-4 border-t border-slate-100">
        <button
          onClick={logout}
          className="w-full flex items-center gap-2.5 px-3.5 py-2 rounded-xl text-xs font-semibold text-red-600 hover:bg-red-50 transition-colors"
        >
          <LogOut className="w-4 h-4" />
          <span>{isBangla ? "লগআউট" : "Sign Out"}</span>
        </button>
      </div>
    </aside>
  );
}
