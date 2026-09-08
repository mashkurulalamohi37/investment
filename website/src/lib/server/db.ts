// Server-side State Store for Swapnojatri API (cPanel compatible)
import fs from "fs";
import path from "path";
import { SWAPNOJATRI_PROJECTS } from "../api/projects";
import { Project } from "@/types/api";
import { 
  MasterCmsState, 
  DEFAULT_MASTER_CMS, 
  AboutPageCmsConfig, 
  DEFAULT_ABOUT_CMS 
} from "@/types/cms";

export interface ServerInvestment {
  id: string;
  projectId: string;
  projectCode: string;
  projectName: string;
  projectNameBn: string;
  investorId: string;
  investorName: string;
  investorPhone: string;
  lotUnits: number;
  lotNumbers: string[];
  amount: number;
  status: "ALLOCATED" | "PENDING_VERIFICATION" | "REJECTED";
  paymentMethod: "CITY_BANK_ESCROW" | "BKASH" | "NAGAD" | "BANK_TRANSFER";
  transactionRef: string;
  certificateNumber: string;
  subscribedAt: string;
  verifiedAt?: string;
  nextAuditDate: string;
}

export interface ServerDistribution {
  id: string;
  period: string;
  periodBn: string;
  amount: number;
  grossAmount: number;
  taxDeducted: number;
  date: string;
  status: "PAID" | "PROCESSING" | "SCHEDULED";
  paymentChannel: string;
  transactionId: string;
  eligibleLots: number;
  returnRoiPercent: number;
}

export interface ServerWithdrawal {
  id: string;
  userId: string;
  userName: string;
  projectId?: string;
  projectName?: string;
  projectNameBn?: string;
  type: "DIVIDEND" | "CAPITAL_EXIT";
  amount: number;
  fee: number;
  netAmount: number;
  payoutChannel: "BANK_TRANSFER" | "BKASH" | "NAGAD" | "ROCKET";
  bankName?: string;
  accountHolderName?: string;
  accountNumber?: string;
  branchName?: string;
  routingNumber?: string;
  mfsNumber?: string;
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "REJECTED" | "CANCELLED";
  userNote?: string;
  adminFeedback?: string;
  transactionRef?: string;
  createdAt: string;
  processedAt?: string;
}

export interface ServerKyc {
  investorId: string;
  fullName: string;
  fullNameBn: string;
  fatherHusbandName: string;
  motherName: string;
  nidPassportNumber: string;
  phone: string;
  email: string;
  presentAddress: string;
  permanentAddress: string;
  bankName: string;
  bankAccountNo: string;
  bankBranch: string;
  bankRoutingNo: string;
  nomineeName: string;
  nomineeRelation: string;
  nomineeNid: string;
  nomineeSharePercentage: number;
  nomineePhone: string;
  isVerified: boolean;
  verificationStatus: "VERIFIED" | "PENDING" | "REJECTED";
  verifiedAt: string;
  tier: "VIP_DIRECTOR" | "GENERAL_INVESTOR";
}

// Global in-memory data store with default seed records
class DataStore {
  projects: Project[] = [...SWAPNOJATRI_PROJECTS];
  
  investments: ServerInvestment[] = [
    {
      id: "inv-001",
      projectId: "proj-lv100",
      projectCode: "LV100",
      projectName: "LandVest 100 (Washpur, Dhaka)",
      projectNameBn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
      investorId: "usr-inv-001",
      investorName: "Tariqul Islam Chowdhury",
      investorPhone: "+880 1711-000000",
      lotUnits: 4,
      lotNumbers: ["LOT-041", "LOT-042", "LOT-043", "LOT-044"],
      amount: 102000,
      status: "ALLOCATED",
      paymentMethod: "CITY_BANK_ESCROW",
      transactionRef: "CBL-TXN-99482104",
      certificateNumber: "SJ-LV100-2026-004144",
      subscribedAt: "2026-08-05T10:30:00Z",
      verifiedAt: "2026-08-06T14:00:00Z",
      nextAuditDate: "2026-10-15",
    },
  ];

