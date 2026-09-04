import { NextRequest, NextResponse } from "next/server";
import { db, ServerDistribution } from "@/lib/server/db";

export async function GET() {
  try {
    const distributions = db.distributions;
    const totalPaid = distributions
      .filter((d) => d.status === "PAID")
      .reduce((sum, d) => sum + d.amount, 0);

    return NextResponse.json({
      success: true,
      data: distributions,
      summary: {
        totalPaid,
        totalDistributionsCount: distributions.length,
        nextScheduledPeriod: "Q3 2026 Audit Distribution (October 2026)",
      },
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch distributions", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { period, amount, eligibleLots } = body;

    if (!period || !amount) {
      return NextResponse.json(
        { success: false, message: "Distribution period and amount are required" },
        { status: 400 }
      );
    }

    const grossAmount = Number(amount);
    const taxDeducted = Math.round(grossAmount * 0.05); // 5% standard withholding tax
    const netAmount = grossAmount - taxDeducted;

    const newDistribution: ServerDistribution = {
      id: `dist-${Date.now()}`,
      period,
      periodBn: body.periodBn || period,
      amount: netAmount,
      grossAmount,
      taxDeducted,
      date: new Date().toISOString().split("T")[0],
      status: "PAID",
      paymentChannel: body.paymentChannel || "City Bank Escrow (Direct EFT)",
      transactionId: `EFT-${Math.floor(10000000 + Math.random() * 90000000)}`,
      eligibleLots: Number(eligibleLots || 4),
      returnRoiPercent: Number(body.returnRoiPercent || 8.0),
    };

    db.distributions.unshift(newDistribution);

    return NextResponse.json(
      {
        success: true,
        message: "Dividend distribution recorded and dispatched successfully",
        data: newDistribution,
      },
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to process distribution", error: String(error) },
      { status: 500 }
    );
  }
}
