import { NextRequest, NextResponse } from "next/server";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { phoneOrEmail, password, role } = body;

    if (!phoneOrEmail || !password) {
      return NextResponse.json(
        { success: false, message: "Identifier and password required" },
        { status: 400 }
      );
    }

    // Role-based mock authentication response with session token
    const isAdmin = role === "ADMIN" || phoneOrEmail.includes("admin");
    const user = {
      id: isAdmin ? "usr-admin-001" : "usr-inv-001",
      name: isAdmin ? "Executive Board Director" : "Tariqul Islam Chowdhury",
      email: isAdmin ? "admin@swapnojatri.com" : "tariqul.islam@example.com",
      phone: isAdmin ? "+880 1700-000000" : "+880 1711-000000",
      role: isAdmin ? "ADMIN" : "INVESTOR",
      token: `sj_auth_jwt_${Date.now()}_secure_session`,
    };

    return NextResponse.json({
      success: true,
      message: "Authentication successful",
      data: user,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Authentication failed", error: String(error) },
      { status: 500 }
    );
  }
}