  distributions: ServerDistribution[] = [
    {
      id: "dist-003",
      period: "Q2 2026 Profit Settlement",
      periodBn: "দ্বিতীয় প্রান্তিক ২০২৬ মুনাফা বণ্টন",
      amount: 8500,
      grossAmount: 9000,
      taxDeducted: 500,
      date: "2026-07-31",
      status: "PAID",
      paymentChannel: "City Bank Escrow (Direct EFT)",
      transactionId: "EFT-88492041",
      eligibleLots: 4,
      returnRoiPercent: 8.33,
    },
    {
      id: "dist-002",
      period: "Q1 2026 Profit Settlement",
      periodBn: "প্রথম প্রান্তিক ২০২৬ মুনাফা বণ্টন",
      amount: 7800,
      grossAmount: 8200,
      taxDeducted: 400,
      date: "2026-04-30",
      status: "PAID",
      paymentChannel: "City Bank Escrow (Direct EFT)",
      transactionId: "EFT-77381902",
      eligibleLots: 4,
      returnRoiPercent: 7.64,
    },
    {
      id: "dist-001",
      period: "Q4 2025 Initial Land Appreciation Distribution",
      periodBn: "চতুর্থ প্রান্তিক ২০২৫ প্রাথমিক মূল্যবৃদ্ধি বণ্টন",
      amount: 6200,
      grossAmount: 6500,
      taxDeducted: 300,
      date: "2026-01-30",
      status: "PAID",
      paymentChannel: "City Bank Escrow (Direct EFT)",
      transactionId: "EFT-66281093",
      eligibleLots: 4,
      returnRoiPercent: 6.07,
    },
  ];

  kyc: ServerKyc = {
    investorId: "usr-inv-001",
    fullName: "Tariqul Islam Chowdhury",
    fullNameBn: "তারিকুল ইসলাম চৌধুরী",
    fatherHusbandName: "Md. Rafiqul Islam Chowdhury",
    motherName: "Sultana Begum",
    nidPassportNumber: "19882694019284716",
    phone: "+880 1711-000000",
    email: "tariqul.islam@example.com",
    presentAddress: "House 42, Road 11, Sector 4, Uttara, Dhaka-1230",
    permanentAddress: "Vill: Mohonpur, P.O: Chandpur, Dist: Chandpur",
    bankName: "The City Bank Limited",
    bankAccountNo: "1102948192001",
    bankBranch: "Uttara Branch, Dhaka",
    bankRoutingNo: "225275394",
    nomineeName: "Farhana Yasmin Chowdhury",
    nomineeRelation: "Spouse (স্ত্রী)",
    nomineeNid: "19922694019284999",
    nomineeSharePercentage: 100,
    nomineePhone: "+880 1712-999888",
    isVerified: true,
    verificationStatus: "VERIFIED",
    verifiedAt: "2026-08-06T14:00:00Z",
    tier: "VIP_DIRECTOR",
  };

  withdrawals: ServerWithdrawal[] = [
    {
      id: "wth-001",
      userId: "usr-inv-001",
      userName: "Tariqul Islam Chowdhury",
      projectId: "proj-lv100",
      projectName: "LandVest 100 (Washpur, Dhaka)",
      projectNameBn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
      type: "DIVIDEND",
      amount: 8500,
      fee: 0,
      netAmount: 8500,
      payoutChannel: "BANK_TRANSFER",
      bankName: "The City Bank Limited",
      accountHolderName: "Tariqul Islam Chowdhury",
      accountNumber: "1102948192001",
      branchName: "Uttara Branch, Dhaka",
      routingNumber: "225275394",
      status: "COMPLETED",
      transactionRef: "CBL-EFT-99182301",
      adminFeedback: "Disbursed via City Bank Escrow BEFTN.",
      createdAt: "2026-08-01T10:00:00Z",
      processedAt: "2026-08-02T12:30:00Z",
    },
    {
      id: "wth-002",
      userId: "usr-inv-001",
      userName: "Tariqul Islam Chowdhury",
      projectId: "proj-lv100",
      projectName: "LandVest 100 (Washpur, Dhaka)",
      projectNameBn: "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
      type: "DIVIDEND",
      amount: 4000,
      fee: 0,
      netAmount: 4000,
      payoutChannel: "BKASH",
      mfsNumber: "01711-000000",
      status: "PENDING",
      userNote: "Profit withdrawal to bKash personal",
      createdAt: "2026-09-07T08:30:00Z",
    },
  ];

