import type { Metadata } from "next";
import DashboardNav from "@/components/layout/DashboardNav";

export const metadata: Metadata = {
  title: "Investor Dashboard — Swapnojatri Platform",
  robots: {
    index: false,
    follow: false,
  },
};

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-canvas-light flex flex-col md:flex-row">
      <DashboardNav />
      <main className="flex-1 p-4 sm:p-6 lg:p-8 max-w-7xl mx-auto w-full">
        {children}
      </main>
    </div>
  );
}
