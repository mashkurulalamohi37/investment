import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:swapnojatri/core/constants/app_config.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/distribution_model.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';

/// Central API Service for connecting Flutter to Next.js cPanel Website Backend
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();
  final Duration _timeout = const Duration(seconds: 10);

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  /// 1. Health & Server Connectivity Check
  Future<bool> checkConnection() async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/health');
      final response = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('[ApiService] Connected to website backend: ${data['platform']} (v${data['version']})');
        return true;
      }
    } catch (e) {
      debugPrint('[ApiService] Connection check failed: $e');
    }
    return false;
  }

  /// 2. Fetch Projects List
  Future<List<ProjectModel>> getProjects() async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/projects');
      final response = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List list = decoded['data'] ?? [];
        return list.map((json) => _mapProject(json)).toList();
      }
    } catch (e) {
      debugPrint('[ApiService] Error fetching projects: $e');
    }
    return [];
  }

  /// 3. Fetch Investments for Investor
  Future<List<InvestmentModel>> getInvestments({String? investorId}) async {
    try {
      final url = investorId != null
          ? '${AppConfig.activeApiUrl}/investments?investorId=$investorId'
          : '${AppConfig.activeApiUrl}/investments';
      final response = await _client.get(Uri.parse(url), headers: _headers).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List list = decoded['data'] ?? [];
        return list.map((json) => _mapInvestment(json)).toList();
      }
    } catch (e) {
      debugPrint('[ApiService] Error fetching investments: $e');
    }
    return [];
  }

  /// 4. Fetch Dividend Distributions
  Future<List<DistributionModel>> getDistributions() async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/distributions');
      final response = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List list = decoded['data'] ?? [];
        return list.map((json) => _mapDistribution(json)).toList();
      }
    } catch (e) {
      debugPrint('[ApiService] Error fetching distributions: $e');
    }
    return [];
  }

  /// 5. Fetch Verified KYC Data
  Future<KycModel?> getKyc() async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/kyc');
      final response = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];
        if (data != null) {
          return _mapKyc(data);
        }
      }
    } catch (e) {
      debugPrint('[ApiService] Error fetching KYC: $e');
    }
    return null;
  }

  /// 6. Submit New Share Lot Investment
  Future<InvestmentModel?> createInvestment({
    required String projectId,
    required int lotUnits,
    required String paymentMethod,
    String? transactionRef,
  }) async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/investments');
      final response = await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'projectId': projectId,
              'lotUnits': lotUnits,
              'paymentMethod': paymentMethod,
              'transactionRef': transactionRef,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return _mapInvestment(decoded['data']);
      }
    } catch (e) {
      debugPrint('[ApiService] Error creating investment: $e');
    }
    return null;
  }

  /// 7. Change Password
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final uri = Uri.parse('${AppConfig.activeApiUrl}/auth/change-password');
      final response = await _client
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              'currentPassword': currentPassword,
              'newPassword': newPassword,
              'confirmPassword': confirmPassword,
            }),
          )
          .timeout(_timeout);

      final decoded = jsonDecode(response.body);
      return {
        'success': response.statusCode == 200 && decoded['success'] == true,
        'message': decoded['message'] ?? 'Password change processed',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network connection failed: $e'};
    }
  }

  // --- Mappers ---
  ProjectModel _mapProject(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 'proj-lv100',
      code: json['code'] ?? 'LV100',
      name: json['name'] ?? 'LandVest 100',
      nameBn: json['name_bn'] ?? 'ল্যান্ডভেস্ট ১০০ (ওয়াশপুর, ঢাকা)',
      category: json['category'] ?? 'REAL_ESTATE',
      projectCategory: ProjectCategory.realEstate,
      categoryNameBn: 'রিয়েল এস্টেট জমি',
      location: json['location'] ?? 'Washpur, Dhaka',
      description: json['description'] ?? '',
      descriptionBn: json['description_bn'] ?? '',
      targetFund: (json['target_fund'] as num?)?.toDouble() ?? 2550000.0,
      totalShares: (json['total_shares'] as num?)?.toInt() ?? 100,
      pricePerShare: (json['price_per_share'] as num?)?.toDouble() ?? 25500.0,
      minShares: (json['min_shares'] as num?)?.toInt() ?? 1,
      maxShares: (json['max_shares'] as num?)?.toInt() ?? 4,
      allocatedShares: (json['allocated_shares'] as num?)?.toInt() ?? 74,
      status: ProjectStatus.active,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      imageUrl: json['image_url'] ?? json['cover_image_url'] ?? 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800',
      milestones: [],
      highlights: [
        'Prime location in Washpur, Tower Road, Dhaka',
        'Direct Shariah Murabaha profit-sharing',
        'City Bank Escrow Account verified',
      ],
      trackRecords: [],
    );
  }

  InvestmentModel _mapInvestment(Map<String, dynamic> json) {
    final rawLots = json['lotNumbers'] as List? ?? ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'];
    final lotList = rawLots.map((e) => e.toString()).toList();

    return InvestmentModel(
      id: json['id'] ?? 'inv-001',
      investmentNo: json['certificateNumber'] ?? 'SJ-LV100-2026-004144',
      userId: json['investorId'] ?? 'usr-inv-001',
      projectId: json['projectId'] ?? 'proj-lv100',
      projectName: json['projectName'] ?? 'LandVest 100 (Washpur, Dhaka)',
      shares: (json['lotUnits'] as num?)?.toInt() ?? 4,
      unitPrice: 25500.0,
      grossAmount: (json['amount'] as num?)?.toDouble() ?? 102000.0,
      fees: 0.0,
      netAmount: (json['amount'] as num?)?.toDouble() ?? 102000.0,
      status: json['status'] == 'ALLOCATED'
          ? InvestmentStatus.allocated
          : InvestmentStatus.pending,
      allocatedLotNumbers: lotList,
      paymentMethod: json['paymentMethod'] ?? 'CITY_BANK_ESCROW',
      paymentReference: json['transactionRef'] ?? 'CBL-TXN-99482104',
      depositBankName: 'The City Bank Limited',
      depositorName: json['investorName'] ?? 'Tariqul Islam Chowdhury',
      paymentGateway: 'CITY_BANK_ESCROW',
      createdAt: json['subscribedAt'] != null
          ? DateTime.tryParse(json['subscribedAt']) ?? DateTime.now()
          : DateTime.now(),
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
    );
  }

  DistributionModel _mapDistribution(Map<String, dynamic> json) {
    return DistributionModel(
      id: json['id'] ?? 'dist-001',
      profitPeriodId: 'pp-2026',
      periodName: json['period'] ?? 'Q2 2026 Profit Settlement',
      projectId: 'proj-lv100',
      projectName: 'LandVest 100',
      userId: 'usr-inv-001',
      investmentId: 'inv-001',
      eligibleShares: (json['eligibleLots'] as num?)?.toInt() ?? 4,
      amount: (json['amount'] as num?)?.toDouble() ?? 8500.0,
      status: json['status'] == 'PAID'
          ? DistributionStatus.paid
          : DistributionStatus.processing,
      paidAt: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      paymentReference: json['transactionId'] ?? 'EFT-88492041',
      bankMfsAccount: json['paymentChannel'] ?? 'City Bank Escrow (Direct EFT)',
    );
  }

  KycModel _mapKyc(Map<String, dynamic> json) {
    return KycModel(
      id: 'kyc-001',
      userId: json['investorId'] ?? 'usr-inv-001',
      fullName: json['fullName'] ?? 'Tariqul Islam Chowdhury',
      fatherName: json['fatherHusbandName'] ?? 'Md. Rafiqul Islam Chowdhury',
      motherName: json['motherName'] ?? 'Sultana Begum',
      nidNumber: json['nidPassportNumber'] ?? '19882694019284716',
      dateOfBirth: '1988-04-12',
      presentAddress: json['presentAddress'] ?? 'House 42, Road 11, Sector 4, Uttara, Dhaka',
      permanentAddress: json['permanentAddress'] ?? 'Chandpur, Bangladesh',
      bankName: json['bankName'] ?? 'The City Bank Limited',
      bankAccountNumber: json['bankAccountNo'] ?? '1102948192001',
      routingNumber: json['bankRoutingNo'] ?? '225275394',
      status: json['isVerified'] == true ? KycStatus.verified : KycStatus.pending,
      verifiedAt: json['verifiedAt'] != null ? DateTime.tryParse(json['verifiedAt']) : null,
      nominee: json['nomineeName'] != null
          ? NomineeModel(
              name: json['nomineeName'],
              relationship: json['nomineeRelation'] ?? 'Spouse',
              phone: json['nomineePhone'] ?? '',
              nidNumber: json['nomineeNid'] ?? '',
              percentage: (json['nomineeSharePercentage'] as num?)?.toDouble() ?? 100.0,
            )
          : null,
    );
  }
}
