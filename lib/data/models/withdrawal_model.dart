enum WithdrawalType {
  dividend, // লভ্যাংশ উত্তোলন
  capitalExit, // বিনিয়োগকৃত মূলধন / শেয়ার প্রত্যাহার
}

enum WithdrawalStatus {
  pending, // পর্যালোচনার জন্য অপেক্ষমাণ
  underReview, // অডিট ও যাচাই চলছে
  processing, // ব্যাংকিং ট্রান্সফার প্রক্রিয়াধীন
  completed, // পরিশোধ সম্পন্ন
  rejected, // বাতিল / প্রত্যাখ্যাত
  cancelled, // বিনিয়োগকারী কর্তৃক প্রত্যাহারকৃত
}

enum PayoutChannel {
  bankTransfer, // ব্যাংক ট্রান্সফার (BEFTN / NPSB)
  bkash, // বিকাশ
  nagad, // নগদ
  rocket, // রকেট
}

class WithdrawalModel {
  final String id;
  final String userId;
  final String userName;
  final String? projectId;
  final String? projectName;
  final String? projectNameBn;
  final String? investmentId;
  final int? sharesToLiquidate;
  final WithdrawalType type;
  final double amount;
  final double fee;
  final double netAmount;
  final PayoutChannel payoutChannel;
  final String? bankName;
  final String? accountHolderName;
  final String? accountNumber;
  final String? branchName;
  final String? routingNumber;
  final String? mfsNumber;
  final WithdrawalStatus status;
  final String? userNote;
  final String? adminFeedback;
  final String? transactionRef;
  final DateTime createdAt;
  final DateTime? processedAt;

