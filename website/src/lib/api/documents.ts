import { apiClient } from "./client";
import { DocumentItem, StandardResponse } from "@/types/api";

export async function getProjectDocuments(projectId: string): Promise<DocumentItem[]> {
  const res = (await apiClient.get(`/documents/project/${projectId}`)) as unknown as StandardResponse<DocumentItem[]>;
  return res.data;
}

export async function getDocumentDownloadUrl(
  documentId: string
): Promise<{ download_url: string; expires_in_seconds: number; checksum_sha256: string }> {
  const res = (await apiClient.get(`/documents/${documentId}/download-url`)) as unknown as StandardResponse<any>;
  return res.data;
}

export const FALLBACK_DOCUMENTS: DocumentItem[] = [
  {
    id: "doc-agreement-01",
    title: "LandVest 100 Partnership & Profit-Sharing Charter",
    title_bn: "ল্যান্ডভেস্ট ১০০ পার্টনারশিপ ও লভ্যাংশ বণ্টন সনদ",
    category: "REPORT",
    visibility: "PUBLIC",
    file_name: "Swapnojatri_LandVest100_Charter.pdf",
    file_size_human: "2.4 MB",
    checksum_sha256: "7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d",
    version: "v1.0 (Official)",
    uploaded_by: "Project Management Directorate",
    created_at: "2026-08-01T00:00:00Z",
  },
  {
    id: "doc-audit-02",
    title: "Independent Financial Audit & Fund Utilization Report",
    title_bn: "স্বাধীন আর্থিক অডিট ও তহবিল ব্যবহার বিবরণী",
    category: "REPORT",
    visibility: "PUBLIC",
    file_name: "Financial_Audit_Report_LV100.pdf",
    file_size_human: "1.8 MB",
    checksum_sha256: "3f2a1b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a",
    version: "v1.0 (Audited)",
    uploaded_by: "Chartered Audit Directorate",
    created_at: "2026-08-15T00:00:00Z",
  },
  {
    id: "doc-milestone-03",
    title: "Quarterly Project Progress & Valuation Report",
    title_bn: "ত্রৈমাসিক প্রকল্প অগ্রগতি ও মূল্যায়ন রিপোর্ট",
    category: "REPORT",
    visibility: "PUBLIC",
    file_name: "Project_Progress_Report_Q3_2026.pdf",
    file_size_human: "3.2 MB",
    checksum_sha256: "9a8b7c6d5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d7e6f5a4b3c2d1e0f9a8b",
    version: "v1.0 (Verified)",
    uploaded_by: "Site Development Team",
    created_at: "2026-08-25T00:00:00Z",
  },
];
