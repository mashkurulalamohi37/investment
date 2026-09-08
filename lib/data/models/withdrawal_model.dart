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
}
