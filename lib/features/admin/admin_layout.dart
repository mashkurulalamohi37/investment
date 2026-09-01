import 'package:flutter/material.dart';
import 'package:swapnojatri/core/widgets/custom_bottom_nav.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/auth/auth_screen.dart';
import 'dashboard/admin_dashboard_screen.dart';
import 'modules/investments_manager_screen.dart';
import 'modules/users_manager_screen.dart';
import 'modules/reports_screen.dart';
import 'modules/admin_settings_screen.dart';

class AdminLayout extends StatefulWidget {
  final AppState state;
  final VoidCallback? onLogout;

  const AdminLayout({
    super.key,
    required this.state,
    this.onLogout,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  void _handleLogout() {
    if (widget.onLogout != null) {
      widget.onLogout!();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBangla = widget.state.isBangla;

    final navItems = [
      CustomBottomNavItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard_rounded,
        label: isBangla ? 'ড্যাশবোর্ড' : 'Dashboard',
      ),
      CustomBottomNavItem(
        icon: Icons.apartment_outlined,
        activeIcon: Icons.apartment_rounded,
        label: isBangla ? 'প্রজেক্ট' : 'Projects',
      ),
      CustomBottomNavItem(
        icon: Icons.people_outline_rounded,
        activeIcon: Icons.people_rounded,
        label: isBangla ? 'ইউজার' : 'Users',
      ),
      CustomBottomNavItem(
        icon: Icons.bar_chart_rounded,
        activeIcon: Icons.bar_chart_rounded,
        label: isBangla ? 'রিপোর্ট' : 'Reports',
      ),
      CustomBottomNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: isBangla ? 'সেটিংস' : 'Settings',
      ),
    ];

    final screens = [
      AdminDashboardScreen(state: widget.state, onNavigateTab: _onTabSelected),
      AdminInvestmentsManagerScreen(state: widget.state),
      UsersManagerScreen(state: widget.state),
      AdminReportsScreen(state: widget.state),
      AdminSettingsScreen(state: widget.state, onLogout: _handleLogout),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: navItems,
        isBangla: isBangla,
      ),
    );
  }
}
