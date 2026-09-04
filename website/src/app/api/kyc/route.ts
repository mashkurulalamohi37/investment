import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET() {
  try {
    return NextResponse.json({
      success: true,
      data: db.kyc,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to retrieve KYC data", error: String(error) },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const body = await request.json();
    db.kyc = {
      ...db.kyc,
      ...body,
      isVerified: true,
      verificationStatus: "VERIFIED",
    };

    return NextResponse.json({
      success: true,
      message: "KYC & Nominee particulars updated successfully",
      data: db.kyc,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to update KYC data", error: String(error) },
      { status: 500 }
    );
  }
}
