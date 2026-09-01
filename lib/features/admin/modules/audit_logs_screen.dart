import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminAuditLogsScreen extends StatelessWidget {
  final AppState state;

  const AdminAuditLogsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final logs = state.auditLogs;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'অডিট লগ ও নিরাপত্তা ট্রেইল' : 'Immutable Audit Logs',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => state.toggleLanguage(),
            child: Text(
              isBangla ? 'EN' : 'বাং',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: palette.pine,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBangla ? 'সকল আর্থিক ও প্রশাসনিক কার্যকলাপ (${logs.length})' : 'Append-Only Action Trail (${logs.length})',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...logs.map((log) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: AppRadius.borderCard,
                    border: Border.all(
                      color: palette.rule,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: palette.pineTint,
                              borderRadius: AppRadius.borderChip,
                            ),
                            child: Text(
                              log.getAction(isBangla),
                              style: AppTypography.caption().copyWith(
                                color: palette.pineDeep,
                                fontFamily: isBangla ? null : 'monospace',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatDate(log.timestamp, isBangla: isBangla),
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        log.getDetails(isBangla),
                        style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isBangla
                                ? 'সম্পাদনকারী: ${log.actorName} (${log.actorRole == 'Super Admin' ? 'সুপার অ্যাডমিন' : 'ফাইন্যান্স ম্যানেজার'})'
                                : 'Actor: ${log.actorName} (${log.actorRole})',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 10.5),
                          ),
                          Text(
                            'IP: ${log.ipAddress}',
                            style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ),
                        ],
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
}
