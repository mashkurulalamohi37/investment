import 'package:flutter/material.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'dashboard/admin_dashboard_screen.dart';

class AdminLayout extends StatelessWidget {
  final AppState state;

  const AdminLayout({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AdminDashboardScreen(state: state);
  }
}
