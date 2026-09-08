// Master Universal CMS Type Definitions & Default Configurations

export interface AboutImageItem {
  id: string;
  title: string;
  titleBn: string;
  category: string;
  categoryBn: string;
  imageUrl: string;
  caption: string;
  captionBn: string;
}

export interface AboutHeroMedia {
  imageUrl: string;
  badge: string;
  badgeBn: string;
  caption: string;
  captionBn: string;
}

export interface AboutPageCmsConfig {
  heroImage: AboutHeroMedia;
  storyParagraphs: {
    p1: string;
    p1Bn: string;
    p2: string;
    p2Bn: string;
    p3: string;
    p3Bn: string;
    quote: string;
    quoteBn: string;
  };
  storyImages: AboutImageItem[];
  values: Array<{
    id: string;
    icon: string;
    title: string;
    titleBn: string;
    desc: string;
    descBn: string;
  }>;
  updatedAt?: string;
}

// 1. Global Branding & Navigation
export interface GlobalCmsConfig {
  brandName: string;
  brandNameBn: string;
  brandSubtitle: string;
  brandSubtitleBn: string;
  logoUrl: string;
  verifiedBadge: string;
  verifiedBadgeBn: string;
  announcement: {
    enabled: boolean;
    text: string;
    textBn: string;
    link: string;
    linkText: string;
    linkTextBn: string;
    theme: "navy" | "emerald" | "amber";
  };
  contact: {
    hotline: string;
    whatsapp: string;
    email: string;
    address: string;
    addressBn: string;
    hours: string;
    hoursBn: string;
  };
  legal: {
    tradeLicense: string;
    tin: string;
    subRegistryJurisdiction: string;
    subRegistryJurisdictionBn: string;
    copyright: string;
    copyrightBn: string;
    disclaimer: string;
    disclaimerBn: string;
  };
  socials: {
    facebook: string;
    youtube: string;
    linkedin: string;
    twitter: string;
  };
}

// 2. Homepage & Live Projects
export interface HomeLiveProjectCard {
  id: string;
  projectCode: string;
  showOnHome: boolean;
  order: number;
  statusBadge: string;
  statusBadgeBn: string;
  imageUrl: string;
  name: string;
  nameBn: string;
  category: string;
  categoryBn: string;
  location: string;
  locationBn: string;
  pricePerShare: number;
  projectedRoiMin: number;
  projectedRoiMax: number;
  totalShares: number;
  allocatedShares: number;
  isUpcoming: boolean;
  ctaText: string;
  ctaTextBn: string;
  ctaUrl: string;
  escrowBadge: string;
  escrowBadgeBn: string;
}

export interface HomeCmsConfig {
  hero: {
    tagline: string;
    taglineBn: string;
    headline: string;
    headlineBn: string;
    subheadline: string;
    subheadlineBn: string;
    quote: string;
    quoteBn: string;
    bgImageUrl: string;
    primaryCtaText: string;
    primaryCtaTextBn: string;
    primaryCtaUrl: string;
    secondaryCtaText: string;
    secondaryCtaTextBn: string;
    secondaryCtaUrl: string;
  };
  metrics: Array<{
    id: string;
    label: string;
    labelBn: string;
    value: string;
    valueBn: string;
    color: string;
  }>;
  trustPillars: Array<{
    id: string;
    icon: string;
    title: string;
    titleBn: string;
    desc: string;
    descBn: string;
    badge: string;
    badgeBn: string;
  }>;
  storySection: {
    title: string;
    titleBn: string;
    quote: string;
    quoteBn: string;
    desc: string;
    descBn: string;
    imageUrl: string;
    ctaText: string;
    ctaTextBn: string;
    ctaUrl: string;
  };
  liveProjectsSection: {
    enabled: boolean;
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
    badge: string;
    badgeBn: string;
    projects: HomeLiveProjectCard[];
  };
  conversionBanner: {
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
    ctaText: string;
    ctaTextBn: string;
    ctaUrl: string;
  };
}

// 3. How It Works
export interface HowItWorksStep {
  num: string;
  numBn: string;
  title: string;
  titleBn: string;
  desc: string;
  descBn: string;
  icon: string;
}

export interface HowItWorksPhase {
  id: string;
  phaseNum: string;
  phaseTitle: string;
  phaseTitleBn: string;
  steps: HowItWorksStep[];
}

export interface HowItWorksCmsConfig {
  header: {
    badge: string;
    badgeBn: string;
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
  };
  phases: HowItWorksPhase[];
  escrowInfo: {
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
    points: Array<{ text: string; textBn: string }>;
  };
  cta: {
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
    buttonText: string;
    buttonTextBn: string;
    buttonUrl: string;
  };
}

// 4. FAQ
export interface FaqItem {
  id: string;
  category: string;
  q: string;
  qBn: string;
  a: string;
  aBn: string;
  order: number;
  active: boolean;
}

export interface FaqCmsConfig {
  header: {
    badge: string;
    badgeBn: string;
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
  };
  categories: Array<{ key: string; label: string; labelBn: string }>;
  items: FaqItem[];
}

// 5. Documents
export interface DocumentItem {
  id: string;
  title: string;
  titleBn: string;
  category: string;
  categoryBn: string;
  type: string;
  size: string;
  date: string;
  hash: string;
  fileUrl: string;
  visibility: "PUBLIC" | "INVESTOR_ONLY";
}

export interface DocumentsCmsConfig {
  header: {
    badge: string;
    badgeBn: string;
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
  };
  categories: Array<{ key: string; label: string; labelBn: string }>;
  documents: DocumentItem[];
}

// 6. Contact & Banking
export interface ContactCmsConfig {
  header: {
    badge: string;
    badgeBn: string;
    title: string;
    titleBn: string;
    subtitle: string;
    subtitleBn: string;
  };
  bankPassbook: {
    bankName: string;
    bankNameBn: string;
    badge: string;
    accountTitle: string;
    accountNumber: string;
    routingNumber: string;
    branchName: string;
    branchNameBn: string;
    swiftCode: string;
    notice: string;
    noticeBn: string;
  };
  headOffice: {
    title: string;
    titleBn: string;
    address: string;
    addressBn: string;
    phone: string;
    email: string;
    hours: string;
    hoursBn: string;
    mapUrl: string;
  };
  siteOffice: {
    title: string;
    titleBn: string;
    address: string;
    addressBn: string;
    phone: string;
    visitingSchedule: string;
    visitingScheduleBn: string;
    mapUrl: string;
  };
  channels: {
    whatsappNumber: string;
    whatsappMessage: string;
    advisorHotline: string;
    supportEmail: string;
  };
}

