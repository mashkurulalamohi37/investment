import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/admin/modules/add_project_screen.dart';
import 'package:swapnojatri/features/admin/modules/admin_project_detail_screen.dart';

class AdminInvestmentsManagerScreen extends StatefulWidget {
  final AppState state;

  const AdminInvestmentsManagerScreen({
    super.key,
    required this.state,
  });

  @override
  State<AdminInvestmentsManagerScreen> createState() => _AdminInvestmentsManagerScreenState();
}

class _AdminInvestmentsManagerScreenState extends State<AdminInvestmentsManagerScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabsBn = ['সব (12)', 'সক্রিয় (8)', 'আসন্ন (3)', 'বন্ধ (1)'];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final allProjects = widget.state.projects;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'সব প্রজেক্ট' : 'All Projects (Admin)',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        actions: [
          // "+ নতুন প্রজেক্ট" Button
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProjectScreen(state: widget.state)),
                );
              },
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: Text(
                isBangla ? 'নতুন প্রজেক্ট' : 'New Project',
                style: GoogleFonts.hindSiliguri(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                          fontSize: 11.5,
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

            // Projects Management List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: allProjects.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final project = allProjects[index];
                  final progress = (project.allocatedShares / project.totalShares).clamp(0.0, 1.0);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminProjectDetailScreen(
                            project: project,
                            state: widget.state,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.name,
                                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: palette.ink),
                                ),
                                Text(
                                  project.location,
                                  style: GoogleFonts.poppins(fontSize: 11, color: palette.inkSecondary),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00C853).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isBangla ? 'সক্রিয়' : 'Active',
                                style: GoogleFonts.hindSiliguri(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF00C853),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '৳ 18,36,000 / ৳ 25,50,000',
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: palette.ink),
                            ),
                            Text(
                              '${(progress * 100).toInt()}%',
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0066FF)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: palette.surfaceSunken,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0066FF)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${project.allocatedShares} / ${project.totalShares} Shares Allocated',
                          style: GoogleFonts.poppins(fontSize: 10.5, color: palette.inkSecondary),
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
