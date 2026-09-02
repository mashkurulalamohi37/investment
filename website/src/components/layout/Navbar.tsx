"use client";

import React, { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldCheck, Menu, X, Globe, User as UserIcon, LayoutDashboard, LogOut } from "lucide-react";

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();
  const { user, isAuthenticated, logout, isBangla, toggleLanguage } = useAuth();

  const navLinks = [
    { href: "/", label: isBangla ? "হোম" : "Home" },
    { href: "/projects/landvest-100", label: isBangla ? "ল্যান্ডভেস্ট ১০০" : "LandVest 100", badge: "Live" },
    { href: "/projects", label: isBangla ? "প্রকল্পসমূহ" : "All Projects" },
    { href: "/how-it-works", label: isBangla ? "কার্যপদ্ধতি" : "How It Works" },
    { href: "/documents", label: isBangla ? "আইনি দলিলপত্র" : "Legal Vault" },
    { href: "/about", label: isBangla ? "আমাদের সম্পর্কে" : "About" },
    { href: "/contact", label: isBangla ? "যোগাযোগ" : "Contact" },
  ];

  return (
    <header className="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-slate-200/80 transition-all">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-20">
          {/* Brand Logo */}
          <Link href="/" className="flex items-center gap-3 group">
            <div className="w-11 h-11 rounded-xl bg-gradient-emerald flex items-center justify-center shadow-md shadow-brand-forest/20 group-hover:scale-105 transition-transform">
              <span className="text-gold font-bold text-xl tracking-wider">SJ</span>
            </div>
            <div className="flex flex-col">
              <span className="font-bold text-xl tracking-tight text-slate-900 group-hover:text-brand-forest transition-colors">
                {isBangla ? "স্বপ্নযাত্রী" : "Swapnojatri"}
              </span>
              <span className="text-[11px] font-semibold text-brand-forest uppercase tracking-widest">
                {isBangla ? "ইনভেস্টমেন্ট প্ল্যাটফর্ম" : "Investment Platform"}
              </span>
            </div>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center gap-1 lg:gap-2">
            {navLinks.map((link) => {
              const isActive = pathname === link.href;
              return (
                <Link
                  key={link.href}
                  href={link.href}
                  className={`px-3 py-2 rounded-lg text-sm font-semibold transition-all relative ${
                    isActive
                      ? "text-brand-forest bg-brand-light"
                      : "text-slate-600 hover:text-slate-900 hover:bg-slate-50"
                  }`}
                >
                  {link.label}
                  {link.badge && (
                    <span className="ml-1.5 px-1.5 py-0.5 text-[10px] font-bold uppercase rounded bg-gold text-slate-950">
                      {link.badge}
                    </span>
                  )}
                </Link>
              );
            })}
          </nav>

          {/* Action CTAs */}
          <div className="hidden md:flex items-center gap-3">
            {/* Language Toggle */}
            <button
              onClick={toggleLanguage}
              className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-xs font-bold text-slate-700 bg-slate-100 hover:bg-slate-200 transition-colors"
              title="Toggle Language"
            >
              <Globe className="w-3.5 h-3.5 text-brand-forest" />
              <span>{isBangla ? "ENG" : "বাংলা"}</span>
            </button>

            {isAuthenticated ? (
              <div className="flex items-center gap-2">
                <Link
                  href="/dashboard"
                  className="flex items-center gap-2 px-4 py-2 rounded-xl bg-brand-forest text-white text-sm font-semibold hover:bg-brand-primary shadow-sm transition-all"
                >
                  <LayoutDashboard className="w-4 h-4 text-gold" />
                  <span>{isBangla ? "ড্যাশবোর্ড" : "Dashboard"}</span>
                </Link>
                {user?.role === "SUPER_ADMIN" || user?.role === "FINANCE_MANAGER" ? (
                  <Link
                    href="/admin"
                    className="px-3 py-2 rounded-xl bg-gold text-slate-950 text-xs font-bold hover:bg-gold-light transition-all"
                  >
                    Admin
                  </Link>
                ) : null}
                <button
                  onClick={logout}
                  className="p-2 text-slate-400 hover:text-red-600 rounded-lg hover:bg-red-50 transition-colors"
                  title="Logout"
                >
                  <LogOut className="w-4 h-4" />
                </button>
              </div>
            ) : (
              <div className="flex items-center gap-2">
                <Link
                  href="/login"
                  className="px-4 py-2 text-sm font-semibold text-slate-700 hover:text-slate-900 transition-colors"
                >
                  {isBangla ? "লগইন" : "Sign In"}
                </Link>
                <Link
                  href="/register"
                  className="px-4 py-2 rounded-xl bg-gradient-emerald text-white text-sm font-semibold hover:opacity-95 shadow-md shadow-brand-forest/20 transition-all"
                >
                  {isBangla ? "অ্যাকাউন্ট খুলুন" : "Join as Investor"}
                </Link>
              </div>
            )}
          </div>

          {/* Mobile Menu Button */}
          <div className="flex md:hidden items-center gap-2">
            <button
              onClick={toggleLanguage}
              className="px-2 py-1 text-xs font-bold text-slate-700 bg-slate-100 rounded"
            >
              {isBangla ? "EN" : "বাং"}
            </button>
            <button
              onClick={() => setIsOpen(!isOpen)}
              className="p-2 rounded-lg text-slate-600 hover:text-slate-900 hover:bg-slate-100"
            >
              {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Drawer */}
      {isOpen && (
        <div className="md:hidden border-t border-slate-200 bg-white px-4 pt-3 pb-6 space-y-2">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              onClick={() => setIsOpen(false)}
              className="block px-3 py-2.5 rounded-lg text-base font-medium text-slate-700 hover:bg-slate-100"
            >
              {link.label}
            </Link>
          ))}
          <div className="pt-4 border-t border-slate-100 flex flex-col gap-2">
            {isAuthenticated ? (
              <Link
                href="/dashboard"
                onClick={() => setIsOpen(false)}
                className="w-full text-center py-2.5 rounded-xl bg-brand-forest text-white font-semibold"
              >
                {isBangla ? "ড্যাশবোর্ড প্রবেশ করুন" : "Go to Dashboard"}
              </Link>
            ) : (
              <>
                <Link
                  href="/login"
                  onClick={() => setIsOpen(false)}
                  className="w-full text-center py-2.5 rounded-xl border border-slate-300 font-semibold text-slate-700"
                >
                  {isBangla ? "লগইন" : "Sign In"}
                </Link>
                <Link
                  href="/register"
                  onClick={() => setIsOpen(false)}
                  className="w-full text-center py-2.5 rounded-xl bg-brand-forest text-white font-semibold"
                >
                  {isBangla ? "অ্যাকাউন্ট খুলুন" : "Join as Investor"}
                </Link>
              </>
            )}
          </div>
        </div>
      )}
    </header>
  );
}
