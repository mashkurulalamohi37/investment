import { NextRequest, NextResponse } from "next/server";
import { db, ServerWithdrawal } from "@/lib/server/db";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const userId = searchParams.get("userId") || "usr-inv-001";

    const userWithdrawals = db.withdrawals.filter((w) => w.userId === userId);
    const totalWithdrawn = userWithdrawals
      .filter((w) => w.status === "COMPLETED")
      .reduce((sum, w) => sum + w.amount, 0);

    const pendingAmount = userWithdrawals
      .filter((w) => w.status === "PENDING" || w.status === "PROCESSING")
      .reduce((sum, w) => sum + w.amount, 0);

    return NextResponse.json({
      success: true,
      data: userWithdrawals,
      summary: {
        totalWithdrawn,
        pendingAmount,
        totalRequestsCount: userWithdrawals.length,
      },
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch withdrawals", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      type = "DIVIDEND",
      amount,
      payoutChannel = "BANK_TRANSFER",
      bankName,
      accountHolderName,
      accountNumber,
      branchName,
      routingNumber,
      mfsNumber,
      userNote,
    } = body;

    const numAmount = Number(amount);
    if (!numAmount || numAmount <= 0) {
      return NextResponse.json(
        { success: false, message: "Valid withdrawal amount is required" },
        { status: 400 }
      );
    }

    const newWithdrawal: ServerWithdrawal = {
      id: `wth-${Date.now()}`,
      userId: body.userId || "usr-inv-001",
      userName: body.userName || db.kyc.fullName,
      projectId: body.projectId || "proj-lv100",
      projectName: body.projectName || "LandVest 100 (Washpur, Dhaka)",
      projectNameBn: body.projectNameBn || "ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)",
      type: type === "CAPITAL_EXIT" ? "CAPITAL_EXIT" : "DIVIDEND",
      amount: numAmount,
      fee: 0,
      netAmount: numAmount,
      payoutChannel: payoutChannel || "BANK_TRANSFER",
      bankName: bankName || db.kyc.bankName,
      accountHolderName: accountHolderName || db.kyc.fullName,
      accountNumber: accountNumber || db.kyc.bankAccountNo,
      branchName: branchName || db.kyc.bankBranch,
      routingNumber: routingNumber || db.kyc.bankRoutingNo,
      mfsNumber,
      status: "PENDING",
      userNote,
      createdAt: new Date().toISOString(),
    };

    db.withdrawals.unshift(newWithdrawal);

    return NextResponse.json({
      success: true,
      message: "Withdrawal request submitted successfully",
      data: newWithdrawal,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to process withdrawal request", error: String(error) },
      { status: 500 }
    );
  }
}
