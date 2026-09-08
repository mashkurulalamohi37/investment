import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { id } = params;
    const clean = id.trim().toLowerCase();
    const project = db.projects.find(
      (p) =>
        p.id.toLowerCase() === clean ||
        p.code.toLowerCase() === clean ||
        (clean.includes("landvest") && p.code === "LV100") ||
        (clean.includes("agro") && p.code === "AGRO-S1") ||
        (clean.includes("dairy") && p.code === "DAIRY-01")
    );

    if (!project) {
      return NextResponse.json(
        { success: false, message: `Project with ID '${id}' not found` },
        { status: 404 }
      );
    }

    return NextResponse.json({
      success: true,
      data: project,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Error retrieving project", error: String(error) },
      { status: 500 }
    );
  }
}

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { id } = params;
    const clean = id.trim().toLowerCase();
    const body = await request.json();
    const index = db.projects.findIndex(
      (p) =>
        p.id.toLowerCase() === clean ||
        p.code.toLowerCase() === clean ||
        (clean.includes("landvest") && p.code === "LV100") ||
        (clean.includes("agro") && p.code === "AGRO-S1") ||
        (clean.includes("dairy") && p.code === "DAIRY-01")
    );

    if (index === -1) {
      return NextResponse.json(
        { success: false, message: `Project with ID '${id}' not found` },
        { status: 404 }
      );
    }

    db.projects[index] = {
      ...db.projects[index],
      ...body,
      target_fund: body.target_fund !== undefined ? Number(body.target_fund) : db.projects[index].target_fund,
      price_per_share: body.price_per_share !== undefined ? Number(body.price_per_share) : db.projects[index].price_per_share,
      total_shares: body.total_shares !== undefined ? Number(body.total_shares) : db.projects[index].total_shares,
      allocated_shares: body.allocated_shares !== undefined ? Number(body.allocated_shares) : db.projects[index].allocated_shares,
      available_shares:
        body.total_shares !== undefined && body.allocated_shares !== undefined
          ? Number(body.total_shares) - Number(body.allocated_shares)
          : db.projects[index].available_shares,
      projected_roi_min: body.projected_roi_min !== undefined ? Number(body.projected_roi_min) : db.projects[index].projected_roi_min,
      projected_roi_max: body.projected_roi_max !== undefined ? Number(body.projected_roi_max) : db.projects[index].projected_roi_max,
    };

    return NextResponse.json({
      success: true,
      message: "Project updated successfully",
      data: db.projects[index],
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Error updating project", error: String(error) },
      { status: 500 }
    );
  }
}

export async function PATCH(
  request: NextRequest,
  context: { params: { id: string } }
) {
  return PUT(request, context);
}

