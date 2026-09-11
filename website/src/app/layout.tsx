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
  icons: {
    icon: "/swapnojatri_logo.svg",
    shortcut: "/swapnojatri_logo.svg",
    apple: "/swapnojatri_logo.svg",
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
    <html lang="bn">
      <head>
        <link rel="icon" type="image/svg+xml" href="/swapnojatri_logo.svg" />
        <link rel="shortcut icon" href="/swapnojatri_logo.svg" />
        <link rel="apple-touch-icon" href="/swapnojatri_logo.svg" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link
          href="https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@300;400;500;600;700&family=Noto+Sans+Bengali:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet"
        />
      </head>
      <body className="antialiased bg-[#F8FAFC] text-slate-900 min-h-screen flex flex-col font-sans">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
