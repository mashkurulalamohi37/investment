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

// Seed fallback for seamless offline or development preview
export const FALLBACK_LANDVEST_100: Project = {
  id: "proj-lv100-main",
  code: "LV100",
  name: "LandVest 100 (Washpur, Savar)",
  name_bn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, সাভার)",
  category: "REAL_ESTATE",
  location: "Washpur Tower Road, Hemayetpur, Savar, Dhaka",
  location_bn: "ওয়াশপুর টাওয়ার রোড, হেমায়েতপুর, সাভার, ঢাকা",
  description:
    "Prime 22.5 Decimals commercial freehold land with vetted Sub-Registry Deed #4982/2026. Target fund ৳25,50,000 divided into 100 fixed shares of ৳25,500 each.",
  description_bn:
    "সাভার হেমায়েতপুর সংলগ্ন ২২.৫ শতাংশ নিষ্কণ্টক জমি প্রকল্প। ১০০টি নির্ধারিত শেয়ারে মোট তহবিল ২৫,৫০,০০০ টাকা। প্রতি শেয়ার ২৫,৫০০ টাকা।",
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
      title: "Site Selection & Supreme Court Legal Vetting",
      title_bn: "জমি নির্বাচন ও সুপ্রিম কোর্টের সিনিয়র আইনজীবী দ্বারা আইনি যাচাই",
      description: "Complete CS, SA, RS & City Jarip chain vetting and AC Land mutation inspection.",
      milestone_date: "2026-07-15T00:00:00Z",
      is_completed: true,
      sequence: 1,
    },
    {
      id: "m-2",
      title: "LandVest 100 Official Subscription Launch",
      title_bn: "ল্যান্ডভেস্ট ১০০ তহবিল সংগ্রহ ও শেয়ার বরাদ্দ শুরু",
      description: "Opening of 100 fixed shares subscription at ৳25,500 per share with 1-4 shares limit.",
      milestone_date: "2026-08-01T00:00:00Z",
      is_completed: true,
      sequence: 2,
    },
    {
      id: "m-3",
      title: "Sub-Registry Deed Execution & Land Demarcation",
      title_bn: "সাব-রেজিস্ট্রি দলিল রেজিস্ট্রি ও সীমানা প্রাচীর নির্মাণ",
      description: "Execution of Deed #4982/2026 and physical pillar demarcation.",
      milestone_date: "2026-10-30T00:00:00Z",
      is_completed: false,
      sequence: 3,
    },
    {
      id: "m-4",
      title: "Commercial Development & Revenue Generation",
      title_bn: "বাণিজ্যিক উন্নয়ন ও প্রজেক্ট রাজস্ব আয় শুরু",
      description: "Leasing and semi-commercial infrastructure rollout.",
      milestone_date: "2027-02-15T00:00:00Z",
      is_completed: false,
      sequence: 4,
    },
  ],
};
