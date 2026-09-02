import axios, { AxiosError, InternalAxiosRequestConfig } from "axios";
import { StandardResponse } from "@/types/api";

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:8000/api/v1";

export const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
  timeout: 15000,
});

// Request Interceptor: Attach JWT Bearer Token
apiClient.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    if (typeof window !== "undefined") {
      const token = localStorage.getItem("swapnojatri_access_token");
      if (token && config.headers) {
        config.headers.Authorization = `Bearer ${token}`;
      }
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response Interceptor: Unwrap StandardResponse Envelope
apiClient.interceptors.response.use(
  (response) => {
    return response.data;
  },
  (error: AxiosError<StandardResponse<any>>) => {
    if (error.response?.status === 401) {
      if (typeof window !== "undefined") {
        localStorage.removeItem("swapnojatri_access_token");
        localStorage.removeItem("swapnojatri_user");
        // Redirect to login only if accessing protected portal
        if (window.location.pathname.startsWith("/dashboard") || window.location.pathname.startsWith("/admin")) {
          window.location.href = "/login?expired=1";
        }
      }
    }

    const errorPayload = error.response?.data?.error;
    const message = errorPayload?.message || error.message || "An unexpected error occurred.";
    const code = errorPayload?.code || "NETWORK_ERROR";

    return Promise.reject({
      code,
      message,
      status: error.response?.status,
      details: errorPayload?.details,
    });
  }
);
