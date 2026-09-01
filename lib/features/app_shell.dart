import 'package:flutter/material.dart';
import 'package:swapnojatri/data/models/user_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'admin/admin_layout.dart';
import 'investor/main_layout.dart';

class AppShell extends StatelessWidget {
  final AppState state;
  final VoidCallback? onLogout;

  const AppShell({
    super.key,
    required this.state,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        if (state.activeRole == UserRole.admin) {
          return AdminLayout(state: state, onLogout: onLogout);
        }
        return MainLayout(state: state, onLogout: onLogout);
      },
    );
  }
}
