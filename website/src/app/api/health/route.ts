import { NextResponse } from "next/server";

export async function GET() {
  return NextResponse.json({
    status: "healthy",
    platform: "Swapnojatri Shariah Investment Platform",
    version: "2.5.0-production",
    timestamp: new Date().toISOString(),
    escrowPartner: "The City Bank Limited",
    environment: process.env.NODE_ENV || "production",
  });
}
