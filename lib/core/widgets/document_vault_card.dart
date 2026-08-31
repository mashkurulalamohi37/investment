import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/document_model.dart';

class DocumentVaultCard extends StatelessWidget {
  final DocumentModel document;
  final bool isBangla;
  final VoidCallback onDownload;
  final VoidCallback? onPreview;

  const DocumentVaultCard({
    super.key,
    required this.document,
    required this.isBangla,
    required this.onDownload,
    this.onPreview,
  });

  IconData _getIconForCategory(DocumentCategory cat) {
    switch (cat) {
      case DocumentCategory.projectDeed:
        return Icons.gavel_rounded;
      case DocumentCategory.legal:
        return Icons.verified_user_rounded;
      case DocumentCategory.govtApproval:
        return Icons.apartment_rounded;
      case DocumentCategory.receipt:
        return Icons.receipt_rounded;
      case DocumentCategory.taxCertificate:
        return Icons.account_balance_rounded;
      case DocumentCategory.financialAudit:
        return Icons.analytics_rounded;
      case DocumentCategory.distributionStatement:
        return Icons.payments_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icon = _getIconForCategory(document.category);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.12),
                  borderRadius: AppRadius.borderMd,
                ),
                child: Icon(icon, color: isDark ? AppColors.accentGold : AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),

              // Title & Version
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBangla ? document.titleBn : document.title,
                      style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          document.version,
                          style: AppTypography.caption(isDark: isDark).copyWith(
                            color: AppColors.successDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•  ${document.fileSize}',
                          style: AppTypography.caption(isDark: isDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Download CTA
              IconButton(
                onPressed: onDownload,
                icon: const Icon(Icons.download_rounded),
                color: isDark ? AppColors.accentGold : AppColors.primary,
                style: IconButton.styleFrom(
                  backgroundColor: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.1),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // File metadata & SHA-256 Checksum
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.security_rounded, size: 12, color: AppColors.lightTextMuted),
                  const SizedBox(width: 4),
                  Text(
                    'SHA-256: ${document.checksumSha256.substring(0, 10)}...',
                    style: AppTypography.caption(isDark: isDark).copyWith(
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Text(
                '${isBangla ? 'আপলোড:' : 'Uploaded:'} ${CurrencyFormatter.formatDate(document.uploadedAt, isBangla: isBangla)}',
                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 10.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
