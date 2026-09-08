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
  storyImages: AboutImageItem[];
  updatedAt?: string;
}

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

export const DEFAULT_ABOUT_CMS: AboutPageCmsConfig = {
  heroImage: {
    imageUrl: "/images/hero_investment_bg.jpg",
    badge: "VERIFIED GROUND ASSET",
    badgeBn: "যাচাইকৃত বাস্তব প্রকল্প",
    caption: "Strategic prime land parcel & smart agro cluster across Bosila Bridge, Dhaka.",
    captionBn: "বসিলা ব্রিজ পার হয়ে ওয়াশপুর টাওয়ার রোড ও সিংগাইর এগ্রো বেল্টে বাস্তব ভূমি প্রকল্প।",
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
  updatedAt: new Date().toISOString(),
};
