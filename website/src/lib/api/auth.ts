import { apiClient } from "./client";
import { StandardResponse, TokenResponse, User } from "@/types/api";

export async function loginWithPassword(phone: string, password: string): Promise<TokenResponse> {
  const res = (await apiClient.post("/auth/login", { phone, password })) as unknown as StandardResponse<TokenResponse>;
  return res.data;
}

export async function requestOtp(phone: string): Promise<{ message: string; dev_otp_preview?: string }> {
  const res = (await apiClient.post("/auth/otp/request", { phone })) as unknown as StandardResponse<any>;
  return res.data;
}

export async function verifyOtp(phone: string, otp: string): Promise<TokenResponse> {
  const res = (await apiClient.post("/auth/otp/verify", { phone, otp })) as unknown as StandardResponse<TokenResponse>;
  return res.data;
}

export async function registerUser(payload: {
  phone: string;
  full_name: string;
  email?: string;
  password?: string;
}): Promise<TokenResponse> {
  const res = (await apiClient.post("/auth/register", payload)) as unknown as StandardResponse<TokenResponse>;
  return res.data;
}
