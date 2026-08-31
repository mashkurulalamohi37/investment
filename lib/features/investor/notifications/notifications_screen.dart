import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class NotificationsScreen extends StatelessWidget {
  final AppState state;

  const NotificationsScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = state.isBangla;
    final notifs = state.notifications;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'বিজ্ঞপ্তি ও নোটিফিকেশন' : 'Notices & Notifications',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          if (state.unreadNotificationCount > 0)
            TextButton(
              onPressed: () => state.markAllNotificationsAsRead(),
              child: Text(
                isBangla ? 'সব পঠিত' : 'Mark all read',
                style: TextStyle(
                  color: palette.pine,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      body: notifs.isEmpty
          ? Center(
              child: Text(
                isBangla ? 'কোনো নতুন বিজ্ঞপ্তি নেই' : 'No notifications',
                style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkSecondary,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final n = notifs[index];
                return Dismissible(
                  key: Key(n.id),
                  onDismissed: (_) => state.markNotificationAsRead(n.id),
                  child: InkWell(
                    onTap: () => state.markNotificationAsRead(n.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: n.isRead ? palette.surface : palette.surfaceSunken,
                        border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6, right: 10),
                            decoration: BoxDecoration(
                              color: n.isRead ? Colors.transparent : palette.pine,
                              shape: BoxShape.circle,
                            ),
                          ),
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
                                        style: AppTypography.bodyStrong(isDark: isDark, isBangla: isBangla).copyWith(
                                          fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w700,
                                          fontSize: 13.5,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      CurrencyFormatter.formatDate(n.timestamp, isBangla: isBangla),
                                      style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                        color: palette.inkTertiary,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  isBangla ? n.bodyBn : n.body,
                                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                    color: palette.inkSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
