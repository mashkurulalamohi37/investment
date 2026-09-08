import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET() {
  try {
    const withdrawals = db.withdrawals;
    const pendingCount = withdrawals.filter((w) => w.status === "PENDING" || w.status === "PROCESSING").length;
    const totalDisbursed = withdrawals
      .filter((w) => w.status === "COMPLETED")
      .reduce((sum, w) => sum + w.amount, 0);

    return NextResponse.json({
      success: true,
      data: withdrawals,
      summary: {
        totalRequests: withdrawals.length,
        pendingCount,
        totalDisbursed,
      },
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch admin withdrawals", error: String(error) },
      { status: 500 }
    );
  }
}

export async function PATCH(request: NextRequest) {
  try {
    const body = await request.json();
    const { id, action, transactionRef, adminFeedback } = body;

    if (!id || !action) {
      return NextResponse.json(
        { success: false, message: "Withdrawal ID and action are required" },
        { status: 400 }
      );
    }

    const item = db.withdrawals.find((w) => w.id === id);
    if (!item) {
      return NextResponse.json(
        { success: false, message: "Withdrawal request not found" },
        { status: 404 }
      );
    }

    if (action === "APPROVE") {
      item.status = "COMPLETED";
      item.transactionRef = transactionRef || `CBL-EFT-${Date.now().toString().substring(5)}`;
      item.adminFeedback = adminFeedback || "Disbursed via Escrow clearing";
      item.processedAt = new Date().toISOString();
    } else if (action === "REJECT") {
      item.status = "REJECTED";
      item.adminFeedback = adminFeedback || "Declined by compliance";
      item.processedAt = new Date().toISOString();
    } else {
      return NextResponse.json(
        { success: false, message: "Invalid action. Use APPROVE or REJECT" },
        { status: 400 }
      );
    }

    return NextResponse.json({
      success: true,
      message: `Withdrawal ${action.toLowerCase()}d successfully`,
      data: item,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to update withdrawal", error: String(error) },
      { status: 500 }
    );
  }
}
