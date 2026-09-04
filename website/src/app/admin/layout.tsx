import type { Metadata } from "next";
import AdminNav from "@/components/layout/AdminNav";

export const metadata: Metadata = {
  title: "Admin Console — Swapnojatri Platform",
  robots: {
    index: false,
    follow: false,
  },
};

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen md:h-screen bg-[#F8FAFC] flex flex-col md:flex-row overflow-y-auto md:overflow-hidden font-sans">
      <AdminNav />
      <main className="flex-1 min-h-0 overflow-y-auto p-3.5 sm:p-5 lg:p-8 w-full max-w-full">
        <div className="max-w-7xl mx-auto w-full">
          {children}
        </div>
      </main>
    </div>
  );
}
