import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const status = searchParams.get("status");

    let projects = db.projects;
    if (status) {
      projects = projects.filter((p) => p.status.toUpperCase() === status.toUpperCase());
    }

    return NextResponse.json({
      success: true,
      data: projects,
      total: projects.length,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch projects", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    if (!body.name || !body.target_fund || !body.price_per_share) {
      return NextResponse.json(
        { success: false, message: "Missing required project fields" },
        { status: 400 }
      );
    }

    const newProject = {
      id: `proj-${Date.now()}`,
      code: body.code || `LV-${Math.floor(100 + Math.random() * 900)}`,
      name: body.name,
      name_bn: body.name_bn || body.name,
      category: body.category || "REAL_ESTATE",
      location: body.location || "Dhaka, Bangladesh",
      location_bn: body.location_bn || "ঢাকা, বাংলাদেশ",
      description: body.description || "",
      description_bn: body.description_bn || "",
      target_fund: Number(body.target_fund),
      price_per_share: Number(body.price_per_share),
      total_shares: Number(body.total_shares || 100),
      allocated_shares: 0,
      available_shares: Number(body.total_shares || 100),
      min_shares: Number(body.min_shares || 1),
      max_shares: Number(body.max_shares || 10),
      status: body.status || "OPEN",
      projected_roi_min: Number(body.projected_roi_min || 18),
      projected_roi_max: Number(body.projected_roi_max || 24),
      milestones: [],
    };

    db.projects.push(newProject as any);

    return NextResponse.json(
      {
        success: true,
        message: "Project created successfully",
        data: newProject,
      },
      { status: 201 }
    );
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to create project", error: String(error) },
      { status: 500 }
    );
  }
}
