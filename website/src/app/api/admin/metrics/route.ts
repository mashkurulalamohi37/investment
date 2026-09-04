import { NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET() {
  try {
    const totalRaised = db.investments
      .filter((i) => i.status === "ALLOCATED")
      .reduce((sum, i) => sum + i.amount, 0);

    const totalDistributed = db.distributions
      .filter((d) => d.status === "PAID")
      .reduce((sum, d) => sum + d.amount, 0);

    return NextResponse.json({
      success: true,
      data: {
        totalRaised: totalRaised || db.adminStats.totalRaised,
        totalTarget: db.adminStats.totalTarget,
        activeInvestorsCount: db.adminStats.activeInvestorsCount,
        activeProjectsCount: db.projects.length,
        totalDistributedProfit: totalDistributed || db.adminStats.totalDistributedProfit,
        cityBankEscrowBalance: db.adminStats.cityBankEscrowBalance,
        projects: db.projects,
        recentInvestments: db.investments.slice(0, 5),
        recentDistributions: db.distributions.slice(0, 5),
      },
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch admin metrics", error: String(error) },
      { status: 500 }
    );
  }
}