  adminStats = {
    totalRaised: 18450000,
    totalTarget: 25000000,
    activeInvestorsCount: 142,
    activeProjectsCount: 3,
    totalDistributedProfit: 3420000,
    cityBankEscrowBalance: 12850000,
  };

  masterCms: MasterCmsState = loadCmsData();

  get aboutCms(): AboutPageCmsConfig {
    return this.masterCms.about;
  }

  set aboutCms(val: AboutPageCmsConfig) {
    this.masterCms.about = val;
    this.masterCms.updatedAt = new Date().toISOString();
    saveCmsData(this.masterCms);
  }

  updateMasterCms(newCms: Partial<MasterCmsState> | MasterCmsState): MasterCmsState {
    this.masterCms = {
      ...this.masterCms,
      ...newCms,
      updatedAt: new Date().toISOString(),
    };
    saveCmsData(this.masterCms);
    return this.masterCms;
  }

  resetMasterCms(): MasterCmsState {
    this.masterCms = {
      ...DEFAULT_MASTER_CMS,
      updatedAt: new Date().toISOString(),
    };
    saveCmsData(this.masterCms);
    return this.masterCms;
  }
}

const CMS_FILE_PATH = path.join(process.cwd(), "src", "data", "cms_data.json");

function loadCmsData(): MasterCmsState {
  try {
    if (fs.existsSync(CMS_FILE_PATH)) {
      const raw = fs.readFileSync(CMS_FILE_PATH, "utf-8");
      const parsed = JSON.parse(raw);
      if (parsed && typeof parsed === "object") {
        return {
          ...DEFAULT_MASTER_CMS,
          ...parsed,
          global: { ...DEFAULT_MASTER_CMS.global, ...(parsed.global || {}) },
          home: { ...DEFAULT_MASTER_CMS.home, ...(parsed.home || {}) },
          about: { ...DEFAULT_MASTER_CMS.about, ...(parsed.about || {}) },
          howItWorks: { ...DEFAULT_MASTER_CMS.howItWorks, ...(parsed.howItWorks || {}) },
          faq: { ...DEFAULT_MASTER_CMS.faq, ...(parsed.faq || {}) },
          documents: { ...DEFAULT_MASTER_CMS.documents, ...(parsed.documents || {}) },
          contact: { ...DEFAULT_MASTER_CMS.contact, ...(parsed.contact || {}) },
        };
      }
    }
  } catch (err) {
    console.warn("Failed to read cms_data.json, falling back to defaults:", err);
  }

  // If file doesn't exist, create it with factory defaults
  try {
    const dir = path.dirname(CMS_FILE_PATH);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(CMS_FILE_PATH, JSON.stringify(DEFAULT_MASTER_CMS, null, 2), "utf-8");
  } catch (err) {
    console.warn("Could not save initial cms_data.json:", err);
  }

  return { ...DEFAULT_MASTER_CMS };
}

function saveCmsData(data: MasterCmsState): boolean {
  try {
    const dir = path.dirname(CMS_FILE_PATH);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(CMS_FILE_PATH, JSON.stringify(data, null, 2), "utf-8");
    return true;
  } catch (err) {
    console.error("Failed to write cms_data.json:", err);
    return false;
  }
}

// Global singleton instance for server execution
const globalForDb = global as unknown as { dbStore: DataStore };
export const db = globalForDb.dbStore || new DataStore();
if (process.env.NODE_ENV !== "production") globalForDb.dbStore = db;

