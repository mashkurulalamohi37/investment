"use client";

import React, { useEffect } from "react";
import { useRouter, usePathname } from "next/navigation";
import { useAuth } from "@/lib/auth/AuthContext";
import { ShieldAlert, Loader2 } from "lucide-react";

interface AuthGuardProps {
  children: React.ReactNode;
  requireAdmin?: boolean;
}

export default function AuthGuard({ children, requireAdmin = false }: AuthGuardProps) {
  const { user, isAuthenticated, isLoading, isBangla } = useAuth();
  const router = useRouter();
  const pathname = usePathname();

  useEffect(() => {
    if (isLoading) return;

    if (!isAuthenticated) {
      router.replace(`/login?redirect=${encodeURIComponent(pathname)}`);
      return;
    }

    if (requireAdmin) {
      const isAdmin = user?.role === "SUPER_ADMIN" || user?.role === "ADMIN";
      if (!isAdmin) {
        router.replace("/dashboard?denied=admin_only");
      }
    }
  }, [isAuthenticated, isLoading, user, requireAdmin, router, pathname]);

  if (isLoading) {
    return (
      <div className="min-h-screen bg-[#0A2540] flex flex-col items-center justify-center p-4">
        <div className="flex flex-col items-center gap-3">
          <Loader2 className="w-8 h-8 text-[#00B4D8] animate-spin" />
          <span className="text-xs font-mono text-cyan-200">
            {isBangla ? "নিরাপত্তা সেশন যাচাই করা হচ্ছে..." : "Verifying secure session..."}
          </span>
        </div>
      </div>
    );
  }

  if (!isAuthenticated) {
    return (
      <div className="min-h-screen bg-slate-900 flex flex-col items-center justify-center p-4">
        <div className="flex flex-col items-center gap-2 text-center max-w-sm">
          <ShieldAlert className="w-10 h-10 text-amber-400" />
          <h2 className="text-white text-base font-bold">
            {isBangla ? "লগইন প্রয়োজন" : "Authentication Required"}
          </h2>
          <p className="text-xs text-slate-400">
            {isBangla
              ? "এই পেজে প্রবেশের জন্য আপনার অ্যাকাউন্টে লগইন করতে হবে।"
              : "Redirecting to secure login gateway..."}
          </p>
        </div>
      </div>
    );
  }

  if (requireAdmin) {
    const isAdmin = user?.role === "SUPER_ADMIN" || user?.role === "ADMIN";
    if (!isAdmin) {
      return (
        <div className="min-h-screen bg-slate-900 flex flex-col items-center justify-center p-4">
          <div className="flex flex-col items-center gap-2 text-center max-w-sm">
            <ShieldAlert className="w-10 h-10 text-red-400" />
            <h2 className="text-white text-base font-bold">
              {isBangla ? "প্রবেশাধিকার সংরক্ষিত" : "Administrative Access Restricted"}
            </h2>
            <p className="text-xs text-slate-400">
              {isBangla
                ? "এই কন্ট্রোল প্যানেলটি শুধুমাত্র স্বপ্নযাত্রী বোর্ডের জন্য সংরক্ষিত।"
                : "Your account does not possess Super Admin privileges. Redirecting to investor portal..."}
            </p>
          </div>
        </div>
      );
    }
  }

  return <>{children}</>;
}
