import type { Metadata } from "next";
import { Hind_Siliguri, Noto_Sans_Bengali, Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";
import Providers from "./providers";

const hindSiliguri = Hind_Siliguri({
  weight: ["300", "400", "500", "600", "700"],
  subsets: ["bengali", "latin"],
  variable: "--font-hind",
  display: "swap",
});

const notoSansBengali = Noto_Sans_Bengali({
  weight: ["400", "500", "600", "700", "800"],
  subsets: ["bengali", "latin"],
  variable: "--font-noto-bengali",
  display: "swap",
});

const plusJakarta = Plus_Jakarta_Sans({
  subsets: ["latin"],
  variable: "--font-jakarta",
  display: "swap",
});

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
    <html lang="bn" className={`${hindSiliguri.variable} ${notoSansBengali.variable} ${plusJakarta.variable}`}>
      <head>
        <link rel="icon" type="image/svg+xml" href="/swapnojatri_logo.svg" />
        <link rel="shortcut icon" href="/swapnojatri_logo.svg" />
        <link rel="apple-touch-icon" href="/swapnojatri_logo.svg" />
      </head>
      <body className="antialiased bg-[#F8FAFC] text-slate-900 min-h-screen flex flex-col font-sans">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}

