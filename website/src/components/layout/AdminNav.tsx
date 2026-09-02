"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import {
  ShieldAlert,
  CreditCard,
  Receipt,
  Layers,
  Users,
  TrendingUp,
  LogOut,
  Home,
  FileCheck2,
} from "lucide-react";

export default function AdminNav() {
  const pathname = usePathname();
  const { logout, user } = useAuth();

  const links = [
    { href: "/admin", label: "Executive Dashboard", icon: ShieldAlert },
    { href: "/admin/payments", label: "Payment Verification Queue", icon: CreditCard, badge: "3" },
    { href: "/admin/expenses", label: "Expense Vouchers Ledger", icon: Receipt },
  ];

  return (
    <aside className="w-64 bg-slate-900 text-slate-300 border-r border-slate-800 flex flex-col justify-between p-4 min-h-screen">
      <div className="space-y-6">
        {/* Admin Header */}
        <div className="flex items-center justify-between pb-4 border-b border-slate-800 px-2">
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-gold text-slate-950 font-black text-base flex items-center justify-center">
              AD
            </div>
            <div>
              <span className="font-bold text-sm text-white block">Swapnojatri</span>
              <span className="text-[10px] text-gold font-mono font-bold">ADMIN CONSOLE</span>
            </div>
          </div>
          <Link href="/" className="p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-slate-800">
            <Home className="w-4 h-4" />
          </Link>
        </div>

        {/* User Card */}
        <div className="p-3 rounded-xl bg-slate-800/80 border border-slate-700/80 space-y-1">
          <span className="text-xs font-bold text-white block truncate">
            {user?.full_name || "Tanvir Ahmed (Admin)"}
          </span>
          <span className="text-[10px] text-gold font-mono block">SUPER_ADMIN</span>
        </div>

        {/* Navigation Links */}
        <nav className="space-y-1 text-xs font-semibold">
          {links.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                className={`flex items-center justify-between px-3.5 py-2.5 rounded-xl transition-all ${
                  isActive
                    ? "bg-gold text-slate-950 font-bold shadow-md shadow-gold/20"
                    : "text-slate-300 hover:bg-slate-800 hover:text-white"
                }`}
              >
                <div className="flex items-center gap-2.5">
                  <link.icon className="w-4 h-4" />
                  <span>{link.label}</span>
                </div>
                {link.badge && (
                  <span
                    className={`px-1.5 py-0.5 rounded text-[10px] font-bold ${
                      isActive ? "bg-slate-950 text-gold" : "bg-red-500 text-white"
                    }`}
                  >
                    {link.badge}
                  </span>
                )}
              </Link>
            );
          })}
        </nav>
      </div>

      <div className="pt-4 border-t border-slate-800">
        <button
          onClick={logout}
          className="w-full flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-semibold text-red-400 hover:bg-red-950/40"
        >
          <LogOut className="w-4 h-4" />
          <span>Exit Admin Session</span>
        </button>
      </div>
    </aside>
  );
}
