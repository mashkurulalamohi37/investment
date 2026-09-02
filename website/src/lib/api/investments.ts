import { apiClient } from "./client";
import { Investment, StandardResponse } from "@/types/api";

export interface CreateInvestmentPayload {
  project_id: string;
  shares: number;
  payment_method: string;
  payment_gateway: "EPS" | "MANUAL_BANK";
  deposit_bank_name?: string;
  depositor_name?: string;
  payment_reference?: string;
  receipt_image_url?: string;
}

export async function createInvestment(payload: CreateInvestmentPayload): Promise<Investment> {
  const res = (await apiClient.post("/investments", payload)) as unknown as StandardResponse<Investment>;
  return res.data;
}

export async function getMyInvestments(): Promise<Investment[]> {
  const res = (await apiClient.get("/investments/me")) as unknown as StandardResponse<Investment[]>;
  return res.data;
}
