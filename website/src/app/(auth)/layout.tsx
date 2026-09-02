import Link from "next/link";
import { ShieldCheck } from "lucide-react";
import SwapnojatriLogo from "@/components/ui/SwapnojatriLogo";

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-canvas-light flex flex-col justify-between p-4 sm:p-6 lg:p-8">
      {/* Brand Header */}
      <div className="max-w-7xl mx-auto w-full flex items-center justify-between">
        <Link href="/" className="hover:opacity-95 transition-opacity">
          <SwapnojatriLogo size="md" />
        </Link>
        <Link href="/" className="text-xs font-semibold text-slate-500 hover:text-brand-forest">
          ← Back to Website
        </Link>
      </div>

      {/* Form Container */}
      <div className="w-full max-w-md mx-auto my-8">{children}</div>

      {/* Security Footer Note */}
      <div className="text-center text-xs text-slate-400 flex items-center justify-center gap-1.5 pb-2">
        <ShieldCheck className="w-4 h-4 text-jade" />
        <span>Secured with 256-Bit SSL Encryption & JWT Authentication</span>
      </div>
    </div>
  );
}
