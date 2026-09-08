import { apiClient } from "./client";
import { Project, StandardResponse } from "@/types/api";

export async function getProjects(status?: string): Promise<Project[]> {
  const url = status ? `/projects?status=${status}` : "/projects";
  const res = (await apiClient.get(url)) as unknown as StandardResponse<Project[]>;
  return res.data;
}

export async function getProjectById(projectIdOrCode: string): Promise<Project> {
  const res = (await apiClient.get(`/projects/${projectIdOrCode}`)) as unknown as StandardResponse<Project>;
  return res.data;
}

// Verified Multi-Project Seeds based on Official Swapnojatri Portfolio
export const SWAPNOJATRI_PROJECTS: Project[] = [
  {
    id: "proj-lv100",
    code: "LV100",
    name: "LandVest 100 (Washpur, Dhaka)",
    name_bn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
    category: "REAL_ESTATE",
    location: "Washpur, Tower Road (Across Bosila Bridge), Dhaka",
    location_bn: "ওয়াশপুর (বসিলা ব্রীজ পার হয়ে) টাওয়ার রোড, ঢাকা",
    description:
      "LandVest 100 is an initiative to invest in Dhaka's promising land and share profits. Total investment is divided into 100 fixed parts of ৳25,500 each. Investors participate in project returns without managing operational complexities.",
    description_bn:
      "LandVest 100 মূলত ঢাকায় জমিতে বিনিয়োগ করে মুনাফা ভাগাভাগি করার একটি ছোট পরিসরের উদ্যোগ। পুরো বিনিয়োগকে ১০০টি ভাগে ভাগ করা হয়েছে, প্রতিভাগে মোট ২৫,৫০০ টাকা দিয়ে যুক্ত হওয়া যায় (১ থেকে ৪ ভাগ বা তার বেশি)। এখানে আপনি প্রজেক্টে ইনভেস্ট করবেন এবং অর্জিত মুনাফা পাবেন।",
    target_fund: 2550000,
    price_per_share: 25500,
    total_shares: 100,
    allocated_shares: 74,
    available_shares: 26,
    min_shares: 1,
    max_shares: 4,
    status: "OPEN",
    projected_roi_min: 18.5,
    projected_roi_max: 22.0,
    hero_quote: "ছোট বিনিয়োগ, বড় ভবিষ্যৎ...",
    hero_tagline: "আজকের বিশ্বাস আগামীর নিরাপদ ঠিকানা",
    hero_image_url: "/images/landvest_hero.jpg",
    tenure: "৩ - ৫ বছর (আনুমানিক)",
    investment_type: "প্রফিট শেয়ার",
    risk_level: "বাজার পরিস্থিতি অনুসারে",
    map_url: "https://maps.google.com/?q=Washpur,Bosila,Dhaka",
    map_image_url: "/images/washpur_map.svg",
    gallery_images: [
      { title: "বর্তমান জমির অবস্থা", image_url: "/images/gallery_land.jpg" },
      { title: "এলাকার উন্নয়ন সম্ভাবনা", image_url: "/images/gallery_road.jpg" },
      { title: "ভবিষ্যতের সম্ভাবনা", image_url: "/images/gallery_future.jpg" },
    ],
    documents: [
      { title: "প্রকল্প পরিচিতি (PDF)", file_url: "/documents/landvest-100-prospectus.pdf", type: "PDF", size: "2.4 MB" },
      { title: "বিনিয়োগ চুক্তি (PDF)", file_url: "/documents/investment-agreement.pdf", type: "PDF", size: "1.8 MB" },
      { title: "FAQ (PDF)", file_url: "/documents/faq.pdf", type: "PDF", size: "850 KB" },
    ],
    bottom_cta_title: "আপনার টাকারও একটি স্বপ্ন আছে",
    bottom_cta_subtitle: "চলুন, একসাথে গড়ি নিরাপদ ভবিষ্যৎ।",
    milestones: [
      {
        id: "m-1",
        title: "Team & Site Selection at Washpur Tower Road",
        title_bn: "ওয়াশপুর টাওয়ার রোডে প্রজেক্টের সাইট ও পরিকল্পনা চূড়ান্তকরণ",
        description: "Selection of strategic land parcel by experienced Swapnojatri team.",
        description_bn: "অভিজ্ঞ স্বপ্নযাত্রী টিম কর্তৃক কৌশলগতভাবে লাভজনক জমি নির্বাচন ও পরিকল্পনা।",
        milestone_date: "2026-07-15T00:00:00Z",
        is_completed: true,
        sequence: 1,
      },
      {
        id: "m-2",
        title: "LandVest 100 Subscription Opening (100 Parts)",
        title_bn: "ল্যান্ডভেস্ট ১০০ তহবিল ও ১০০ ভাগের ইনভেস্টমেন্ট শুরু",
        description: "Opening 100 fixed parts at ৳25,500 per part for close circle and trusted investors.",
        description_bn: "বিশ্বস্ত বিনিয়োগকারীদের জন্য প্রতি ভাগ ২৫,৫০০ টাকায় মোট ১০০টি ভাগ উন্মুক্তকরণ।",
        milestone_date: "2026-08-01T00:00:00Z",
        is_completed: true,
        sequence: 2,
      },
      {
        id: "m-3",
        title: "Site Development & Commercial Positioning",
        title_bn: "সাইট উন্নয়ন ও বাণিজ্যিক প্রস্তুতি",
        description: "Boundary fencing, site signboard, and planning for maximum value growth.",
        description_bn: "সীমানা প্রাচীর, সাইনবোর্ড স্থাপন এবং জমির সর্বোচ্চ মূল্যবৃদ্ধির বাণিজ্যিক পরিকল্পনা।",
        milestone_date: "2026-10-30T00:00:00Z",
        is_completed: false,
        sequence: 3,
      },
      {
        id: "m-4",
        title: "Profit Generation & Dividend Distribution",
        title_bn: "প্রজেক্ট থেকে মুনাফা অর্জন ও বিনিয়োগকারীদের লভ্যাংশ বণ্টন",
        description: "Commercial revenue and value appreciation profit distribution directly to investors.",
        description_bn: "বাণিজ্যিক আয় ও জমি বিক্রয়জনিত নিট মুনাফা সরাসরি বিনিয়োগকারীদের মাঝে বণ্টন।",
        milestone_date: "2027-02-15T00:00:00Z",
        is_completed: false,
        sequence: 4,
      },
    ],
  },
  {
    id: "proj-agro-season-01",
    code: "AGRO-S1",
    name: "Smart Organic Agro Farming (Season 1)",
    name_bn: "স্মার্ট অর্গানিক এগ্রো ফার্মিং (সিজন ১)",
    category: "AGRICULTURAL",
    location: "Singair Agro Belt, Manikganj (Near Dhaka)",
    location_bn: "সিংগাইর এগ্রো বেল্ট, মানিকগঞ্জ (ঢাকা সংলগ্ন)",
    description:
      "Modern high-yield agro farming, organic greenhouse cultivation, and vegetable expansion with quarterly profit distributions.",
    description_bn:
      "উচ্চ ফলনশীল জৈব সবজি ও আধুনিক গ্রিনহাউস চাষাবাদ প্রকল্প। অভিজ্ঞ কৃষি বিশেষজ্ঞদের তত্ত্বাবধানে পরিচালিত এবং প্রতি ৩ মাস পর পর লভ্যাংশ বণ্টন।",
    target_fund: 1500000,
    price_per_share: 15000,
    total_shares: 100,
    allocated_shares: 42,
    available_shares: 58,
    min_shares: 1,
    max_shares: 5,
    status: "OPEN",
    projected_roi_min: 20.0,
    projected_roi_max: 24.5,
    hero_quote: "উর্বর মাটিতে আধুনিক কৃষি, নিশ্চিত মৌসুমী ফলন...",
    hero_tagline: "টেকসই কৃষির অংশীদারিত্বে সুরক্ষিত রিটার্ন",
    hero_image_url: "/images/hero_investment_bg.jpg",
    tenure: "১ - ২ বছর (ত্রৈমাসিক লভ্যাংশ)",
    investment_type: "এগ্রো প্রফিট শেয়ার",
    risk_level: "প্রাকৃতিক ও বাজার ঝুঁকি সাপেক্ষ",
    map_url: "https://maps.google.com/?q=Singair,Manikganj",
    map_image_url: "/images/washpur_map.svg",
    gallery_images: [
      { title: "গ্রিনহাউস ও অর্গানিক ফার্ম", image_url: "/images/gallery_land.jpg" },
      { title: "আধুনিক সেচ ব্যবস্থা", image_url: "/images/gallery_road.jpg" },
      { title: "মৌসুমী ফসল সংগ্রহ", image_url: "/images/gallery_future.jpg" },
    ],
    documents: [
      { title: "এগ্রো প্রকল্প পরিচিতি (PDF)", file_url: "/documents/agro-prospectus.pdf", type: "PDF", size: "2.1 MB" },
      { title: "কৃষি বিনিয়োগ চুক্তি (PDF)", file_url: "/documents/investment-agreement.pdf", type: "PDF", size: "1.8 MB" },
      { title: "অডিট ও লভ্যাংশ গাইডলাইন (PDF)", file_url: "/documents/faq.pdf", type: "PDF", size: "850 KB" },
    ],
    bottom_cta_title: "আপনার পুঁজিতে হোক সমৃদ্ধ বাংলাদেশ",
    bottom_cta_subtitle: "স্মার্ট এগ্রো উদ্যোগে গড়ে তুলুন নিরাপদ আয়।",
    milestones: [
      {
        id: "ag-1",
        title: "Farmland Lease & Modern Irrigation Setup",
        title_bn: "কৃষি জমি লিজ ও আধুনিক সেচ ব্যবস্থা স্থাপন",
        description: "Land preparation and drip irrigation infrastructure setup.",
        description_bn: "কৃষি জমি প্রস্তুতি ও আধুনিক ড্রিপ সেচ অবকাঠামো স্থাপন।",
        milestone_date: "2026-08-10T00:00:00Z",
        is_completed: true,
        sequence: 1,
      },
      {
        id: "ag-2",
        title: "High-Yield Sowing & Greenhouse Infrastructure",
        title_bn: "উচ্চফলনশীল বীজ বপন ও গ্রিনহাউস শেড তৈরি",
        description: "Planting and farm management.",
        description_bn: "উচ্চফলনশীল বীজ রোপণ ও আধুনিক খামার ব্যবস্থাপনা।",
        milestone_date: "2026-09-20T00:00:00Z",
        is_completed: false,
        sequence: 2,
      },
    ],
  },
  {
    id: "proj-dairy-02",
    code: "DAIRY-01",
    name: "Integrated Modern Dairy & Livestock",
    name_bn: "আধুনিক ডেইরি ও সমন্বিত ক্যাটল প্রজেক্ট",
    category: "AGRICULTURAL",
    location: "Savar Dairy Zone, Dhaka",
    location_bn: "সাভার ডেইরি জোন, ঢাকা",
    description:
      "Commercial dairy farming and breed livestock expansion producing daily supply to Dhaka retail markets. Regular milk clearing and annual festive returns.",
    description_bn:
      "উন্নত জাতের গাভী পালন, বাণিজ্যিক দুগ্ধ উৎপাদন ও ক্যাটল মোটাতাজাকরণ প্রকল্প। রাজধানী ঢাকার খুচরা বাজারে নিয়মিত তরল দুধ সরবরাহ ও বার্ষিক পশু বিক্রয়ের মাধ্যমে আকর্ষণীয় মুনাফা অর্জন।",
    target_fund: 3000000,
    price_per_share: 30000,
    total_shares: 100,
    allocated_shares: 0,
    available_shares: 100,
    min_shares: 1,
    max_shares: 4,
    status: "UPCOMING",
    projected_roi_min: 16.5,
    projected_roi_max: 21.0,
    hero_quote: "উন্নত প্রযুক্তির খামার, প্রতিদিনের তরল দুধের নির্ভরযোগ্য বাজার...",
    hero_tagline: "বাণিজ্যিক ডেইরি খাতে নিরাপদ যৌথ অংশীদারিত্ব",
    hero_image_url: "/images/gallery_road.jpg",
    tenure: "২ - ৩ বছর (বার্ষিক ও অর্ধবার্ষিক লভ্যাংশ)",
    investment_type: "ডেইরি প্রফিট শেয়ার",
    risk_level: "লাইভস্টক স্বাস্থ্য ও বাজার সাপেক্ষ",
    map_url: "https://maps.google.com/?q=Savar,Dhaka",
    map_image_url: "/images/washpur_map.svg",
    gallery_images: [
      { title: "আধুনিক ক্যাটল শেড", image_url: "/images/gallery_land.jpg" },
      { title: "অটোমেটেড মিল্কিং প্রসেসিং", image_url: "/images/gallery_road.jpg" },
      { title: "সবুজ ঘাস ও সাইলেজ ফিড", image_url: "/images/gallery_future.jpg" },
    ],
    documents: [
      { title: "ডেইরি প্রকল্প পরিচিতি (PDF)", file_url: "/documents/dairy-prospectus.pdf", type: "PDF", size: "2.3 MB" },
      { title: "পশুসম্পদ ও ভেটেরিনারি নীতিমালা (PDF)", file_url: "/documents/veterinary-guidelines.pdf", type: "PDF", size: "1.5 MB" },
      { title: "বিনিয়োগ ও মুনাফা বণ্টন চুক্তি (PDF)", file_url: "/documents/investment-agreement.pdf", type: "PDF", size: "1.8 MB" },
    ],
    bottom_cta_title: "ডেইরি ও লাইভস্টক উদ্যোগে নিরাপদ অংশীদারিত্ব",
    bottom_cta_subtitle: "আগামী প্রজন্মের পুষ্টি ও আপনার হালাল মুনাফার মেলবন্ধন।",
    milestones: [
      {
        id: "dy-1",
        title: "Modern Shed Construction & Biosecurity Setup",
        title_bn: "আধুনিক ক্যাটল শেড নির্মাণ ও বায়োসিকিউরিটি প্রাচীর",
        description: "Standard cross-ventilated sheds and bio-secure boundary setup.",
        description_bn: "আন্তর্জাতিক মানের ক্রস-ভেন্টিলেটেড শেড ও বায়োসিকিউরিটি বেষ্টনী তৈরি।",
        milestone_date: "2026-11-15T00:00:00Z",
        is_completed: false,
        sequence: 1,
      },
      {
        id: "dy-2",
        title: "High-Pedigree Cattle Induction & Dairy Setup",
        title_bn: "উন্নত জাতের গাভী সংগ্রহ ও নিয়মিত দুগ্ধ উৎপাদন কার্যক্রম",
        description: "Induction of high-producing dairy cows and automated milking plant.",
        description_bn: "উচ্চ উৎপাদনশীল সংকর জাতের গাভী সংযোজন ও মিল্কিং প্ল্যান্ট চালু।",
        milestone_date: "2027-01-20T00:00:00Z",
        is_completed: false,
        sequence: 2,
      },
    ],
  },
];

