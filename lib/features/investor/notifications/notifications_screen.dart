import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/models/notification_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class NotificationsScreen extends StatelessWidget {
  final AppState state;

  const NotificationsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final notifs = state.notifications;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'নোটিফিকেশন ও বার্তা' : 'Notifications',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        actions: [
          if (state.unreadNotificationCount > 0)
            TextButton(
              onPressed: () => state.markAllNotificationsAsRead(),
              child: Text(
                isBangla ? 'সব পঠিত করুন' : 'Mark all read',
                style: TextStyle(
                  color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      body: notifs.isEmpty
          ? Center(
              child: Text(
                isBangla ? 'কোনো নতুন নোটিফিকেশন নেই' : 'No notifications',
                style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final n = notifs[index];
                return Dismissible(
                  key: Key(n.id),
                  onDismissed: (_) => state.markNotificationAsRead(n.id),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                      onTap: () => state.markNotificationAsRead(n.id),
                      borderRadius: AppRadius.borderMd,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: n.isRead
                              ? (isDark ? AppColors.darkCard : Colors.white)
                              : (isDark ? AppColors.primaryDark : AppColors.primarySubtle.withValues(alpha: 0.5)),
                          borderRadius: AppRadius.borderMd,
                          border: Border.all(
                            color: n.isRead
                                ? (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder)
                                : AppColors.primary.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (isDark ? AppColors.accentGold : AppColors.primary).withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getIcon(n.category),
                                size: 18,
                                color: isDark ? AppColors.accentGoldLight : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          isBangla ? n.titleBn : n.title,
                                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                                            fontSize: 14,
                                            fontWeight: n.isRead ? FontWeight.w600 : FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      if (!n.isRead)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppColors.accentGold,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isBangla ? n.bodyBn : n.body,
                                    style: AppTypography.bodySmall(isDark: isDark, isBangla: isBangla),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    CurrencyFormatter.formatDate(n.createdAt, isBangla: isBangla),
                                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  IconData _getIcon(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.investment:
        return Icons.account_balance_wallet_rounded;
      case NotificationCategory.distribution:
        return Icons.payments_rounded;
      case NotificationCategory.project:
        return Icons.terrain_rounded;
      case NotificationCategory.document:
        return Icons.folder_shared_rounded;
      case NotificationCategory.security:
        return Icons.verified_user_rounded;
      case NotificationCategory.payment:
        return Icons.receipt_long_rounded;
      case NotificationCategory.system:
        return Icons.info_outline_rounded;
    }
  }
}
