import { NextRequest, NextResponse } from "next/server";
import { db, ServerInvestment } from "@/lib/server/db";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const investorId = searchParams.get("investorId");

    let investments = db.investments;
    if (investorId) {
      investments = investments.filter((i) => i.investorId === investorId);
    }

    const totalInvestedAmount = investments
      .filter((i) => i.status === "ALLOCATED")
      .reduce((sum, i) => sum + i.amount, 0);

    const totalSharesCount = investments
      .filter((i) => i.status === "ALLOCATED")
      .reduce((sum, i) => sum + i.lotUnits, 0);

    return NextResponse.json({
      success: true,
      data: investments,
      summary: {
        totalInvestedAmount,
        totalSharesCount,
        activeProjectsCount: new Set(investments.map((i) => i.projectId)).size,
      },
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch investments", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { projectId, lotUnits, paymentMethod, transactionRef } = body;

    if (!projectId || !lotUnits || lotUnits <= 0) {
      return NextResponse.json(
        { success: false, message: "Project ID and valid lot units required" },
        { status: 400 }
      );
    }

    const project = db.projects.find((p) => p.id === projectId || p.code === projectId);
    if (!project) {
      return NextResponse.json(
        { success: false, message: "Project not found" },
        { status: 404 }
      );
    }

    const startLotNum = (project.allocated_shares || 74) + 1;
    const assignedLots: string[] = [];
    for (let i = 0; i < lotUnits; i++) {
      assignedLots.push(`LOT-${String(startLotNum + i).padStart(3, "0")}`);
    }

    const totalAmount = Number(lotUnits) * Number(project.price_per_share || 25500);

    const newInvestment: ServerInvestment = {
      id: `inv-${Date.now()}`,
      projectId: project.id,
      projectCode: project.code,
      projectName: project.name,
      projectNameBn: project.name_bn,
      investorId: body.investorId || "usr-inv-001",
      investorName: body.investorName || "Tariqul Islam Chowdhury",
      investorPhone: body.investorPhone || "+880 1711-000000",
      lotUnits,
      lotNumbers: assignedLots,
      amount: totalAmount,
      status: "ALLOCATED",
      paymentMethod: paymentMethod || "CITY_BANK_ESCROW",
      transactionRef: transactionRef || `TXN-${Math.floor(10000000 + Math.random() * 90000000)}`,
      certificateNumber: `SJ-${project.code}-2026-${String(startLotNum).padStart(4, "0")}`,
      subscribedAt: new Date().toISOString(),
      verifiedAt: new Date().toISOString(),
      nextAuditDate: "2026-10-15",
    };

    db.investments.unshift(newInvestment);
    project.allocated_shares = (project.allocated_shares || 0) + lotUnits;
    project.available_shares = Math.max(0, project.total_shares - project.allocated_shares);

    return NextResponse.json(
      {
        success: true,
        message: "Investment lot subscribed and allocated successfully",
        data: newInvestment,
      },
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to process investment", error: String(error) },
      { status: 500 }
    );
  }
}