// Master Container for Entire Site CMS
export interface MasterCmsState {
  global: GlobalCmsConfig;
  home: HomeCmsConfig;
  about: AboutPageCmsConfig;
  howItWorks: HowItWorksCmsConfig;
  faq: FaqCmsConfig;
  documents: DocumentsCmsConfig;
  contact: ContactCmsConfig;
  updatedAt: string;
}

// Platform High-Resolution Media Presets
export const PLATFORM_ASSET_PRESETS = [
  {
    name: "Aerial Prime Land & Agro (Bosila / Washpur)",
    nameBn: "আকাশ থেকে প্রাইম জমি ও এগ্রো ভিউ",
    url: "/images/hero_investment_bg.jpg",
    category: "AERIAL",
  },
  {
    name: "LandVest 100 Project Site Overview",
    nameBn: "ল্যান্ডভেস্ট ১০০ প্রজেক্ট সাইট ওভারভিউ",
    url: "/images/landvest_hero.jpg",
    category: "SITE",
  },
  {
    name: "Organic Agro Farming & Seedling Growth",
    nameBn: "জৈব এগ্রো ফার্মিং ও উন্নত চারা উৎপাদন",
    url: "/images/seedling_growth.jpg",
    category: "AGRO",
  },
  {
    name: "Strategic Land Demarcation & Boundary",
    nameBn: "জমি চিহ্নিতকরণ ও বাউন্ডারি প্রাচীর",
    url: "/images/gallery_land.jpg",
    category: "LAND",
  },
  {
    name: "Access Highway & Connecting Road",
    nameBn: "সংযোগ সড়ক ও প্রধান হাইওয়ে অ্যাক্সেস",
    url: "/images/gallery_road.jpg",
    category: "INFRASTRUCTURE",
  },
  {
    name: "Sustainable Planned Community Vision",
    nameBn: "পরিকল্পিত টেকসই কমিউনিটি রূপরেখা",
    url: "/images/gallery_future.jpg",
    category: "VISION",
  },
];

// Seed Defaults
export const DEFAULT_GLOBAL_CMS: GlobalCmsConfig = {
  brandName: "Swapnojatri",
  brandNameBn: "স্বপ্নযাত্রী",
  brandSubtitle: "Investment Platform",
  brandSubtitleBn: "ইনভেস্টমেন্ট প্ল্যাটফর্ম",
  logoUrl: "/swapnojatri_logo.svg",
  verifiedBadge: "Verified",
  verifiedBadgeBn: "যাচাইকৃত",
  announcement: {
    enabled: false,
    text: "LandVest 100: 74% subscribed! Only 26 shares remaining before allotment closes.",
    textBn: "ল্যান্ডভেস্ট ১০০: ৭৪% শেয়ার বিক্রি সম্পন্ন! চূড়ান্ত বরাদ্দের পূর্বে মাত্র ২৬টি শেয়ার অবশিষ্ট।",
    link: "/projects/landvest-100",
    linkText: "Invest Now",
    linkTextBn: "এখনই বিনিয়োগ করুন",
    theme: "navy",
  },
  contact: {
    hotline: "+880 1700-000000",
    whatsapp: "+880 1700-000000",
    email: "invest@swapnojatri.com",
    address: "Level 7, Concord Tower, Gulshan-2, Dhaka 1212, Bangladesh",
    addressBn: "লেভেল ৭, কনকর্ড টাওয়ার, গুলশান-২, ঢাকা ১২১২, বাংলাদেশ",
    hours: "Saturday – Thursday: 9:30 AM – 6:30 PM",
    hoursBn: "শনিবার – বৃহস্পতিবার: সকাল ৯:৩০ – সন্ধ্যা ৬:৩০",
  },
  legal: {
    tradeLicense: "TRAD/DNCC/049182/2026",
    tin: "718294019283",
    subRegistryJurisdiction: "Savar Sub-Registry Office, Dhaka",
    subRegistryJurisdictionBn: "সাভার সাব-রেজিস্ট্রি অফিস, ঢাকা",
    copyright: "© 2026 Swapnojatri Investment Platform Ltd. All rights reserved.",
    copyrightBn: "© ২০২৬ স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম লিমিটেড। সর্বস্বত্ব সংরক্ষিত।",
    disclaimer: "Mutual multi-project co-ownership governed under Registered Trust Deeds and The City Bank PLC Escrow.",
    disclaimerBn: "নিবন্ধিত ট্রাস্ট দলিল ও দ্য সিটি ব্যাংক পিএলসি এসক্রো নীতিমালার অধীনে পরিচালিত অংশীদারিত্ব প্ল্যাটফর্ম।",
  },
  socials: {
    facebook: "https://facebook.com",
    youtube: "https://youtube.com",
    linkedin: "https://linkedin.com",
    twitter: "https://twitter.com",
  },
};

