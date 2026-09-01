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
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final assets = state.assets;

    return Scaffold(
      backgroundColor: palette.canvas,
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
                    color: palette.surface,
                    borderRadius: AppRadius.borderCard,
                    border: Border.all(
                      color: palette.rule,
                      width: 1.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Banner
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Image.network(
                          asset.photos.first,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: palette.pineTint,
                            child: Icon(Icons.terrain_rounded, size: 48, color: palette.pine),
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
                                  rawStatus: 'Verified',
                                  isBangla: isBangla,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              asset.location,
                              style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                            ),
                            const SizedBox(height: 14),
                            Divider(color: palette.rule, height: 1),
                            const SizedBox(height: 12),

                            _assetDetailRow(isBangla ? 'সম্পদের ধরন' : 'Asset Type', asset.assetType, palette, isDark),
                            _assetDetailRow(isBangla ? 'জমির পরিমাপ' : 'Land Measurement', '${asset.landAreaDecimals} Decimals (শতাংশ)', palette, isDark),
                            _assetDetailRow(isBangla ? 'প্রকল্প সম্পদ রেফারেন্স' : 'Project Asset Ref', asset.deedNumber, palette, isDark),
                            _assetDetailRow(isBangla ? 'আইনি ও ভৌগোলিক স্থিতি' : 'Verification Status', asset.mutationKhatian, palette, isDark),
                            _assetDetailRow(isBangla ? 'ক্রয়মূল্য (Acquisition)' : 'Purchase Cost', CurrencyFormatter.format(asset.purchaseValue, isBangla: isBangla), palette, isDark),
                            _assetDetailRow(isBangla ? 'মূল্যায়ন (Current Value)' : 'Appraised Valuation', CurrencyFormatter.format(asset.currentValue, isBangla: isBangla), palette, isDark),
                            _assetDetailRow(isBangla ? 'আইনি কর্মকর্তা' : 'Legal Compliance Officer', asset.legalVerificationOfficer ?? 'Supreme Court Advocate', palette, isDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _assetDetailRow(String label, String value, AppPalette palette, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: palette.inkSecondary,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: palette.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
