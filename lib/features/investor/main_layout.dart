import 'package:flutter/material.dart';
import 'package:swapnojatri/core/widgets/custom_bottom_nav.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/auth/auth_screen.dart';
import 'home/home_screen.dart';
import 'projects/projects_screen.dart';
import 'portfolio/portfolio_screen.dart';
import 'transactions/transactions_screen.dart';
import 'profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  final AppState state;
  final VoidCallback? onLogout;

  const MainLayout({
    super.key,
    required this.state,
    this.onLogout,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
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
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: isBangla ? 'হোম' : 'Home',
      ),
      CustomBottomNavItem(
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore_rounded,
        label: isBangla ? 'প্রকল্প' : 'Projects',
      ),
      CustomBottomNavItem(
        icon: Icons.pie_chart_outline_rounded,
        activeIcon: Icons.pie_chart_rounded,
        label: isBangla ? 'পোর্টফোলিও' : 'Portfolio',
      ),
      CustomBottomNavItem(
        icon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long_rounded,
        label: isBangla ? 'লেনদেন' : 'Transactions',
      ),
      CustomBottomNavItem(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: isBangla ? 'প্রোফাইল' : 'Profile',
      ),
    ];

    final screens = [
      HomeScreen(state: widget.state, onNavigateTab: _onTabSelected),
      ProjectsScreen(state: widget.state),
      PortfolioScreen(state: widget.state, onNavigateTab: _onTabSelected),
      TransactionsScreen(state: widget.state),
      ProfileScreen(state: widget.state, onLogout: _handleLogout),
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

// Backward compatibility alias for InvestorMainLayout
typedef InvestorMainLayout = MainLayout;