export const DEFAULT_HOME_CMS: HomeCmsConfig = {
  hero: {
    tagline: "আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা",
    taglineBn: "আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা",
    headline: "Transform Small Capital into Lasting Real Estate Wealth",
    headlineBn: "ছোট বিনিয়োগে গড়ে তুলুন আপনার স্থায়ী সম্পদের ভবিষ্যৎ",
    subheadline: "Participate in legally vetted prime land, high-yield smart agro, and commercial developments with 100% bank escrow security.",
    subheadlineBn: "ঢাকার সন্নিকটে বাছাইকৃত জমি ও আধুনিক এগ্রো ফার্মিং প্রকল্পে নিরাপদ অংশীদারিত্ব। প্রতিটি শেয়ারের ১০০% ব্যাংক এসক্রো নিরাপত্তা ও ডিজিটাল মালিকানা সনদ।",
    quote: "ছোট বিনিয়োগ, বড় ভবিষ্যৎ...",
    quoteBn: "ছোট বিনিয়োগ, বড় ভবিষ্যৎ...",
    bgImageUrl: "/images/hero_investment_bg.jpg",
    primaryCtaText: "Invest Now →",
    primaryCtaTextBn: "শেয়ার বুক করুন →",
    primaryCtaUrl: "/projects/landvest-100",
    secondaryCtaText: "How It Works",
    secondaryCtaTextBn: "কার্যপদ্ধতি দেখুন",
    secondaryCtaUrl: "/how-it-works",
  },
  metrics: [
    { id: "m1", label: "Track Record", labelBn: "বাস্তবায়িত প্রকল্প", value: "4 Projects", valueBn: "৪টি প্রকল্প", color: "text-[#0066FF]" },
    { id: "m2", label: "Fixed Unit Equity", labelBn: "নির্দিষ্ট অংশীদারিত্ব", value: "100 Units", valueBn: "১০০টি ইউনিট", color: "text-slate-900" },
    { id: "m3", label: "Bank Escrow Safe", labelBn: "ব্যাংক এসক্রো গ্যারান্টি", value: "100% Pro-Rata", valueBn: "১০০% প্রো-রাটা", color: "text-emerald-600" },
  ],
  trustPillars: [
    {
      id: "p1",
      icon: "ShieldCheck",
      title: "Bank Escrow Custody",
      titleBn: "সিটি ব্যাংক এসক্রো নিরাপত্তা",
      desc: "All subscription capital held in segregated City Bank escrow account and disbursed milestone-by-milestone.",
      descBn: "সকল বিনিয়োগ তহবিল সরাসরি দ্য সিটি ব্যাংক পিএলসি এসক্রো অ্যাকাউন্টে সুরক্ষিত থাকে।",
      badge: "Institutional Safety",
      badgeBn: "ব্যাংক এসক্রো কাস্টডি",
    },
    {
      id: "p2",
      icon: "Users",
      title: "Democratic Micro-Equity",
      titleBn: "ক্ষুদ্র পুঁজিতে অংশীদারিত্ব",
      desc: "Equal access for everyday citizens to prime capital growth starting with fixed fractional units.",
      descBn: "সাধারণ মানুষের জন্য অল্প পুঁজিতে লাভজনক জমির মালিকানা ও নিয়মিত ক্যাশফ্লো লাভের সুযোগ।",
      badge: "Fixed Allocation",
      badgeBn: "নির্দিষ্ট ইউনিট",
    },
    {
      id: "p3",
      icon: "TrendingUp",
      title: "Dual Asset Appreciation",
      titleBn: "দ্বিমুখী মুনাফার নিশ্চয়তা",
      desc: "Quarterly seasonal cash flow from high-yield greenhouse crops combined with rapid land appreciation.",
      descBn: "জমি ক্রয়ের দীর্ঘমেয়াদী মূল্যবৃদ্ধির পাশাপাশি নিয়মিত কৃষি ফলন থেকে নিশ্চিত লভ্যাংশ বণ্টন।",
      badge: "Targeted 18.5%+",
      badgeBn: "১৮.৫% - ২২% রিটার্ন",
    },
    {
      id: "p4",
      icon: "FileCheck",
      title: "Sub-Registry & Title Deed",
      titleBn: "আইনি রেজিস্ট্রেশন ও মালিকানা",
      desc: "Physical land demarcated, registered, and held under legally audited collective trust framework.",
      descBn: "প্রতিটি জমি সাব-রেজিস্ট্রি অফিসে বৈধ দলিলে নিবন্ধিত এবং ডিজিটাল ভল্টে সংরক্ষিত।",
      badge: "Govt. Sub-Registry",
      badgeBn: "সরকারি রেজিস্ট্রি",
    },
  ],
  storySection: {
    title: "The LandVest 100 Story: Built on Integrity",
    titleBn: "ল্যান্ডভেস্ট ১০০: বাস্তব প্রকল্প ও সত্যের ওপর প্রতিষ্ঠিত",
    quote: "“Trust is not a marketing promise; it is an audited bank trail and a verified land deed.”",
    quoteBn: "“বিশ্বাস কোনো কথার কথা নয়; বিশ্বাস হলো ব্যাংক ট্রেইল ও সরেজমিনে দেখা জমির দলিল।”",
    desc: "Located strategically across Bosila Bridge at Washpur Tower Road, LandVest 100 is engineered to eliminate real estate scams. Every decimal is surveyed, boundary-walled, and legally held for exactly 100 co-owners.",
    descBn: "বসিলা ব্রিজের ঠিক বিপরীতে ওয়াশপুর টাওয়ার রোডে অবস্থিত ল্যান্ডভেস্ট ১০০ প্রকল্পটি সাধারণ বিনিয়োগকারীদের দীর্ঘদিনের স্বপ্ন বাস্তবায়নের জন্য তৈরি। শতভাগ ভেজালমুক্ত জমি ও আধুনিক এগ্রো প্রযুক্তির মেলবন্ধন।",
    imageUrl: "/images/landvest_hero.jpg",
    ctaText: "Explore LandVest 100 Details →",
    ctaTextBn: "প্রকল্পের বিস্তারিত দেখুন →",
    ctaUrl: "/projects/landvest-100",
  },
  liveProjectsSection: {
    enabled: true,
    title: "Ongoing & Upcoming Investment Projects",
    titleBn: "চলমান ও আসন্ন প্রকল্পসমূহ",
    subtitle: "Select a high-yield fractional venture vetted by physical survey and City Bank escrow safeguards.",
    subtitleBn: "বাছাইকৃত জমি, এগ্রো ফার্ম ও বাণিজ্যিক উদ্যোগে আপনার পছন্দের শেয়ার বেছে নিন।",
    badge: "ACTIVE PORTFOLIO",
    badgeBn: "চলমান প্রকল্প সম্ভার",
    projects: [
      {
        id: "proj-1",
        projectCode: "LV100",
        showOnHome: true,
        order: 1,
        statusBadge: "LIVE PROJECT",
        statusBadgeBn: "চলমান প্রকল্প",
        imageUrl: "/images/landvest_hero.jpg",
        name: "LandVest 100 (Washpur, Dhaka)",
        nameBn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
        category: "PRIME LAND SHARE",
        categoryBn: "প্রাইম জমি অংশীদারিত্ব",
        location: "Washpur, Bosila Bridge, Dhaka",
        locationBn: "ওয়াশপুর, বসিলা ব্রিজ সংলগ্ন, ঢাকা",
        pricePerShare: 25500,
        projectedRoiMin: 18.5,
        projectedRoiMax: 22.0,
        totalShares: 100,
        allocatedShares: 74,
        isUpcoming: false,
        ctaText: "View Details →",
        ctaTextBn: "বিস্তারিত দেখুন →",
        ctaUrl: "/projects/landvest-100",
        escrowBadge: "City Bank Escrow",
        escrowBadgeBn: "সিটি ব্যাংক এসক্রো",
      },
      {
        id: "proj-2",
        projectCode: "AGRO-S1",
        showOnHome: true,
        order: 2,
        statusBadge: "UPCOMING / PRE-BOOKING",
        statusBadgeBn: "আসন্ন প্রকল্প",
        imageUrl: "/images/seedling_growth.jpg",
        name: "Smart Agro & High-Yield Farm",
        nameBn: "স্মার্ট এগ্রো ও উন্নত ফলন প্রকল্প",
        category: "AGRICULTURAL CASHFLOW",
        categoryBn: "কৃষি ও মৌসুমী মুনাফা",
        location: "Singair, Manikganj (Dhaka Belt)",
        locationBn: "সিংগাইর, মানিকগঞ্জ (ঢাকা সংলগ্ন)",
        pricePerShare: 15000,
        projectedRoiMin: 16.0,
        projectedRoiMax: 19.5,
        totalShares: 100,
        allocatedShares: 12,
        isUpcoming: true,
        ctaText: "Pre-Booking →",
        ctaTextBn: "প্রি-বুকিং দেখুন →",
        ctaUrl: "/projects/agro-s1",
        escrowBadge: "Quarterly Returns",
        escrowBadgeBn: "ত্রৈমাসিক লভ্যাংশ",
      },
      {
        id: "proj-3",
        projectCode: "DAIRY-01",
        showOnHome: true,
        order: 3,
        statusBadge: "UPCOMING",
        statusBadgeBn: "আসন্ন প্রকল্প",
        imageUrl: "/images/gallery_land.jpg",
        name: "Modern Dairy & Feed Processing",
        nameBn: "আধুনিক ডেইরি ও ফিড প্রসেসিং",
        category: "AGRO-COMMERCIAL",
        categoryBn: "বাণিজ্যিক ডেইরি",
        location: "Savar Dairy Zone, Dhaka",
        locationBn: "সাভার ডেইরি জোন, ঢাকা",
        pricePerShare: 20000,
        projectedRoiMin: 17.0,
        projectedRoiMax: 21.0,
        totalShares: 100,
        allocatedShares: 8,
        isUpcoming: true,
        ctaText: "Preview Details →",
        ctaTextBn: "অগ্রিম দেখুন →",
        ctaUrl: "/projects/dairy-01",
        escrowBadge: "City Bank Escrow",
        escrowBadgeBn: "সিটি ব্যাংক এসক্রো",
      },
    ],
  },
  conversionBanner: {
    title: "Secure Your Pro-Rata Shares in LandVest 100",
    titleBn: "আজই ল্যান্ডভেস্ট ১০০-এ আপনার শেয়ার নিশ্চিত করুন",
    subtitle: "Starting at ৳25,500 per share. Instant payment via EPS Gateway or direct City Bank Escrow deposit.",
    subtitleBn: "প্রতি শেয়ার মাত্র ৳২৫,৫০০। EPS গেটওয়ে (বিকাশ/কার্ড) বা সিটি ব্যাংক এসক্রো অ্যাকাউন্টে সরাসরি জমা দিয়ে আজই বিনিয়োগ সম্পন্ন করুন।",
    ctaText: "Invest Now →",
    ctaTextBn: "অনলাইনে শেয়ার বুক করুন →",
    ctaUrl: "/projects/landvest-100",
  },
};

