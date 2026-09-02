import asyncio
from datetime import datetime, timezone, timedelta
from decimal import Decimal
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from app.core.config import settings
from app.core.permissions import UserRole
from app.core.security import get_password_hash
from app.models import (
    Base,
    User,
    Project,
    ProjectMilestone,
    ProjectStatus,
    ProjectCategory,
    Investment,
    InvestmentStatus,
    Payment,
    PaymentStatus,
    PaymentGatewayType,
    Transaction,
    TransactionType,
    TransactionDirection,
    TransactionStatus,
    LedgerEntry,
    Expense,
    ExpenseCategory,
    ExpenseStatus,
    Asset,
    KycProfile,
    KycStatus,
    Nominee,
    Document,
    DocumentCategory,
    DocumentVisibility,
    AuditLog,
)
from app.utils.id_generator import generate_public_id


async def seed():
    engine = create_async_engine(settings.DATABASE_URL, echo=True)
    async_session = async_sessionmaker(engine, expire_on_commit=False)

    print("🌱 Connecting to database and creating schema tables...")
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    async with async_session() as db:
        # 1. Super Admin
        admin_pwd = get_password_hash("Admin@2026!Swapno")
        admin = User(
            public_id=generate_public_id("usr"),
            full_name="Tanvir Ahmed",
            phone="+8801819998877",
            email="tanvir.admin@swapnojatri.com",
            password_hash=admin_pwd,
            role=UserRole.SUPER_ADMIN,
            is_active=True,
            is_kyc_verified=True,
            is_phone_verified=True,
            preferred_language="bn",
        )

        # 2. Finance Manager
        finance = User(
            public_id=generate_public_id("usr"),
            full_name="Rahim Uddin",
            phone="+8801912345678",
            email="finance@swapnojatri.com",
            password_hash=admin_pwd,
            role=UserRole.FINANCE_MANAGER,
            is_active=True,
            is_kyc_verified=True,
            is_phone_verified=True,
            preferred_language="bn",
        )

        # 3. Default Investor (Mashkurul Alam Ohi)
        investor_pwd = get_password_hash("Investor@2026!")
        investor = User(
            public_id=generate_public_id("usr"),
            full_name="Mashkurul Alam Ohi",
            phone="+8801712345678",
            email="mashkurul.ohi@swapnojatri.com",
            password_hash=investor_pwd,
            role=UserRole.INVESTOR,
            is_active=True,
            is_kyc_verified=True,
            is_phone_verified=True,
            preferred_language="bn",
        )

        db.add_all([admin, finance, investor])
        await db.flush()

        # 4. LandVest 100 Project
        lv100 = Project(
            code="LV100",
            name="LandVest 100 (Washpur, Savar)",
            name_bn="ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, সাভার)",
            category=ProjectCategory.REAL_ESTATE,
            location="Washpur Tower Road, Hemayetpur, Savar, Dhaka",
            location_bn="ওয়াশপুর টাওয়ার রোড, হেমায়েতপুর, সাভার, ঢাকা",
            description="Prime 22.5 Decimals commercial land with clear deed sub-registry #4982/2026. Target fund ৳25,50,000 divided into 100 fixed shares of ৳25,500 each.",
            description_bn="সাভার হেমায়েতপুর সংলগ্ন ২২.৫ শতাংশ নিষ্কণ্টক জমি প্রকল্প। ১০০টি নির্ধারিত শেয়ারে মোট তহবিল ২৫,৫০,০০০ টাকা। প্রতি শেয়ার ২৫,৫০০ টাকা।",
            target_fund=Decimal("2550000.00"),
            price_per_share=Decimal("25500.00"),
            total_shares=100,
            allocated_shares=74,
            reserved_shares=0,
            min_shares=1,
            max_shares=4,
            status=ProjectStatus.OPEN,
            projected_roi_min=Decimal("18.50"),
            projected_roi_max=Decimal("22.00"),
            start_date=datetime.now(timezone.utc) - timedelta(days=60),
            target_end_date=datetime.now(timezone.utc) + timedelta(days=300),
        )
        db.add(lv100)
        await db.flush()

        # Milestones
        m1 = ProjectMilestone(
            project_id=lv100.id,
            title="Site Selection & Legal Vetting",
            title_bn="জমি নির্বাচন ও আইনি যাচাই",
            description="Complete title vetting by Senior Supreme Court Advocate",
            milestone_date=datetime.now(timezone.utc) - timedelta(days=50),
            is_completed=True,
            sequence=1,
        )
        m2 = ProjectMilestone(
            project_id=lv100.id,
            title="LandVest 100 Subscription Launch",
            title_bn="তহবিল সংগ্রহ শুরু (১০০ শেয়ার)",
            description="Official opening of LandVest 100 subscription at ৳25,500/share",
            milestone_date=datetime.now(timezone.utc) - timedelta(days=30),
            is_completed=True,
            sequence=2,
        )
        db.add_all([m1, m2])

        # 5. Seed Investments for Mashkurul
        inv1 = Investment(
            investment_no="SJ-LV100-0042",
            user_id=investor.id,
            project_id=lv100.id,
            shares=4,
            unit_price=Decimal("25500.00"),
            gross_amount=Decimal("102000.00"),
            net_amount=Decimal("102000.00"),
            status=InvestmentStatus.ALLOCATED,
            allocated_lot_numbers="LOT-041, LOT-042, LOT-043, LOT-044",
            payment_method="EPS (bKash)",
            payment_reference="EPS-TXN-9820194",
            payment_gateway="EPS",
            verified_at=datetime.now(timezone.utc) - timedelta(days=15),
        )
        # Pending Bank Deposit Investment
        inv2 = Investment(
            investment_no="SJ-LV100-0043",
            user_id=investor.id,
            project_id=lv100.id,
            shares=2,
            unit_price=Decimal("25500.00"),
            gross_amount=Decimal("51000.00"),
            net_amount=Decimal("51000.00"),
            status=InvestmentStatus.UNDER_VERIFICATION,
            payment_method="Bank Deposit (City Bank PLC)",
            payment_reference="DEP-CB-9821408",
            payment_gateway="MANUAL_BANK",
            deposit_bank_name="City Bank PLC",
            depositor_name="Mashkurul Alam Ohi",
            receipt_image_url="bank_deposit_slip_sample.jpg",
        )
        db.add_all([inv1, inv2])
        await db.flush()

        # 6. KYC Profile for Investor
        kyc = KycProfile(
            user_id=investor.id,
            full_name="Mashkurul Alam Ohi",
            nid_number="1992269482910394",
            father_name="Rafiqul Alam",
            mother_name="Shirin Akter",
            present_address="House 12, Road 4, Gulshan-1, Dhaka",
            bank_name="The City Bank PLC",
            bank_account_number="1402998877101",
            routing_number="225275357",
            branch_name="Gulshan Branch",
            status=KycStatus.VERIFIED,
            face_liveness_score=99.4,
            verified_at=datetime.now(timezone.utc) - timedelta(days=40),
        )
        nominee = Nominee(
            user_id=investor.id,
            name="Fatema Begum",
            relationship_to_investor="Spouse",
            nid_number="1995269482998811",
            share_percentage=100,
        )
        db.add_all([kyc, nominee])

        # 7. Audited Expense Voucher
        exp1 = Expense(
            voucher_no="VCH-LV100-001",
            project_id=lv100.id,
            category=ExpenseCategory.LEGAL_REGISTRATION,
            title="Sub-Registry Registration & Stamp Duty",
            description="Govt sub-registry fees and stamp duty for Deed #4982/2026",
            payee_name="Savar Sub-Registry Office",
            amount=Decimal("450000.00"),
            status=ExpenseStatus.APPROVED,
            expense_date=datetime.now(timezone.utc) - timedelta(days=20),
            audited_by="Audit & Inspection Directorate",
        )
        db.add(exp1)

        # 8. Document Vault
        doc1 = Document(
            project_id=lv100.id,
            title="Sub-Registry Title Deed #4982/2026",
            title_bn="সাব-রেজিস্ট্রি মূল দলিল #৪৯৮২/২০২৬",
            category=DocumentCategory.DEED,
            visibility=DocumentVisibility.PUBLIC,
            file_name="Title_Deed_LV100_4982.pdf",
            file_size_human="4.8 MB",
            s3_key="documents/lv100/Title_Deed_LV100_4982.pdf",
            checksum_sha256="7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d",
            version="v1.0 (Vetted)",
            uploaded_by="Land Legal Advisory Team",
        )
        db.add(doc1)

        await db.commit()
        print("✅ Database successfully seeded with LandVest 100, Admin, and Investor accounts!")

    await engine.dispose()


if __name__ == "__main__":
    asyncio.run(seed())
