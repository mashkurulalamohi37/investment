export interface StandardResponse<T> {
  success: boolean;
  data: T;
  error?: {
    code: string;
    message: string;
    details?: Record<string, any>;
  };
  meta: {
    timestamp: string;
    request_id?: string;
    process_time_ms?: number;
  };
}

export type UserRole = "SUPER_ADMIN" | "PROJECT_MANAGER" | "FINANCE_MANAGER" | "COMPLIANCE" | "SUPPORT" | "INVESTOR";

export interface User {
  id: string;
  public_id: string;
  full_name: string;
  phone: string;
  email?: string;
  role: UserRole;
  is_active: boolean;
  is_kyc_verified: boolean;
  avatar_url?: string;
  preferred_language: string;
}

export interface TokenResponse {
  access_token: string;
  refresh_token: string;
  token_type: string;
  expires_in: number;
  user: User;
}

export interface ProjectMilestone {
  id: string;
  title: string;
  title_bn: string;
  description: string;
  milestone_date: string;
  is_completed: boolean;
  sequence: number;
}

export interface Project {
  id: string;
  code: string;
  name: string;
  name_bn: string;
  category: "REAL_ESTATE" | "AGRICULTURAL" | "COMMERCIAL";
  location: string;
  location_bn: string;
  description: string;
  description_bn: string;
  target_fund: number | string;
  price_per_share: number | string;
  total_shares: number;
  allocated_shares: number;
  available_shares: number;
  min_shares: number;
  max_shares: number;
  status: "DRAFT" | "UPCOMING" | "OPEN" | "FUNDING" | "FUNDED" | "IN_PROGRESS" | "COMPLETED" | "CLOSED";
  image_url?: string;
  projected_roi_min: number | string;
  projected_roi_max: number | string;
  milestones: ProjectMilestone[];
}

export interface Investment {
  id: string;
  investment_no: string;
  user_id: string;
  project_id: string;
  shares: number;
  unit_price: number | string;
  gross_amount: number | string;
  fees: number | string;
  net_amount: number | string;
  status: "DRAFT" | "PENDING_PAYMENT" | "PAYMENT_SUBMITTED" | "UNDER_VERIFICATION" | "APPROVED" | "ALLOCATED" | "CANCELLED" | "REJECTED" | "REFUNDED";
  allocated_lot_numbers?: string;
  payment_method?: string;
  payment_reference?: string;
  payment_gateway?: "EPS" | "MANUAL_BANK";
  receipt_image_url?: string;
  deposit_bank_name?: string;
  depositor_name?: string;
  created_at: string;
  verified_at?: string;
}

export interface EpsSessionResponse {
  is_success: boolean;
  eps_transaction_id: string;
  merchant_transaction_id: string;
  amount: number | string;
  redirect_url?: string;
  message: string;
}

export interface DocumentItem {
  id: string;
  project_id?: string;
  title: string;
  title_bn: string;
  category: "LEGAL" | "DEED" | "MUTATION" | "FINANCIAL" | "REPORT" | "RECEIPT" | "CERTIFICATE";
  visibility: "PUBLIC" | "INVESTOR_ONLY" | "ADMIN_ONLY";
  file_name: string;
  file_size_human: string;
  checksum_sha256: string;
  version: string;
  uploaded_by: string;
  created_at: string;
}

export interface KycProfile {
  id: string;
  user_id: string;
  full_name: string;
  nid_number: string;
  father_name: string;
  mother_name: string;
  present_address: string;
  bank_name: string;
  bank_account_number: string;
  routing_number: string;
  branch_name: string;
  status: "NOT_STARTED" | "DRAFT" | "SUBMITTED" | "UNDER_REVIEW" | "VERIFIED" | "REJECTED";
  face_liveness_score?: number;
  verified_at?: string;
}

export interface ExpenseVoucher {
  id: string;
  voucher_no: string;
  project_id: string;
  category: string;
  title: string;
  description: string;
  payee_name: string;
  amount: number | string;
  status: string;
  receipt_url?: string;
  expense_date: string;
  audited_by?: string;
}

export interface DistributionItem {
  id: string;
  period_title: string;
  period_title_bn: string;
  eligible_shares: number;
  gross_payout: number | string;
  net_payout: number | string;
  status: string;
  payment_method: string;
  paid_at?: string;
}
