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
    id: "doc-deed-01",
    title: "Sub-Registry Title Deed #4982/2026",
    title_bn: "সাব-রেজিস্ট্রি মূল দলিল #৪৯৮২/২০২৬",
    category: "DEED",
    visibility: "PUBLIC",
    file_name: "Title_Deed_LV100_4982.pdf",
    file_size_human: "4.8 MB",
    checksum_sha256: "7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d",
    version: "v1.0 (Vetted)",
    uploaded_by: "Land Legal Advisory Team",
    created_at: "2026-08-01T00:00:00Z",
  },
  {
    id: "doc-vetting-02",
    title: "Supreme Court Legal Title Vetting Report",
    title_bn: "সুপ্রিম কোর্ট আইনজীবীর আইনি যাচাই সনদ",
    category: "LEGAL",
    visibility: "PUBLIC",
    file_name: "Legal_Vetting_Report_LV100.pdf",
    file_size_human: "2.1 MB",
    checksum_sha256: "3f2a1b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a",
    version: "v1.0 (Final)",
    uploaded_by: "Chambers of Senior Advocate",
    created_at: "2026-07-28T00:00:00Z",
  },
  {
    id: "doc-mutation-03",
    title: "AC Land Mutation & DCR Khatian",
    title_bn: "সহকারী কমিশনার (ভূমি) নামজারি ও ডিসিআর খতিয়ান",
    category: "MUTATION",
    visibility: "PUBLIC",
    file_name: "AC_Land_Mutation_Khatian.pdf",
    file_size_human: "1.6 MB",
    checksum_sha256: "9a8b7c6d5e4f3a2b1c0d9e8f7a6b5c4d3e2f1a0b9c8d7e6f5a4b3c2d1e0f9a8b",
    version: "v1.0 (Verified)",
    uploaded_by: "Savar Upazila Revenue Office",
    created_at: "2026-08-05T00:00:00Z",
  },
];