export const DEFAULT_ABOUT_CMS: AboutPageCmsConfig = {
  heroImage: {
    imageUrl: "/images/hero_investment_bg.jpg",
    badge: "VERIFIED GROUND ASSET",
    badgeBn: "যাচাইকৃত বাস্তব প্রকল্প",
    caption: "Strategic prime land parcel & smart agro cluster across Bosila Bridge, Dhaka.",
    captionBn: "বসিলা ব্রিজ পার হয়ে ওয়াশপুর টাওয়ার রোড ও সিংগাইর এগ্রো বেল্টে বাস্তব ভূমি প্রকল্প।",
  },
  storyParagraphs: {
    p1: "Swapnojatri was founded on a simple yet uncompromised premise: high-yield, authentic real estate and smart commercial agriculture must not remain exclusive to high-net-worth conglomerates.",
    p1Bn: "স্বপ্নযাত্রীর যাত্রা শুরু একটি আপসহীন উদ্দেশ্য নিয়ে: লাভজনক রিয়েল এস্টেট ও বাণিজ্যিক কৃষির সুফল যেন কেবল গুটিকয়েক বড় ব্যবসায়ীর মধ্যেই সীমাবদ্ধ না থাকে, বরং দেশের প্রতিটি মেহনতি ও সচেতন নাগরিক যেন এর অংশীদার হতে পারেন।",
    p2: "By dividing prime verified properties into exactly 100 fractional units with mandatory City Bank escrow supervision, we eliminated middleman exploitation and speculative fraud.",
    p2Bn: "জমির প্রতিটি খণ্ডকে কঠোরভাবে ১০০টি নির্দিষ্ট ইউনিটে রূপান্তর এবং দ্য সিটি ব্যাংক পিএলসি-এর প্রত্যক্ষ এসক্রো তত্ত্বাবধানে প্রতিটি পয়সার হিসাব নিশ্চিত করে আমরা জমি ক্রয়ের চিরাচরিত অনিশ্চয়তা দূর করেছি।",
    p3: "Today, our co-owners enjoy inflation-hedged land equity appreciation alongside recurring agricultural dividends, certified by digital cryptographic ownership vouchers.",
    p3Bn: "আজ আমাদের অংশীদারগণ জমির মূল্যের দীর্ঘমেয়াদী সুরক্ষা পাওয়ার পাশাপাশি নিয়মিত কৃষি লভ্যাংশ উপভোগ করছেন, যা ডিজিটাল ক্রিপ্টোগ্রাফিক দলিলের মাধ্যমে শতভাগ আইনি সুরক্ষাপ্রাপ্ত।",
    quote: "“Small investments, transparent governance, transformative legacy.”",
    quoteBn: "“ছোট পুঁজিতে অংশীদারিত্ব, শতভাগ স্বচ্ছতা এবং নিরাপদ ভবিষ্যৎ।”",
  },
  storyImages: [
    {
      id: "story-1",
      title: "Prime Land Demarcation & Boundary Setup",
      titleBn: "প্রাইম জমি নির্বাচন ও সীমানা নির্ধারণ",
      category: "REAL ESTATE",
      categoryBn: "জমি ও আবাসন",
      imageUrl: "/images/gallery_land.jpg",
      caption: "On-site GPS survey and solid boundary wall construction at Washpur Tower Road.",
      captionBn: "ওয়াশপুর টাওয়ার রোডে সরাসরি সাইট পরিদর্শন ও সীমানা প্রাচীর নির্মাণ কাজ।",
    },
    {
      id: "story-2",
      title: "Smart Commercial Agro & Seedling Cultivation",
      titleBn: "বাণিজ্যিক এগ্রো ও উন্নত চারা রোপণ",
      category: "SMART AGRO",
      categoryBn: "স্মার্ট এগ্রো",
      imageUrl: "/images/seedling_growth.jpg",
      caption: "High-yield greenhouse organic agriculture yielding quarterly pro-rata cashflow.",
      captionBn: "উচ্চ ফলনশীল গ্রিনহাউস চাষাবাদ, যা প্রতি ৩ মাস পর পর নিশ্চিত মুনাফা এনে দেয়।",
    },
    {
      id: "story-3",
      title: "Wide Approach Road & Strategic Infrastructure",
      titleBn: "প্রশস্ত প্রবেশপথ ও সংযোগ সড়ক উন্নয়ন",
      category: "INFRASTRUCTURE",
      categoryBn: "অবকাঠামো",
      imageUrl: "/images/gallery_road.jpg",
      caption: "Direct connectivity to main Bosila highway ensuring rapid capital appreciation.",
      captionBn: "মূল মহাসড়কের সাথে সরাসরি সংযোগ, যা জমির দ্রুত মূল্যবৃদ্ধির প্রধান নিয়ামক।",
    },
    {
      id: "story-4",
      title: "Sustainable Long-Term Community Masterplan",
      titleBn: "টেকসই পরিবেশবান্ধব ভবিষ্যৎ রূপরেখা",
      category: "COMMUNITY",
      categoryBn: "ভবিষ্যৎ রূপরেখা",
      imageUrl: "/images/gallery_future.jpg",
      caption: "Fiduciary co-ownership planned to protect investor wealth against inflation.",
      captionBn: "মুদ্রাস্ফীতির বিপরীতে বিনিয়োগকারীর আসল পুঁজি সুরক্ষিত রাখার দীর্ঘমেয়াদী পরিকল্পনা।",
    },
  ],
  values: [
    {
      id: "val-1",
      icon: "ShieldCheck",
      title: "Uncompromising Fiduciary Duty",
      titleBn: "আমানতদারিতা ও সর্বোচ্চ দায়বদ্ধতা",
      desc: "Every single taka received is custodially held until official sub-registry execution.",
      descBn: "বিনিয়োগকারীর প্রতিটি পয়সা আমানত হিসেবে ব্যাংক এসক্রো অ্যাকাউন্টে সংরক্ষিত থাকে।",
    },
    {
      id: "val-2",
      icon: "CheckCircle2",
      title: "Radical Transparency",
      titleBn: "স্বচ্ছ হিসাব ও উন্মুক্ত অডিট",
      desc: "All project expenditures, vendor receipts, and bank deposit slips are verifiable.",
      descBn: "প্রকল্পের প্রতিটি পাই-পয়সার খরচের রসিদ ও ভাউচার শেয়ারহোল্ডারদের জন্য উন্মুক্ত।",
    },
    {
      id: "val-3",
      icon: "Users",
      title: "Inclusive Access",
      titleBn: "সহজ ও সমঅধিকারভিত্তিক সুযোগ",
      desc: "Strict cap of maximum 4 units per investor to prevent billionaire monopoly.",
      descBn: "একক বিনিয়োগকারী সর্বোচ্চ ৪টি শেয়ার নিতে পারেন, যাতে সবার সমান অংশীদারিত্ব বজায় থাকে।",
    },
    {
      id: "val-4",
      icon: "TrendingUp",
      title: "Tangible Asset Grounding",
      titleBn: "বাস্তব সম্পদভিত্তিক বিনিয়োগ",
      desc: "No speculative paper derivatives; every share is backed by registered soil.",
      descBn: "কোনো কাল্পনিক স্কিম নয়; প্রতিটি শেয়ারের পেছনে রয়েছে সরাসরি জমি ও বাণিজ্যিক সম্পদ।",
    },
  ],
  updatedAt: new Date().toISOString(),
};

