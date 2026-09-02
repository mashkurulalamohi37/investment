/// EPS (Easy Payment System) Payment Gateway Service
/// Bangladesh Bank Licensed PSO (Payment System Operator) Integration
class EpsGatewayConfig {
  /// EPS Merchant / Client ID provided by EPS
  final String merchantId;

  /// EPS Store ID / App ID
  final String storeId;

  /// EPS Merchant Secret Key / Secret Hash
  final String appSecret;

  /// Mode: true for Sandbox testing, false for Live Production
  final bool isSandbox;

  /// Endpoint URLs
  final String sandboxBaseUrl;
  final String liveBaseUrl;

  const EpsGatewayConfig({
    this.merchantId = 'EPS_MERCHANT_SWAPNOJATRI_01',
    this.storeId = 'STORE_SWAPNOJATRI_MAIN',
    this.appSecret = 'eps_sec_k98a21f7e02b8429910d',
    this.isSandbox = true,
    this.sandboxBaseUrl = 'https://sandbox.epay.com.bd/api/v1',
    this.liveBaseUrl = 'https://api.epay.com.bd/api/v1',
  });

  String get activeBaseUrl => isSandbox ? sandboxBaseUrl : liveBaseUrl;
}

class EpsPaymentSessionRequest {
  final String merchantTransactionId;
  final double amount;
  final String currency;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String projectTitle;
  final int shareCount;
  final String callbackUrl;

  const EpsPaymentSessionRequest({
    required this.merchantTransactionId,
    required this.amount,
    this.currency = 'BDT',
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.projectTitle,
    required this.shareCount,
    this.callbackUrl = 'https://swapnojatri.com/api/payment/eps-callback',
  });
}

class EpsPaymentResponse {
  final bool isSuccess;
  final String epsTransactionId;
  final String merchantTransactionId;
  final double amount;
  final String paymentChannel; // 'bKash', 'Nagad', 'Rocket', 'VISA', 'Mastercard', 'InternetBanking'
  final String message;
  final DateTime timestamp;

  const EpsPaymentResponse({
    required this.isSuccess,
    required this.epsTransactionId,
    required this.merchantTransactionId,
    required this.amount,
    required this.paymentChannel,
    required this.message,
    required this.timestamp,
  });
}

class EpsPaymentService {
  final EpsGatewayConfig config;

  EpsPaymentService({this.config = const EpsGatewayConfig()});

  /// Generate a unique transaction reference for EPS
  static String generateTxnId() {
    return 'EPS-TXN-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Initialize an EPS checkout session
  Future<EpsPaymentResponse> processEpsCheckout({
    required EpsPaymentSessionRequest request,
    required String selectedChannel,
  }) async {
    // Simulate gateway network roundtrip & IPN verification
    await Future.delayed(const Duration(milliseconds: 1400));

    final epsTxnId = 'EPS-${DateTime.now().millisecondsSinceEpoch.toString().substring(3)}';

    return EpsPaymentResponse(
      isSuccess: true,
      epsTransactionId: epsTxnId,
      merchantTransactionId: request.merchantTransactionId,
      amount: request.amount,
      paymentChannel: selectedChannel,
      message: 'Transaction verified and settled via EPS Gateway.',
      timestamp: DateTime.now(),
    );
  }
}
