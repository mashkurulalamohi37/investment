import type { Metadata } from "next";
import "./globals.css";
import Providers from "./providers";

export const metadata: Metadata = {
  title: "Swapnojatri — Transparent Asset-Backed Land & Agro Crowdfunding",
  description:
    "Official investment portal for Swapnojatri. Explore LandVest 100 with verified Sub-Registry title deeds, 100 fixed shares, escrow security, and pro-rata profit distribution.",
  keywords: [
    "Swapnojatri",
    "LandVest 100",
    "Land Investment Bangladesh",
    "Agro Investment",
    "Fintech Bangladesh",
    "Savar Real Estate",
    "Asset-backed Crowdfunding",
  ],
  authors: [{ name: "Swapnojatri Platform" }],
  openGraph: {
    title: "Swapnojatri — Land & Agro Investment Platform",
    description: "Invest securely in prime verified land in Bangladesh with digital lot ownership and transparent fund auditing.",
    url: "https://swapnojatri.com",
    siteName: "Swapnojatri",
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Swapnojatri — Land & Agro Investment Platform",
    description: "Discover LandVest 100. 100 Fixed Shares, Vetted Title Deeds, Transparent Escrow.",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="antialiased font-sans bg-canvas-light text-slate-900 min-h-screen flex flex-col">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