export const DEFAULT_HOW_IT_WORKS_CMS: HowItWorksCmsConfig = {
  header: {
    badge: "TRANSPARENT WORKFLOW",
    badgeBn: "সহজ ও স্বচ্ছ ধাপসমূহ",
    title: "How Swapnojatri Crowdfunding Works",
    titleBn: "স্বপ্নযাত্রী ইনভেস্টমেন্ট কীভাবে কাজ করে?",
    subtitle: "From verified mobile onboarding to automated bank profit distribution in 6 crystal clear steps.",
    subtitleBn: "রেজিস্ট্রেশন থেকে শুরু করে ব্যাংক এসক্রোতে টাকা জমা ও নিয়মিত লভ্যাংশ পাওয়ার সম্পূর্ণ প্রক্রিয়া।",
  },
  phases: [
    {
      id: "ph-1",
      phaseNum: "01",
      phaseTitle: "Investor Onboarding & KYC",
      phaseTitleBn: "পরিচিতি ও নিরাপদ নিবন্ধন",
      steps: [
        {
          num: "1",
          numBn: "১",
          title: "Mobile OTP Verification",
          titleBn: "মোবাইল OTP ভেরিফিকেশন",
          desc: "Quick instant SMS OTP verification secures your account identity.",
          descBn: "বাংলাদেশি মোবাইল নম্বরে তাৎক্ষণিক SMS কোডের মাধ্যমে এনক্রিপ্টেড অ্যাকাউন্ট সক্রিয় করুন।",
          icon: "Users",
        },
        {
          num: "2",
          numBn: "২",
          title: "Smart NID & Nominee KYC",
          titleBn: "স্মার্ট এনআইডি ও নমিনি কেওয়াইসি",
          desc: "Submit legal Smart NID details and designate nominee for fiduciary safety.",
          descBn: "আইনি নিরাপত্তা ও উত্তরাধিকার সংরক্ষণে আপনার জাতীয় পরিচয়পত্র ও নমিনির তথ্য জমা দিন।",
          icon: "ShieldCheck",
        },
      ],
    },
    {
      id: "ph-2",
      phaseNum: "02",
      phaseTitle: "Share Booking & Escrow",
      phaseTitleBn: "শেয়ার নির্বাচন ও এসক্রো পেমেন্ট",
      steps: [
        {
          num: "3",
          numBn: "৩",
          title: "Share Selection (1 to 4 Units)",
          titleBn: "শেয়ার সংখ্যা নির্বাচন (১-৪টি)",
          desc: "Select 1 to 4 fixed share units with transparent pro-rata equity calculation.",
          descBn: "ল্যান্ডভেস্ট ১০০ প্রকল্পে ১ থেকে ৪টি শেয়ার নির্বাচন করুন (প্রতি শেয়ার মাত্র ৳২৫,৫০০)।",
          icon: "Coins",
        },
        {
          num: "4",
          numBn: "৪",
          title: "City Bank Escrow Clearing",
          titleBn: "সিটি ব্যাংক এসক্রো ক্লিয়ারিং",
          desc: "Direct deposit via The City Bank PLC Escrow or online EPS gateway.",
          descBn: "EPS গেটওয়ে (বিকাশ/কার্ড) অথবা সরাসরি সিটি ব্যাংক এসক্রো অ্যাকাউন্টে অর্থ জমা দিন।",
          icon: "Landmark",
        },
      ],
    },
    {
      id: "ph-3",
      phaseNum: "03",
      phaseTitle: "Digital Asset & Profit Payout",
      phaseTitleBn: "ডিজিটাল সার্টিফিকেট ও লভ্যাংশ",
      steps: [
        {
          num: "5",
          numBn: "৫",
          title: "Cryptographic Share Certificate",
          titleBn: "SHA-256 ডিজিটাল সার্টিফিকেট",
          desc: "Instant issuance of cryptographic SHA-256 certificate in your vault.",
          descBn: "পেমেন্ট নিশ্চিতের সাথে সাথে সিকোয়েনশিয়াল লট নম্বর ও হ্যাশযুক্ত সার্টিফিকেট ইস্যু।",
          icon: "FileCheck2",
        },
        {
          num: "6",
          numBn: "৬",
          title: "Pro-Rata Profit Payout",
          titleBn: "প্রো-রাটা ব্যাংক লভ্যাংশ জমা",
          desc: "Direct pro-rata net profit bank transfer upon commercial milestones.",
          descBn: "প্রকল্প থেকে অর্জিত নিট মুনাফা সরাসরি আপনার ব্যাংক অ্যাকাউন্টে প্রো-রাটা হারে জমা হবে।",
          icon: "TrendingUp",
        },
      ],
    },
  ],
  escrowInfo: {
    title: "100% Capital Custody: The City Bank PLC Escrow",
    titleBn: "১০০% মূলধন সুরক্ষা: দ্য সিটি ব্যাংক পিএলসি এসক্রো নিরাপত্তা",
    subtitle: "Your money never enters private personal hands. It stays inside an audited commercial bank escrow trust until official land registration.",
    subtitleBn: "আপনার বিনিয়োগের অর্থ কখনোই কোনো ব্যক্তিগত অ্যাকাউন্টে যায় না। সরকারি সাব-রেজিস্ট্রেশন সম্পন্ন হওয়ার পূর্ব পর্যন্ত প্রতিটি পয়সা দ্য সিটি ব্যাংকে সম্পূর্ণ সুরক্ষিত থাকে।",
    points: [
      {
        text: "Milestone-restricted disbursements authenticated by project steering committee.",
        textBn: "আইনি দলিল ও রেজিস্ট্রি যাচাইয়ের পরেই কেবল ধাপে ধাপে অনুমোদিত ভাউচারে ফান্ড ছাড় হয়।",
      },
      {
        text: "100% automatic principal refund guarantee if subscription threshold is not met.",
        textBn: "প্রকল্পের ন্যূনতম শেয়ার লক্ষ্যমাত্রা অপূর্ণ থাকলে ১০০% মূলধন সরাসরি ব্যাংক হিসাবে ফেরত পাওয়ার নিশ্চয়তা।",
      },
      {
        text: "Permanent audit statements available directly in your investor portal.",
        textBn: "ব্যাংক স্টেটমেন্ট ও ডিসবার্সমেন্ট ট্রেইল সার্বক্ষণিক শেয়ারহোল্ডার ড্যাশবোর্ডে দৃশ্যমান।",
      },
    ],
  },
  cta: {
    title: "Ready to Secure Your First Real Estate Share?",
    titleBn: "আপনার প্রথম নিরাপদ জমির শেয়ার নিশ্চিত করতে প্রস্তুত?",
    subtitle: "Join verified investors participating in LandVest 100 today.",
    subtitleBn: "আজই যুক্ত হোন ল্যান্ডভেস্ট ১০০-এর সম্মানিত অংশীদারদের তালিকায়।",
    buttonText: "Browse Live Projects →",
    buttonTextBn: "চলমান প্রকল্প দেখুন →",
    buttonUrl: "/projects/landvest-100",
  },
};

