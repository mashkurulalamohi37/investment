"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import { useCms } from "@/lib/cms/useCms";
import {
  Globe,
  LayoutDashboard,
  LogOut,
  Menu,
  X,
  Sparkles,
  ArrowRight,
  ShieldCheck,
  CheckCircle2,
} from "lucide-react";

export default function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const pathname = usePathname();
  const { user, isAuthenticated, logout, isBangla, toggleLanguage } = useAuth();
  const { global } = useCms();

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 15);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const navLinks = [
    { href: "/", label: isBangla ? "হোম" : "Home" },
    { href: "/projects/landvest-100", label: "LandVest 100", badge: isBangla ? "চলমান" : "LIVE" },
    { href: "/projects", label: isBangla ? "প্রকল্পসমূহ" : "All Projects" },
    { href: "/how-it-works", label: isBangla ? "কার্যপদ্ধতি" : "How It Works" },
    { href: "/about", label: isBangla ? "আমাদের গল্প" : "Our Story" },
    { href: "/faq", label: isBangla ? "প্রশ্নোত্তর" : "FAQ" },
    { href: "/contact", label: isBangla ? "যোগাযোগ" : "Contact" },
  ];

  return (
    <div className="sticky top-0 z-50 w-full">
      {/* Top Announcement Banner (CMS Controlled) */}
      {global.announcement?.enabled && (
        <div className="w-full bg-gradient-to-r from-[#003B46] via-[#0A2540] to-[#003B46] border-b border-cyan-500/30 text-white text-[11px] sm:text-xs py-1.5 px-4 text-center flex items-center justify-center gap-2 shadow-sm">
          <Sparkles className="w-3 h-3 text-amber-400 shrink-0 animate-pulse" />
          <span className="font-medium">
            {isBangla ? global.announcement.textBn : global.announcement.text}
          </span>
          {global.announcement.link && (
            <Link
              href={global.announcement.link}
              className="underline font-bold text-cyan-300 hover:text-white transition-colors ml-1"
            >
              {isBangla ? global.announcement.linkTextBn : global.announcement.linkText} →
            </Link>
          )}
        </div>
      )}

      {/* Main Deep Royal Navy Glassmorphic Header */}
      <header
        className={`w-full transition-all duration-200 border-b ${
          scrolled
            ? "bg-[#040D1A]/95 backdrop-blur-2xl border-slate-800 shadow-xl shadow-black/40"
            : "bg-[#0A2540]/95 backdrop-blur-xl border-slate-800/80 shadow-md shadow-black/20"
        }`}
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16 sm:h-18">
            {/* Brand Logo */}
            <Link href="/" className="flex items-center gap-3 group shrink-0">
              <div className="w-9 h-9 sm:w-10 sm:h-10 shrink-0 relative transition-transform duration-300 group-hover:scale-105">
                <img
                  src={global.logoUrl || "/swapnojatri_logo.svg"}
                  alt={isBangla ? global.brandNameBn : global.brandName}
                  className="w-full h-full object-contain filter drop-shadow"
                />
              </div>
              <div className="flex flex-col">
                <div className="flex items-center gap-1.5">
                  <span className="font-extrabold text-white text-base sm:text-lg leading-tight tracking-tight">
                    {isBangla ? global.brandNameBn : global.brandName}
                  </span>
                  <span className="hidden sm:inline-flex items-center gap-0.5 px-1.5 py-0.2 rounded text-[9px] font-bold bg-emerald-500/20 text-emerald-300 border border-emerald-400/40">
                    <CheckCircle2 className="w-2.5 h-2.5 text-emerald-400" />
                    <span>{isBangla ? global.verifiedBadgeBn : global.verifiedBadge}</span>
                  </span>
                </div>
                <span className="text-[10px] font-bold text-cyan-light tracking-wide">
                  {isBangla ? global.brandSubtitleBn : global.brandSubtitle}
                </span>
              </div>
            </Link>

            {/* Desktop Navigation */}
            <nav className="hidden lg:flex items-center gap-1">
              {navLinks.map((link) => {
                const isActive = pathname === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={`relative px-3.5 py-2 rounded-full text-xs sm:text-[13px] font-bold transition-all duration-200 flex items-center gap-1.5 ${
                      isActive
                        ? "bg-brand-emerald text-white shadow-md shadow-brand-emerald/35 font-extrabold"
                        : "text-slate-300 hover:text-white hover:bg-white/10"
                    }`}
                  >
                    <span>{link.label}</span>
                    {link.badge && (
                      <span
                        className={`px-1.5 py-0.2 rounded-full text-[9px] font-bold uppercase ${
                          isActive
                            ? "bg-white/25 text-white"
                            : "bg-cyan/20 text-cyan-light border border-cyan/40 font-mono"
                        }`}
                      >
                        {link.badge}
                      </span>
                    )}
                  </Link>
                );
              })}
            </nav>

            {/* Right Action Suite */}
            <div className="hidden md:flex items-center gap-3">
              {/* Language Switcher */}
              <button
                onClick={toggleLanguage}
                className="flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-bold text-slate-200 hover:text-white bg-white/10 hover:bg-white/15 border border-white/15 transition-all shadow-2xs cursor-pointer"
                title="Toggle Language"
              >
                <Globe className="w-3.5 h-3.5 text-cyan-light" />
                <span className="font-semibold text-[11px]">{isBangla ? "English" : "বাংলা"}</span>
              </button>

              {isAuthenticated ? (
                <div className="flex items-center gap-2">
                  <Link
                    href="/dashboard"
                    className="flex items-center gap-2 px-4 py-2 rounded-full bg-brand-emerald hover:bg-brand-forest text-white text-xs sm:text-[13px] font-bold shadow-md shadow-brand-emerald/25 transition-all cursor-pointer"
                  >
                    <LayoutDashboard className="w-3.5 h-3.5 text-cyan-light" />
                    <span>{isBangla ? "ড্যাশবোর্ড" : "Dashboard"}</span>
                  </Link>
                  {user?.role === "SUPER_ADMIN" ? (
                    <Link
                      href="/admin"
                      className="px-3 py-2 rounded-full bg-white/15 hover:bg-white/25 text-white border border-white/20 text-xs font-bold transition-all cursor-pointer"
                    >
                      Admin
                    </Link>
                  ) : null}
                  <button
                    onClick={logout}
                    className="p-2 text-slate-400 hover:text-red-400 rounded-full hover:bg-white/10 transition-colors cursor-pointer"
                    title="Sign Out"
                  >
                    <LogOut className="w-4 h-4" />
                  </button>
                </div>
              ) : (
                <div className="flex items-center gap-2.5">
                  <Link
                    href="/login"
                    className="px-3 py-2 text-xs sm:text-[13px] font-bold text-slate-300 hover:text-white transition-colors cursor-pointer"
                  >
                    {isBangla ? "লগইন" : "Sign In"}
                  </Link>
                  <Link
                    href="/login"
                    className="px-5 py-2.5 rounded-full bg-brand-emerald hover:bg-brand-forest text-white text-xs sm:text-[13px] font-extrabold shadow-md shadow-brand-emerald/30 hover:shadow-brand-emerald/50 transition-all flex items-center gap-1.5 group cursor-pointer hover:scale-[1.02]"
                  >
                    <span>{isBangla ? "বিনিয়োগ শুরু করুন" : "Join as Investor"}</span>
                    <ArrowRight className="w-3.5 h-3.5 text-cyan-light transition-transform group-hover:translate-x-0.5" />
                  </Link>
                </div>
              )}
            </div>

            {/* Mobile Menu Button */}
            <div className="flex lg:hidden items-center gap-2">
              <button
                onClick={toggleLanguage}
                className="p-2 rounded-full bg-white/10 text-white text-xs font-bold cursor-pointer"
              >
                <Globe className="w-4 h-4 text-cyan-light" />
              </button>
              <button
                onClick={() => setIsOpen(!isOpen)}
                className="p-2 rounded-xl text-slate-200 hover:text-white hover:bg-white/10 cursor-pointer"
              >
                {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
              </button>
            </div>
          </div>
        </div>

        {/* Mobile Drawer */}
        {isOpen && (
          <div className="lg:hidden p-5 bg-[#0A2540] border-b border-slate-800 shadow-2xl space-y-4 animate-in fade-in slide-in-from-top-2 duration-200">
            <nav className="flex flex-col space-y-1">
              {navLinks.map((link) => {
                const isActive = pathname === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    onClick={() => setIsOpen(false)}
                    className={`px-4 py-2.5 rounded-xl text-sm font-bold flex items-center justify-between transition-colors ${
                      isActive ? "bg-brand-emerald text-white" : "text-slate-200 hover:bg-white/10 hover:text-white"
                    }`}
                  >
                    <span>{link.label}</span>
                    {link.badge && (
                      <span className="px-2 py-0.5 rounded-full text-[10px] bg-cyan/20 text-cyan-light border border-cyan/40 font-bold">
                        {link.badge}
                      </span>
                    )}
                  </Link>
                );
              })}
            </nav>

            <div className="pt-3 border-t border-white/10 space-y-2">
              {isAuthenticated ? (
                <>
                  <Link
                    href="/dashboard"
                    onClick={() => setIsOpen(false)}
                    className="w-full py-3 rounded-xl bg-brand-emerald text-white text-sm font-bold flex items-center justify-center gap-2 shadow-md shadow-brand-emerald/25"
                  >
                    <LayoutDashboard className="w-4 h-4" />
                    <span>{isBangla ? "বিনিয়োগকারী ড্যাশবোর্ড" : "Investor Dashboard"}</span>
                  </Link>
                  <button
                    onClick={() => {
                      logout();
                      setIsOpen(false);
                    }}
                    className="w-full py-2.5 rounded-xl text-xs font-bold text-red-300 bg-red-500/15 border border-red-500/30 flex items-center justify-center gap-2"
                  >
                    <LogOut className="w-4 h-4" />
                    <span>{isBangla ? "লগআউট" : "Sign Out"}</span>
                  </button>
                </>
              ) : (
                <div className="flex flex-col gap-2">
                  <Link
                    href="/login"
                    onClick={() => setIsOpen(false)}
                    className="w-full py-3 rounded-full bg-brand-emerald text-white text-sm font-extrabold text-center shadow-md shadow-brand-emerald/25"
                  >
                    {isBangla ? "বিনিয়োগ শুরু করুন / লগইন" : "Join as Investor / Sign In"}
                  </Link>
                </div>
              )}
            </div>
          </div>
        )}
      </header>
    </div>
  );
}
