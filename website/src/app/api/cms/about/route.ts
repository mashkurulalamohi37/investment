import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";
import { AboutPageCmsConfig, DEFAULT_ABOUT_CMS } from "@/types/cms";

export async function GET() {
  try {
    if (!db.aboutCms) {
      db.aboutCms = { ...DEFAULT_ABOUT_CMS };
    }
    return NextResponse.json({
      success: true,
      data: db.aboutCms,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch About page CMS", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const config = (body.data || body) as AboutPageCmsConfig;

    if (!config || !config.heroImage || !config.storyImages) {
      return NextResponse.json(
        { success: false, message: "Invalid About CMS payload structure" },
        { status: 400 }
      );
    }

    db.aboutCms = {
      ...config,
      updatedAt: new Date().toISOString(),
    };

    return NextResponse.json({
      success: true,
      message: "About page CMS updated successfully",
      data: db.aboutCms,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to update About page CMS", error: String(error) },
      { status: 500 }
    );
  }
}