export const DEFAULT_FAQ_CMS: FaqCmsConfig = {
  header: {
    badge: "FREQUENTLY ASKED QUESTIONS",
    badgeBn: "সাধারণ প্রশ্নোত্তর",
    title: "Everything You Need to Know",
    titleBn: "সচরাচর জিজ্ঞাসিত প্রশ্নাবলী",
    subtitle: "Direct answers regarding share limits, bank escrow safety, profit calculations, and legal title deed ownership.",
    subtitleBn: "শেয়ার বুকিং, সিটি ব্যাংক এসক্রো নিরাপত্তা, মুনাফা বণ্টন ও আইনি সুরক্ষা সংক্রান্ত প্রয়োজনীয় তথ্যাবলী।",
  },
  categories: [
    { key: "ALL", label: "All Questions", labelBn: "সকল প্রশ্ন" },
    { key: "GENERAL", label: "Platform General", labelBn: "প্ল্যাটফর্ম পরিচিতি" },
    { key: "SHARES", label: "Shares & Limits", labelBn: "শেয়ার ও বুকিং" },
    { key: "SECURITY", label: "Bank Escrow", labelBn: "ব্যাংক ও নিরাপত্তা" },
    { key: "RETURNS", label: "Profit & Dividends", labelBn: "মুনাফা ও লভ্যাংশ" },
    { key: "DOCS", label: "Legal Title Deeds", labelBn: "দলিল ও সনদ" },
  ],
  items: [
    {
      id: "faq-1",
      category: "GENERAL",
      q: "How does the Swapnojatri investment platform work?",
      qBn: "স্বপ্নযাত্রী ইনভেস্টমেন্ট প্ল্যাটফর্ম কীভাবে কাজ করে?",
      a: "Swapnojatri is a transparent multi-project crowdfunding platform. Everyday citizens subscribe to fixed share units in vetted land, smart agro, and commercial businesses to earn proportional pro-rata net profits.",
      aBn: "স্বপ্নযাত্রী একটি বহুমুখী ইনভেস্টমেন্ট প্ল্যাটফর্ম। জমি, স্মার্ট কৃষি ও লাভজনক প্রজেক্টে সাধারণ মানুষ অল্প পুঁজিতে অংশ নেন। প্রজেক্ট থেকে অর্জিত নিট মুনাফা অংশগ্রহণকারীদের মাঝে গাণিতিক প্রো-রাটা সূত্রে বণ্টন করা হয়।",
      order: 1,
      active: true,
    },
    {
      id: "faq-2",
      category: "SHARES",
      q: "How many shares exist per project and what is the purchase limit?",
      qBn: "একটি প্রজেক্টে কতগুলো শেয়ার থাকে এবং একজন কতটি শেয়ার কিনতে পারেন?",
      a: "LandVest 100 has strictly 100 fixed shares (৳25,500 per share). Each investor can purchase a maximum of 4 shares (4.0% project equity) to prevent concentration and guarantee fair access for everyday individuals.",
      aBn: "ল্যান্ডভেস্ট ১০০ প্রজেক্টে কঠোরভাবে মোট ১০০টি নির্দিষ্ট শেয়ার রয়েছে (প্রতি শেয়ারের মূল্য ৳২৫,৫০০)। একজন বিনিয়োগকারী সর্বোচ্চ ৪টি শেয়ার (৪.০% ইকুইটি) ক্রয় করতে পারেন, যা সবার জন্য সমান সুযোগ নিশ্চিত করে।",
      order: 2,
      active: true,
    },
    {
      id: "faq-3",
      category: "SECURITY",
      q: "How is my invested capital secured against fraud?",
      qBn: "আমার বিনিয়োগের টাকা কীভাবে সুরক্ষিত থাকে?",
      a: "All capital is cleared directly through The City Bank PLC Escrow Account. Funds cannot be withdrawn without verified project milestone vouchers, ensuring 100% fiduciary protection.",
      aBn: "সকল বিনিয়োগ দ্য সিটি ব্যাংক পিএলসি-এর বিশেষ এসক্রো অ্যাকাউন্টে জমা হয়। অডিটকৃত ও অনুমোদিত প্রজেক্ট ব্যয় ছাড়া এই অ্যাকাউন্ট থেকে ফান্ড উত্তোলন করা সম্ভব নয়। প্রতিটি খরচের ভাউচার লাইভ লেজারে দেখা যায়।",
      order: 3,
      active: true,
    },
    {
      id: "faq-4",
      category: "RETURNS",
      q: "When and how are profits distributed to my account?",
      qBn: "লভ্যাংশ কখন এবং কীভাবে বণ্টন করা হয়?",
      a: "Realized profits from commercial sales and crop harvests are distributed quarterly or at project maturity directly into your registered bank account with complete audit statements.",
      aBn: "বাণিজ্যিক ও কৃষি প্রজেক্টের মুনাফা ত্রৈমাসিক অথবা প্রজেক্ট সমাপ্তির পর সরাসরি আপনার ব্যাংক অ্যাকাউন্টে জমা হবে। লভ্যাংশ বণ্টনের সম্পূর্ণ বিবরণী আপনার ড্যাশবোর্ডে থাকবে।",
      order: 4,
      active: true,
    },
    {
      id: "faq-5",
      category: "DOCS",
      q: "What official proof of investment do I receive?",
      qBn: "বিনিয়োগের প্রমাণ হিসেবে কী পাব?",
      a: "Upon payment clearance, the platform assigns unique sequential lot numbers (e.g. LOT-075) and issues an authoritative digital Share Certificate with SHA-256 cryptographic verification.",
      aBn: "পেমেন্ট নিশ্চিত হওয়ার সাথে সাথে ডাটাবেস আপনাকে অদ্বিতীয় সিকোয়েনশিয়াল লট নম্বর বরাদ্দ করবে এবং আপনার ডকুমেন্ট ভল্টে SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশযুক্ত অফিসিয়াল ডিজিটাল শেয়ার সার্টিফিকেট ইস্যু হবে।",
      order: 5,
      active: true,
    },
  ],
};

