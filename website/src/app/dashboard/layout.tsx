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
    <div className="min-h-screen md:h-screen bg-[#F8FAFC] flex flex-col md:flex-row overflow-y-auto md:overflow-hidden font-sans">
      <DashboardNav />
      <main className="flex-1 min-h-0 overflow-y-auto p-3.5 sm:p-5 lg:p-8 w-full max-w-full">
        <div className="max-w-7xl mx-auto w-full">
          {children}
        </div>
      </main>
    </div>
  );
}

