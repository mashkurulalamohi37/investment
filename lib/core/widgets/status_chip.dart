import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/data/models/investment_model.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/models/distribution_model.dart';
import 'package:swapnojatri/data/models/kyc_model.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color bgColor;
  final IconData? icon;

  const StatusChip({
    super.key,
    required this.label,
    required this.textColor,
    required this.bgColor,
    this.icon,
  });

  factory StatusChip.investment(InvestmentStatus status, {bool isBangla = false}) {
    switch (status) {
      case InvestmentStatus.allocated:
        return StatusChip(
          label: isBangla ? 'বরাদ্দকৃত' : 'Allocated',
          textColor: AppColors.successDark,
          bgColor: AppColors.successLight,
          icon: Icons.check_circle_outline_rounded,
        );
      case InvestmentStatus.verified:
        return StatusChip(
          label: isBangla ? 'যাচাইকৃত' : 'Verified',
          textColor: AppColors.infoDark,
          bgColor: AppColors.infoLight,
          icon: Icons.verified_outlined,
        );
      case InvestmentStatus.pending:
        return StatusChip(
          label: isBangla ? 'যাচাই প্রক্রিয়াধীন' : 'Pending Review',
          textColor: AppColors.warningDark,
          bgColor: AppColors.warningLight,
          icon: Icons.hourglass_top_rounded,
        );
      case InvestmentStatus.refunded:
        return StatusChip(
          label: isBangla ? 'রিফান্ডকৃত' : 'Refunded',
          textColor: AppColors.errorDark,
          bgColor: AppColors.errorLight,
          icon: Icons.replay_rounded,
        );
      case InvestmentStatus.cancelled:
        return StatusChip(
          label: isBangla ? 'বাতিল' : 'Cancelled',
          textColor: AppColors.errorDark,
          bgColor: AppColors.errorLight,
          icon: Icons.cancel_outlined,
        );
    }
  }

  factory StatusChip.project(ProjectStatus status, {bool isBangla = false}) {
    switch (status) {
      case ProjectStatus.active:
        return StatusChip(
          label: isBangla ? 'চলমান বিনিয়োগ' : 'Live Opportunity',
          textColor: AppColors.successDark,
          bgColor: AppColors.successLight,
          icon: Icons.fiber_manual_record_rounded,
        );
      case ProjectStatus.funded:
        return StatusChip(
          label: isBangla ? 'তহবিল সম্পন্ন' : 'Fully Funded',
          textColor: AppColors.infoDark,
          bgColor: AppColors.infoLight,
          icon: Icons.lock_outline_rounded,
        );
      case ProjectStatus.completed:
        return StatusChip(
          label: isBangla ? 'সম্পন্ন' : 'Completed',
          textColor: AppColors.accentGoldDark,
          bgColor: AppColors.accentGoldMuted,
          icon: Icons.stars_rounded,
        );
      case ProjectStatus.closed:
        return StatusChip(
          label: isBangla ? 'বন্ধ' : 'Closed',
          textColor: AppColors.errorDark,
          bgColor: AppColors.errorLight,
        );
      case ProjectStatus.draft:
        return StatusChip(
          label: isBangla ? 'খসড়া' : 'Draft',
          textColor: AppColors.warningDark,
          bgColor: AppColors.warningLight,
        );
    }
  }

  factory StatusChip.distribution(DistributionStatus status, {bool isBangla = false}) {
    switch (status) {
      case DistributionStatus.paid:
        return StatusChip(
          label: isBangla ? 'বিতরণ সম্পন্ন' : 'Paid',
          textColor: AppColors.successDark,
          bgColor: AppColors.successLight,
          icon: Icons.check_circle_rounded,
        );
      case DistributionStatus.approved:
        return StatusChip(
          label: isBangla ? 'অনুমোদিত' : 'Approved',
          textColor: AppColors.infoDark,
          bgColor: AppColors.infoLight,
          icon: Icons.task_alt_rounded,
        );
      case DistributionStatus.processing:
        return StatusChip(
          label: isBangla ? 'প্রক্রিয়াধীন' : 'Processing',
          textColor: AppColors.warningDark,
          bgColor: AppColors.warningLight,
          icon: Icons.sync_rounded,
        );
      case DistributionStatus.draft:
        return StatusChip(
          label: isBangla ? 'খসড়া' : 'Draft',
          textColor: const Color(0xFF475569),
          bgColor: const Color(0xFFF1F5F9),
        );
      case DistributionStatus.failed:
        return StatusChip(
          label: isBangla ? 'ব্যর্থ' : 'Failed',
          textColor: AppColors.errorDark,
          bgColor: AppColors.errorLight,
        );
    }
  }

  factory StatusChip.kyc(KycStatus status, {bool isBangla = false}) {
    switch (status) {
      case KycStatus.verified:
        return StatusChip(
          label: isBangla ? 'যাচাইকৃত কেওয়াইসি' : 'KYC Verified',
          textColor: AppColors.successDark,
          bgColor: AppColors.successLight,
          icon: Icons.verified_rounded,
        );
      case KycStatus.underReview:
      case KycStatus.pending:
        return StatusChip(
          label: isBangla ? 'কেওয়াইসি যাচাইধীন' : 'KYC Under Review',
          textColor: AppColors.warningDark,
          bgColor: AppColors.warningLight,
          icon: Icons.hourglass_empty_rounded,
        );
      case KycStatus.rejected:
        return StatusChip(
          label: isBangla ? 'প্রত্যাখ্যাত' : 'KYC Rejected',
          textColor: AppColors.errorDark,
          bgColor: AppColors.errorLight,
          icon: Icons.error_outline_rounded,
        );
      case KycStatus.notStarted:
        return StatusChip(
          label: isBangla ? 'কেওয়াইসি বাকি' : 'KYC Pending',
          textColor: const Color(0xFF64748B),
          bgColor: const Color(0xFFF1F5F9),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBg = isDark ? bgColor.withValues(alpha: 0.18) : bgColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: AppRadius.borderFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.caption().copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}
