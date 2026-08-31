import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';

enum StatusType {
  pending,
  verified,
  allocated,
  rejected,
  paid,
  escrowed,
  kycIncomplete,
  closed,
}

class StatusChip extends StatelessWidget {
  final StatusType? statusType;
  final String? rawStatus;
  final bool isBangla;

  const StatusChip({
    super.key,
    this.statusType,
    this.rawStatus,
    this.isBangla = false,
  });

  factory StatusChip.kyc(dynamic status, {bool isBangla = false}) =>
      StatusChip(rawStatus: status.toString(), isBangla: isBangla);

  factory StatusChip.distribution(dynamic status, {bool isBangla = false}) =>
      StatusChip(rawStatus: status.toString(), isBangla: isBangla);

  factory StatusChip.project(dynamic status, {bool isBangla = false}) =>
      StatusChip(rawStatus: status.toString(), isBangla: isBangla);

  factory StatusChip.investment(dynamic status, {bool isBangla = false}) =>
      StatusChip(rawStatus: status.toString(), isBangla: isBangla);

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final resolved = _resolveStatus();
    final color = _getColor(resolved, palette);
    final label = _getLabel(resolved, isBangla);

    return Container(
      constraints: const BoxConstraints(minHeight: 22),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppRadius.borderChip,
        border: Border.all(color: color, width: 1.0),
      ),
      child: Text(
        label,
        style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
          height: 1.2,
        ),
      ),
    );
  }

  StatusType _resolveStatus() {
    if (statusType != null) return statusType!;
    final s = (rawStatus ?? '').toLowerCase().trim();
    if (s.contains('pending') || s.contains('under_review') || s.contains('অপেক্ষমাণ')) {
      return StatusType.pending;
    } else if (s.contains('verified') || s.contains('approved') || s.contains('যাচাইকৃত')) {
      return StatusType.verified;
    } else if (s.contains('allocated') || s.contains('বরাদ্দ')) {
      return StatusType.allocated;
    } else if (s.contains('rejected') || s.contains('প্রত্যাখ্যাত')) {
      return StatusType.rejected;
    } else if (s.contains('paid') || s.contains('পরিশোধিত')) {
      return StatusType.paid;
    } else if (s.contains('escrow') || s.contains('এসক্রো')) {
      return StatusType.escrowed;
    } else if (s.contains('kyc') || s.contains('unverified')) {
      return StatusType.kycIncomplete;
    }
    return StatusType.closed;
  }

  Color _getColor(StatusType type, AppPalette palette) {
    switch (type) {
      case StatusType.pending:
      case StatusType.kycIncomplete:
        return palette.amberInk;
      case StatusType.verified:
      case StatusType.paid:
        return palette.jade;
      case StatusType.allocated:
        return palette.pine;
      case StatusType.rejected:
        return palette.vermilion;
      case StatusType.escrowed:
        return palette.slate;
      case StatusType.closed:
        return palette.inkTertiary;
    }
  }

  String _getLabel(StatusType type, bool isBangla) {
    switch (type) {
      case StatusType.pending:
        return isBangla ? 'যাচাই অপেক্ষমাণ' : 'Pending verification';
      case StatusType.verified:
        return isBangla ? 'যাচাইকৃত' : 'Verified';
      case StatusType.allocated:
        return isBangla ? 'বরাদ্দকৃত' : 'Allocated';
      case StatusType.rejected:
        return isBangla ? 'প্রত্যাখ্যাত' : 'Rejected';
      case StatusType.paid:
        return isBangla ? 'পরিশোধিত' : 'Paid';
      case StatusType.escrowed:
        return isBangla ? 'এসক্রোতে' : 'Escrowed';
      case StatusType.kycIncomplete:
        return isBangla ? 'কেওয়াইসি অসম্পূর্ণ' : 'KYC incomplete';
      case StatusType.closed:
        return isBangla ? 'সমাপ্ত' : 'Closed';
    }
  }
}
