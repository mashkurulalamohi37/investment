import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/status_chip.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AssetsScreen extends StatelessWidget {
  final AppState state;

  const AssetsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final assets = state.assets;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'জমির সম্পদ রেজিস্ট্রি' : 'Land & Asset Registry',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...assets.map((asset) => Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: AppRadius.borderXl,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Carousel Banner
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
                        child: SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: Image.network(
                            asset.photos.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.primarySubtle,
                              child: const Icon(Icons.terrain_rounded, size: 48, color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isBangla ? asset.titleBn : asset.title,
                                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla).copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                StatusChip(
                                  label: isBangla ? 'নিবন্ধিত স্বত্ব' : 'Title Deed Verified',
                                  textColor: AppColors.successDark,
                                  bgColor: AppColors.successLight,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              asset.location,
                              style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                            ),
                            const SizedBox(height: 14),
                            const Divider(height: 1),
                            const SizedBox(height: 12),

                            _assetDetailRow(isBangla ? 'সম্পদের ধরন' : 'Asset Type', asset.assetType, isDark),
                            _assetDetailRow(isBangla ? 'জমির পরিমাপ' : 'Land Measurement', '${asset.landAreaDecimals} Decimals (শতাংশ)', isDark),
                            _assetDetailRow(isBangla ? 'সাব-রেজিস্ট্রি দলিল নম্বর' : 'Deed Registration No.', asset.deedNumber, isDark),
                            _assetDetailRow(isBangla ? 'নামজারি ও আরএস খতিয়ান' : 'Mutation Khatian & Case', asset.mutationKhatian, isDark),
                            _assetDetailRow(isBangla ? 'ক্রয়মূল্য (Acquisition)' : 'Purchase Cost', CurrencyFormatter.format(asset.purchaseValue, isBangla: isBangla), isDark),
                            _assetDetailRow(isBangla ? 'মূল্যায়ন (Current Value)' : 'Appraised Valuation', CurrencyFormatter.format(asset.currentValue, isBangla: isBangla), isDark),
                            _assetDetailRow(isBangla ? 'আইনি কর্মকর্তা' : 'Legal Compliance Officer', asset.legalVerificationOfficer ?? 'Supreme Court Advocate', isDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _assetDetailRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.caption(isDark: isDark).copyWith(fontSize: 12)),
          Flexible(
            child: Text(
              value,
              style: AppTypography.headingSmall(isDark: isDark).copyWith(fontSize: 12.5, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
