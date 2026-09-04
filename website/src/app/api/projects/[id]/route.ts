import { NextRequest, NextResponse } from "next/server";
import { db } from "@/lib/server/db";

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { id } = params;
    const project = db.projects.find(
      (p) => p.id.toLowerCase() === id.toLowerCase() || p.code.toLowerCase() === id.toLowerCase()
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
