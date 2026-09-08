import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";
import { MasterCmsState } from "@/types/cms";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const section = searchParams.get("section") as keyof MasterCmsState | null;

    if (section && db.masterCms[section]) {
      return NextResponse.json({
        success: true,
        section,
        data: db.masterCms[section],
        updatedAt: db.masterCms.updatedAt,
      });
    }

    return NextResponse.json({
      success: true,
      data: db.masterCms,
      updatedAt: db.masterCms.updatedAt,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to fetch Master CMS data", error: String(error) },
      { status: 500 }
    );
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    // Check for factory reset action
    if (body.action === "reset") {
      const resetData = db.resetMasterCms();
      return NextResponse.json({
        success: true,
        message: "Master CMS reset to factory defaults successfully",
        data: resetData,
      });
    }

    // Section-specific update
    if (body.section && body.data) {
      const sectionKey = body.section as keyof MasterCmsState;
      const updated = db.updateMasterCms({
        [sectionKey]: body.data,
      });

      return NextResponse.json({
        success: true,
        message: `CMS Section '${body.section}' updated successfully`,
        data: updated,
      });
    }

    // Full Master CMS update
    const incomingData = body.data || body;
    if (!incomingData || typeof incomingData !== "object") {
      return NextResponse.json(
        { success: false, message: "Invalid CMS payload structure" },
        { status: 400 }
      );
    }

    const updated = db.updateMasterCms(incomingData);

    return NextResponse.json({
      success: true,
      message: "Master CMS updated and published successfully",
      data: updated,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Failed to update CMS data", error: String(error) },
      { status: 500 }
    );
  }
}
