// Server-side State Store for Swapnojatri API (cPanel compatible)
import { SWAPNOJATRI_PROJECTS } from "../api/projects";
import { Project } from "@/types/api";

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

  adminStats = {
    totalRaised: 18450000,
    totalTarget: 25000000,
    activeInvestorsCount: 142,
    activeProjectsCount: 3,
    totalDistributedProfit: 3420000,
    cityBankEscrowBalance: 12850000,
  };
}

// Global singleton instance for server execution
const globalForDb = global as unknown as { dbStore: DataStore };
export const db = globalForDb.dbStore || new DataStore();
if (process.env.NODE_ENV !== "production") globalForDb.dbStore = db;
