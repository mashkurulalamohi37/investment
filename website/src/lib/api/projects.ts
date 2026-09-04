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
    id: "proj-agro-farm",
    code: "AGRO-01",
    name: "Swapnojatri Smart Agro & High-Yield Farm",
    name_bn: "স্বপ্নযাত্রী স্মার্ট কৃষি ও ডেইরি/এগ্রো প্রজেক্ট",
    category: "AGRICULTURAL",
    location: "Singair Agro Belt, Manikganj (Near Dhaka)",
    location_bn: "সিংগাইর এগ্রো বেল্ট, মানিকগঞ্জ (ঢাকা সংলগ্ন)",
    description:
      "Modern high-yield agro farming, organic greenhouse cultivation, and cattle farming with seasonal profit returns for investors.",
    description_bn:
      "আধুনিক সমন্বিত কৃষি, উন্নত জাতের অর্গানিক ফসল চাষ ও পশুপালন প্রকল্প। অভিজ্ঞ কৃষি বিশেষজ্ঞদের তত্ত্বাবধানে পরিচালিত এবং প্রতি সিজন শেষে সরাসরি বিনিয়োগকারীদের লভ্যাংশ প্রদান।",
    target_fund: 1500000,
    price_per_share: 15000,
    total_shares: 100,
    allocated_shares: 35,
    available_shares: 65,
    min_shares: 1,
    max_shares: 5,
    status: "OPEN",
    projected_roi_min: 20.0,
    projected_roi_max: 25.0,
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
        description: "Planting and livestock management.",
        description_bn: "উচ্চফলনশীল বীজ রোপণ ও গবাদি পশুর আধুনিক খামার ব্যবস্থাপনা।",
        milestone_date: "2026-09-20T00:00:00Z",
        is_completed: false,
        sequence: 2,
      },
    ],
  },
];

export const FALLBACK_LANDVEST_100 = SWAPNOJATRI_PROJECTS[0];
