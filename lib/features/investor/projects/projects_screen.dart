import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
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
  int _selectedCategoryIndex = 0;
  int _selectedStatusIndex = 0;

  final List<String> _categoriesEn = ['All Opportunities', 'Land Projects', 'Commercial', 'Agro-Land'];
  final List<String> _categoriesBn = ['সকল সুযোগ', 'জমি প্রকল্প', 'বাণিজ্যিক', 'এগ্রো-ল্যান্ড'];

  final List<String> _statusEn = ['All Status', 'Live Funding', 'Fully Funded', 'Upcoming'];
  final List<String> _statusBn = ['সকল অবস্থা', 'চলমান তহবিল', 'তহবিল সম্পন্ন', 'আসন্ন'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final project = widget.state.landVest100;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'বিনিয়োগ প্রকল্পসমূহ' : 'Investment Opportunities',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: AppTypography.bodyMedium(isDark: isDark, isBangla: isBangla),
                decoration: InputDecoration(
                  hintText: isBangla ? 'প্রকল্পের নাম বা অবস্থান দিয়ে খুঁজুন...' : 'Search by project name or location...',
                  hintStyle: TextStyle(
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    fontSize: 13.5,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_categoriesEn.length, (index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        isBangla ? _categoriesBn[index] : _categoriesEn[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? (isDark ? AppColors.primaryDark : Colors.white)
                              : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextPrimary),
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedCategoryIndex = index),
                      selectedColor: isDark ? AppColors.accentGold : AppColors.primary,
                      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderFull,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),

            // Status Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_statusEn.length, (index) {
                  final isSelected = _selectedStatusIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        isBangla ? _statusBn[index] : _statusEn[index],
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : (isDark ? AppColors.darkTextMuted : AppColors.lightTextSecondary),
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedStatusIndex = index),
                      selectedColor: isDark ? AppColors.primaryLight : AppColors.primaryMedium,
                      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderFull,
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : (isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Project Discovery List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isBangla ? 'সক্রিয় প্রকল্প (১টি চলমান)' : 'Active Projects (1 Live)',
                  style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: AppRadius.borderXs,
                  ),
                  child: Text(
                    isBangla ? '১০০% যাচাইকৃত' : '100% Vetted',
                    style: AppTypography.caption().copyWith(
                      color: AppColors.successDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Flagship LandVest 100 Card
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
            const SizedBox(height: 24),

            // Upcoming Pipeline Teaser Project
            Text(
              isBangla ? 'আসন্ন প্রকল্প পাইপলাইন' : 'Upcoming Pipeline',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primarySubtle,
                      borderRadius: AppRadius.borderMd,
                    ),
                    child: const Icon(Icons.water_rounded, color: AppColors.primaryDark, size: 32),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.warningLight,
                                borderRadius: AppRadius.borderXs,
                              ),
                              child: Text(
                                isBangla ? 'আইনি যাচাইধীন' : 'Under Due Diligence',
                                style: AppTypography.caption().copyWith(
                                  color: AppColors.warningDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'LV200',
                              style: AppTypography.caption(isDark: isDark).copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isBangla ? 'রিভারভিউ এগ্রো অ্যান্ড ইকো ল্যান্ড' : 'RiverView Agro & Eco Land',
                          style: AppTypography.headingSmall(isDark: isDark, isBangla: isBangla).copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          isBangla ? 'কেরানীগঞ্জ, ঢাকা • ৫০টি শেয়ার' : 'Keraniganj, Dhaka • 50 Shares',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
