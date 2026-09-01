import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/widgets/project_card.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';
import 'package:swapnojatri/features/investor/project_detail/project_detail_screen.dart';

class ProjectsScreen extends StatefulWidget {
  final AppState state;

  const ProjectsScreen({
    super.key,
    required this.state,
  });

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filtersEn = ['All', 'Active', 'Upcoming', 'Ended'];
  final List<String> _filtersBn = ['সব', 'সক্রিয়', 'আসন্ন', 'শেষ হয়েছে'];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;
    final allProjects = widget.state.projects;

    final filters = isBangla ? _filtersBn : _filtersEn;

    final filteredProjects = allProjects.where((p) {
      if (_selectedFilterIndex == 1) return p.status == ProjectStatus.active && p.allocatedShares < p.totalShares;
      if (_selectedFilterIndex == 2) return p.status == ProjectStatus.upcoming;
      if (_selectedFilterIndex == 3) return p.status == ProjectStatus.funded || p.allocatedShares >= p.totalShares;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBangla ? 'সকল প্রকল্প' : 'All Projects',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Chips Bar
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        filters[index],
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 12.5,
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

            // Projects List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: filteredProjects.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];
                  return ProjectCard(
                    project: project,
                    isBangla: isBangla,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailScreen(
                            project: project,
                            state: widget.state,
                          ),
                        ),
                      );
                    },
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