export const DEFAULT_DOCUMENTS_CMS: DocumentsCmsConfig = {
  header: {
    badge: "OFFICIAL CRYPTOGRAPHIC VAULT",
    badgeBn: "অফিসিয়াল ডকুমেন্ট ভল্ট",
    title: "Verified Documents & SHA-256 Vault",
    titleBn: "যাচাইকৃত নথি ও অডিট সার্টিফিকেট",
    subtitle: "Every legal partnership deed, escrow trust agreement, and audited expense report stored with immutable SHA-256 checksums.",
    subtitleBn: "প্ল্যাটফর্মের প্রতিটি আইনি চুক্তি ও অডিট ভাউচার SHA-256 ক্রিপ্টোগ্রাফিক হ্যাশ সহ সুরক্ষিতভাবে সংরক্ষিত।",
  },
  categories: [
    { key: "ALL", label: "All Documents", labelBn: "সকল ডকুমেন্টস" },
    { key: "DEED", label: "Legal Deeds", labelBn: "আইনি দলিল" },
    { key: "ESCROW", label: "Escrow Agreements", labelBn: "এসক্রো চুক্তি" },
    { key: "AUDIT", label: "Audit Reports", labelBn: "অডিট রিপোর্ট" },
    { key: "SURVEY", label: "Cadastral Survey", labelBn: "সার্ভে ও ম্যাপ" },
  ],
  documents: [
    {
      id: "doc-01",
      title: "LandVest 100 Partnership Deed & Framework",
      titleBn: "ল্যান্ডভেস্ট ১০০ পার্টনারশিপ কাঠামো ও ডিড",
      category: "DEED",
      categoryBn: "আইনি পার্টনারশিপ",
      type: "PDF",
      size: "2.4 MB",
      date: "2026-08-01",
      hash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      fileUrl: "/documents/prospectus.pdf",
      visibility: "PUBLIC",
    },
    {
      id: "doc-02",
      title: "The City Bank PLC Escrow Trust Agreement",
      titleBn: "সিটি ব্যাংক এসক্রো ক্লিয়ারিং এগ্রিমেন্ট",
      category: "ESCROW",
      categoryBn: "এসক্রো ট্রাস্ট",
      type: "PDF",
      size: "1.8 MB",
      date: "2026-08-05",
      hash: "8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4",
      fileUrl: "/documents/agreement.pdf",
      visibility: "PUBLIC",
    },
    {
      id: "doc-03",
      title: "Audited Expense Vouchers & Disbursement Ledger",
      titleBn: "ভাউচার অডিট রিপোর্ট ও রসিদ সংকলন",
      category: "AUDIT",
      categoryBn: "অডিট লেজার",
      type: "PDF",
      size: "4.1 MB",
      date: "2026-08-28",
      hash: "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb",
      fileUrl: "/documents/faq.pdf",
      visibility: "INVESTOR_ONLY",
    },
    {
      id: "doc-04",
      title: "Digital Cadastral GPS Survey & Site Demarcation",
      titleBn: "ডিজিটাল জিপিএস সার্ভে ও সীমানা জরিপ রিপোর্ট",
      category: "SURVEY",
      categoryBn: "সার্ভে ম্যাপ",
      type: "PDF",
      size: "3.2 MB",
      date: "2026-08-25",
      hash: "fb8e20fc2e4c3f248c60c39bd652f3c1347298ab97b6b90723a12361b2e2d537",
      fileUrl: "/documents/prospectus.pdf",
      visibility: "PUBLIC",
    },
  ],
};