  const WithdrawalModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.projectId,
    this.projectName,
    this.projectNameBn,
    this.investmentId,
    this.sharesToLiquidate,
    required this.type,
    required this.amount,
    this.fee = 0.0,
    required this.netAmount,
    required this.payoutChannel,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.branchName,
    this.routingNumber,
    this.mfsNumber,
    required this.status,
    this.userNote,
    this.adminFeedback,
    this.transactionRef,
    required this.createdAt,
    this.processedAt,
  });

  String get typeLabelEn => type == WithdrawalType.dividend ? 'Dividend Payout' : 'Capital Exit';
  String get typeLabelBn => type == WithdrawalType.dividend ? 'লভ্যাংশ উত্তোলন' : 'মূলধন প্রত্যাহার';

  String get channelLabelEn {
    switch (payoutChannel) {
      case PayoutChannel.bankTransfer:
        return 'Bank Transfer (BEFTN/NPSB)';
      case PayoutChannel.bkash:
        return 'bKash Wallet';
      case PayoutChannel.nagad:
        return 'Nagad Wallet';
      case PayoutChannel.rocket:
        return 'Rocket Wallet';
    }
  }

  String get channelLabelBn {
    switch (payoutChannel) {
      case PayoutChannel.bankTransfer:
        return 'ব্যাংক ট্রান্সফার (EFT/NPSB)';
      case PayoutChannel.bkash:
        return 'বিকাশ ওয়ালেট';
      case PayoutChannel.nagad:
        return 'নগদ ওয়ালেট';
      case PayoutChannel.rocket:
        return 'রকেট ওয়ালেট';
    }
  }

  String get destinationSummary {
    if (payoutChannel == PayoutChannel.bankTransfer) {
      return '${bankName ?? "Bank"} (A/C: ${accountNumber ?? "***"})';
    }
    return '$channelLabelEn (${mfsNumber ?? "***"})';
  }

  WithdrawalModel copyWith({
    WithdrawalStatus? status,
    String? adminFeedback,
    String? transactionRef,
    DateTime? processedAt,
  }) {
    return WithdrawalModel(
      id: id,
      userId: userId,
      userName: userName,
      projectId: projectId,
      projectName: projectName,
      projectNameBn: projectNameBn,
      investmentId: investmentId,
      sharesToLiquidate: sharesToLiquidate,
      type: type,
      amount: amount,
      fee: fee,
      netAmount: netAmount,
      payoutChannel: payoutChannel,
      bankName: bankName,
      accountHolderName: accountHolderName,
      accountNumber: accountNumber,
      branchName: branchName,
      routingNumber: routingNumber,
      mfsNumber: mfsNumber,
      status: status ?? this.status,
      userNote: userNote,
      adminFeedback: adminFeedback ?? this.adminFeedback,
      transactionRef: transactionRef ?? this.transactionRef,
      createdAt: createdAt,
      processedAt: processedAt ?? this.processedAt,
    );
  }

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) {
    final rawType = (json['type'] as String?)?.toUpperCase() ?? 'DIVIDEND';
    final type = rawType == 'CAPITAL_EXIT' ? WithdrawalType.capitalExit : WithdrawalType.dividend;

    final rawChannel = (json['payoutChannel'] as String?)?.toUpperCase() ?? 'BANK_TRANSFER';
    PayoutChannel channel = PayoutChannel.bankTransfer;
    if (rawChannel == 'BKASH') {
      channel = PayoutChannel.bkash;
    } else if (rawChannel == 'NAGAD') {
      channel = PayoutChannel.nagad;
    } else if (rawChannel == 'ROCKET') {
      channel = PayoutChannel.rocket;
    }

    final rawStatus = (json['status'] as String?)?.toUpperCase() ?? 'PENDING';
    WithdrawalStatus status = WithdrawalStatus.pending;
    if (rawStatus == 'UNDER_REVIEW') {
      status = WithdrawalStatus.underReview;
    } else if (rawStatus == 'PROCESSING') {
      status = WithdrawalStatus.processing;
    } else if (rawStatus == 'COMPLETED') {
      status = WithdrawalStatus.completed;
    } else if (rawStatus == 'REJECTED') {
      status = WithdrawalStatus.rejected;
    } else if (rawStatus == 'CANCELLED') {
      status = WithdrawalStatus.cancelled;
    }

    return WithdrawalModel(
      id: json['id']?.toString() ?? 'wth-${DateTime.now().millisecondsSinceEpoch}',
      userId: json['userId']?.toString() ?? 'usr-inv-001',
      userName: json['userName']?.toString() ?? 'Investor',
      projectId: json['projectId']?.toString(),
      projectName: json['projectName']?.toString(),
      projectNameBn: json['projectNameBn']?.toString(),
      investmentId: json['investmentId']?.toString(),
      sharesToLiquidate: (json['sharesToLiquidate'] as num?)?.toInt(),
      type: type,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      netAmount: (json['netAmount'] as num?)?.toDouble() ?? (json['amount'] as num?)?.toDouble() ?? 0.0,
      payoutChannel: channel,
      bankName: json['bankName']?.toString(),
      accountHolderName: json['accountHolderName']?.toString(),
      accountNumber: json['accountNumber']?.toString(),
      branchName: json['branchName']?.toString(),
      routingNumber: json['routingNumber']?.toString(),
      mfsNumber: json['mfsNumber']?.toString(),
      status: status,
      userNote: json['userNote']?.toString(),
      adminFeedback: json['adminFeedback']?.toString(),
      transactionRef: json['transactionRef']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      processedAt: json['processedAt'] != null
          ? DateTime.tryParse(json['processedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    String typeStr = type == WithdrawalType.capitalExit ? 'CAPITAL_EXIT' : 'DIVIDEND';
    String channelStr = 'BANK_TRANSFER';
    switch (payoutChannel) {
      case PayoutChannel.bankTransfer:
        channelStr = 'BANK_TRANSFER';
        break;
      case PayoutChannel.bkash:
        channelStr = 'BKASH';
        break;
      case PayoutChannel.nagad:
        channelStr = 'NAGAD';
        break;
      case PayoutChannel.rocket:
        channelStr = 'ROCKET';
        break;
    }

    String statusStr = 'PENDING';
    switch (status) {
      case WithdrawalStatus.pending:
        statusStr = 'PENDING';
        break;
      case WithdrawalStatus.underReview:
        statusStr = 'UNDER_REVIEW';
        break;
      case WithdrawalStatus.processing:
        statusStr = 'PROCESSING';
        break;
      case WithdrawalStatus.completed:
        statusStr = 'COMPLETED';
        break;
      case WithdrawalStatus.rejected:
        statusStr = 'REJECTED';
        break;
      case WithdrawalStatus.cancelled:
        statusStr = 'CANCELLED';
        break;
    }

    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'projectId': projectId,
      'projectName': projectName,
      'projectNameBn': projectNameBn,
      'investmentId': investmentId,
      'sharesToLiquidate': sharesToLiquidate,
      'type': typeStr,
      'amount': amount,
      'fee': fee,
      'netAmount': netAmount,
      'payoutChannel': channelStr,
      'bankName': bankName,
      'accountHolderName': accountHolderName,
      'accountNumber': accountNumber,
      'branchName': branchName,
      'routingNumber': routingNumber,
      'mfsNumber': mfsNumber,
      'status': statusStr,
      'userNote': userNote,
      'adminFeedback': adminFeedback,
      'transactionRef': transactionRef,
      'createdAt': createdAt.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
    };
  }
}