export const FALLBACK_LANDVEST_100 = SWAPNOJATRI_PROJECTS[0];

export function findProject(idOrSlug?: string): Project | undefined {
  if (!idOrSlug) return undefined;
  const clean = idOrSlug.trim().toLowerCase();

  // 1. Exact ID or Code Match
  const exact = SWAPNOJATRI_PROJECTS.find(
    (p) => p.id.toLowerCase() === clean || p.code.toLowerCase() === clean
  );
  if (exact) return exact;

  // 2. Common Aliases & Slugs
  if (
    clean === "landvest-100" ||
    clean === "landvest" ||
    clean === "lv-100" ||
    clean === "lv100" ||
    clean.includes("landvest")
  ) {
    return SWAPNOJATRI_PROJECTS.find((p) => p.code === "LV100");
  }

  if (
    clean === "agro-s1" ||
    clean === "agro-season-01" ||
    clean === "agro" ||
    clean.includes("agro") ||
    clean.includes("organic")
  ) {
    return SWAPNOJATRI_PROJECTS.find((p) => p.code === "AGRO-S1");
  }

  if (
    clean === "dairy-01" ||
    clean === "dairy-02" ||
    clean === "dairy" ||
    clean.includes("dairy") ||
    clean.includes("cattle")
  ) {
    return SWAPNOJATRI_PROJECTS.find((p) => p.code === "DAIRY-01");
  }

  return undefined;
}