export const DEFAULT_CONTACT_CMS: ContactCmsConfig = {
  header: {
    badge: "INSTITUTIONAL CONTACT & BANKING",
    badgeBn: "অফিসিয়াল যোগাযোগ ও ব্যাংকিং",
    title: "Connect with Swapnojatri",
    titleBn: "আমাদের সাথে যুক্ত হোন",
    subtitle: "Reach out for project site visits, share subscriptions, or verified bank escrow clearing inquiries.",
    subtitleBn: "প্রকল্প পরিদর্শন, শেয়ার বুকিং কিংবা ব্যাংক এসক্রো ডিপোজিট সংক্রান্ত যেকোনো প্রয়োজনে আমাদের সাথে সরাসরি যোগাযোগ করুন।",
  },
  bankPassbook: {
    bankName: "The City Bank PLC",
    bankNameBn: "দ্য সিটি ব্যাংক পিএলসি",
    badge: "100% ESCROW SAFE",
    accountTitle: "Swapnojatri Investment Platform Ltd",
    accountNumber: "1102938475001",
    routingNumber: "225261890",
    branchName: "Gulshan Corporate Branch, Dhaka",
    branchNameBn: "গুলশান করপোরেট শাখা, ঢাকা",
    swiftCode: "CIBLBDDH",
    notice: "Deposits to this account are custodial escrow funds governed under joint fiduciary trust agreement.",
    noticeBn: "এই হিসাবে জমাকৃত সকল অর্থ যৌথ এসক্রো ট্রাস্ট চুক্তির আওতায় সংরক্ষিত থাকে।",
  },
  headOffice: {
    title: "Corporate Headquarters",
    titleBn: "প্রধান করপোরেট কার্যালয়",
    address: "Level 7, Concord Tower, Road 11, Gulshan-2, Dhaka 1212, Bangladesh",
    addressBn: "লেভেল ৭, কনকর্ড টাওয়ার, রোড ১১, গুলশান-২, ঢাকা ১২১২, বাংলাদেশ",
    phone: "+880 1700-000000",
    email: "contact@swapnojatri.com",
    hours: "Saturday – Thursday: 9:30 AM – 6:30 PM",
    hoursBn: "শনিবার – বৃহস্পতিবার: সকাল ৯:৩০ – সন্ধ্যা ৬:৩০",
    mapUrl: "https://maps.google.com/?q=Gulshan+2+Dhaka",
  },
  siteOffice: {
    title: "LandVest 100 Project Site Office",
    titleBn: "ল্যান্ডভেস্ট ১০০ সাইট অফিস",
    address: "Washpur Tower Road, Beside Bosila Bridge West, Savar / Keraniganj Border, Dhaka",
    addressBn: "ওয়াশপুর টাওয়ার রোড, বসিলা ব্রিজ পশ্চিম সংলগ্ন, সাভার / কেরানীগঞ্জ সীমানা, ঢাকা",
    phone: "+880 1711-223344",
    visitingSchedule: "Friday & Saturday: 10:00 AM – 5:00 PM (Chauffeur guided tour)",
    visitingScheduleBn: "প্রতি শুক্র ও শনিবার: সকাল ১০:০০ – বিকাল ৫:০০ (নিজস্ব পরিবহনে সাইট ভিজিট)",
    mapUrl: "https://maps.google.com/?q=Washpur+Bosila+Dhaka",
  },
  channels: {
    whatsappNumber: "+8801700000000",
    whatsappMessage: "Hello, I want to inquire about Swapnojatri project shares.",
    advisorHotline: "+8801700000000",
    supportEmail: "invest@swapnojatri.com",
  },
};

export const DEFAULT_MASTER_CMS: MasterCmsState = {
  global: DEFAULT_GLOBAL_CMS,
  home: DEFAULT_HOME_CMS,
  about: DEFAULT_ABOUT_CMS,
  howItWorks: DEFAULT_HOW_IT_WORKS_CMS,
  faq: DEFAULT_FAQ_CMS,
  documents: DEFAULT_DOCUMENTS_CMS,
  contact: DEFAULT_CONTACT_CMS,
  updatedAt: new Date().toISOString(),
};
