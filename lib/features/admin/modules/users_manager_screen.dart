import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/admin_user_manage_screen.dart';

class UsersManagerScreen extends StatefulWidget {
  final AppState state;

  const UsersManagerScreen({
    super.key,
    required this.state,
  });

  @override
  State<UsersManagerScreen> createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
  int _selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _tabsBn = ['সব (1248)', 'ইনভেস্টর (1180)', 'আনভেরিফাইড (8)'];

  final List<_AdminUserItem> _users = [
    _AdminUserItem(name: 'Arif Hossain', email: 'arif@gmail.com', status: 'সক্রিয়', isVerified: true, role: 'investor'),
    _AdminUserItem(name: 'Nusrat Jahan', email: 'nusrat@gmail.com', status: 'সক্রিয়', isVerified: true, role: 'investor'),
    _AdminUserItem(name: 'MD. Rakib Hasan', email: 'rakib@gmail.com', status: 'সক্রিয়', isVerified: true, role: 'investor'),
    _AdminUserItem(name: 'Farhana Islam', email: 'farhana@gmail.com', status: 'পেন্ডিং', isVerified: false, role: 'unverified'),
    _AdminUserItem(name: 'Sakib Ahmed', email: 'sakib@gmail.com', status: 'সক্রিয়', isVerified: true, role: 'investor'),
    _AdminUserItem(name: 'Tahmina Akter', email: 'tahmina@gmail.com', status: 'সক্রিয়', isVerified: true, role: 'investor'),
    _AdminUserItem(name: 'Imran Khan', email: 'imran@gmail.com', status: 'পেন্ডিং', isVerified: false, role: 'unverified'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    final filteredUsers = _users.where((u) {
      if (_selectedTabIndex == 1) return u.role == 'investor';
      if (_selectedTabIndex == 2) return u.role == 'unverified';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'সব ব্যবহারকারী' : 'Users Management',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, size: 22, color: palette.ink),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list_rounded, size: 22, color: palette.ink),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Tabs
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _tabsBn.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedTabIndex == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedTabIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0066FF) : palette.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0066FF) : palette.ruleStrong,
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _tabsBn[index],
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : palette.inkSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Users List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return InkWell(
                    onTap: () {
                      AdminUserManageScreen.show(
                        context: context,
                        userName: user.name,
                        userEmail: user.email,
                        userStatus: user.status,
                        isVerified: user.isVerified,
                        state: widget.state,
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1),
                                child: Text(
                                  user.name[0],
                                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: palette.ink),
                                  ),
                                  Text(
                                    user.email,
                                    style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: user.isVerified
                                  ? const Color(0xFF00C853).withValues(alpha: 0.1)
                                  : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              user.status,
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: user.isVerified ? const Color(0xFF00C853) : const Color(0xFFF59E0B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminUserItem {
  final String name;
  final String email;
  final String status;
  final bool isVerified;
  final String role;

  _AdminUserItem({
    required this.name,
    required this.email,
    required this.status,
    required this.isVerified,
    this.role = 'investor',
  });
}
