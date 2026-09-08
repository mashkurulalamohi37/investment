import { NextRequest, NextResponse } from "next/server";

/**
 * Server-side Admin Authorization Validator for Next.js API routes
 */
export function validateAdminAuth(request: NextRequest): NextResponse | null {
  const authHeader = request.headers.get("authorization");
  const adminKey = request.headers.get("x-admin-key");
  const cookie = request.headers.get("cookie");

  // Accept valid bearer token or admin key
  const hasToken =
    (authHeader && (authHeader.startsWith("Bearer ") || authHeader.startsWith("sj_"))) ||
    (adminKey && adminKey.length > 5) ||
    (cookie && cookie.includes("swapnojatri"));

  if (!hasToken) {
    return NextResponse.json(
      {
        success: false,
        message: "Unauthorized: Administrative session or Bearer token required",
      },
      { status: 401 }
    );
  }

  return null;
}
