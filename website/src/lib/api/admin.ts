import { apiClient } from "./client";
import { ExpenseVoucher, Investment, StandardResponse } from "@/types/api";

export async function getPendingPayments(): Promise<Investment[]> {
  const res = (await apiClient.get("/admin/payments/pending")) as unknown as StandardResponse<Investment[]>;
  return res.data;
}

export async function verifyPaymentAndAllocateLots(investmentId: string): Promise<Investment> {
  const res = (await apiClient.post(`/admin/payments/${investmentId}/verify`)) as unknown as StandardResponse<Investment>;
  return res.data;
}

export async function createExpenseVoucher(payload: {
  project_id: string;
  category: string;
  title: string;
  description: string;
  payee_name: string;
  amount: number;
}): Promise<ExpenseVoucher> {
  const res = (await apiClient.post("/admin/expenses", payload)) as unknown as StandardResponse<ExpenseVoucher>;
  return res.data;
}
