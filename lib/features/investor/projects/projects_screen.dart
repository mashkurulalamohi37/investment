import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/project_card.dart';
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
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;

  final List<String> _filtersEn = ['All Opportunities', 'Live Funding', 'Fully Subscribed'];
  final List<String> _filtersBn = ['সকল সুযোগ', 'চলমান তহবিল', 'তহবিল সম্পন্ন'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final project = widget.state.landVest100;
    final filterLabels = isBangla ? _filtersBn : _filtersEn;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'ভূমি বিনিয়োগ প্রকল্পসমূহ' : 'Land Investment Opportunities',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Hairline Filter Row with Matra Underline on Active Filter
            Container(
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(bottom: BorderSide(color: palette.rule, width: 1.0)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(filterLabels.length, (idx) {
                    final isSelected = _selectedFilter == idx;
                    return InkWell(
                      onTap: () => setState(() => _selectedFilter = idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? palette.pine : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          filterLabels[idx],
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            color: isSelected ? palette.pine : palette.inkSecondary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  ProjectCard(
                    project: project,
                    isBangla: isBangla,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailScreen(project: project, state: widget.state),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
