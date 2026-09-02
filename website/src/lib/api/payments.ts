import { apiClient } from "./client";
import { EpsSessionResponse, StandardResponse } from "@/types/api";

export async function initiateEpsSession(payload: {
  investment_id: string;
  channel: string;
  customer_phone?: string;
}): Promise<EpsSessionResponse> {
  const res = (await apiClient.post("/payments/eps/initiate", payload)) as unknown as StandardResponse<EpsSessionResponse>;
  return res.data;
}
