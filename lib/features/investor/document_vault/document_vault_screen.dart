import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/document_vault_card.dart';
import 'package:swapnojatri/data/models/document_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class DocumentVaultScreen extends StatefulWidget {
  final AppState state;

  const DocumentVaultScreen({
    super.key,
    required this.state,
  });

  @override
  State<DocumentVaultScreen> createState() => _DocumentVaultScreenState();
}

class _DocumentVaultScreenState extends State<DocumentVaultScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categoriesEn = ['All Documents', 'Title Deeds', 'Govt Approvals', 'Certificates & Tax'];
  final List<String> _categoriesBn = ['সকল দলিল', 'মালিকানা দলিল', 'সরকারি অনুমোদন', 'সনদপত্র ও কর'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final docs = widget.state.documents;

    final filtered = docs.where((d) {
      if (_selectedCategoryIndex == 1 && d.category != DocumentCategory.projectDeed && d.category != DocumentCategory.legal) {
        return false;
      }
      if (_selectedCategoryIndex == 2 && d.category != DocumentCategory.govtApproval) {
        return false;
      }
      if (_selectedCategoryIndex == 3 && d.category != DocumentCategory.receipt && d.category != DocumentCategory.taxCertificate) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(
          isBangla ? 'সুরক্ষিত দলিল ও নথি ভল্ট' : 'Secure Document Vault',
          style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vault Security Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isDark ? AppColors.heroGradientDark : AppColors.heroGradientLight,
                borderRadius: AppRadius.borderLg,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accentGold.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_rounded, color: AppColors.accentGoldLight, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? 'এনক্রিপ্টেড ও অডিট-যাচাইকৃত ভল্ট' : 'Encrypted & Cryptographically Sealed',
                          style: AppTypography.headingSmall().copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isBangla
                              ? 'প্রতিটি দলিলের জন্য রয়েছে স্বতন্ত্র SHA-256 ডিজিটাল স্বাক্ষর।'
                              : 'All documents feature immutable SHA-256 checksums.',
                          style: AppTypography.caption().copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Category Filter
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
            const SizedBox(height: 20),

            Text(
              isBangla ? 'দলিল তালিকা (${filtered.length})' : 'Documents (${filtered.length})',
              style: AppTypography.headingMedium(isDark: isDark, isBangla: isBangla),
            ),
            const SizedBox(height: 12),

            ...filtered.map((doc) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: DocumentVaultCard(
                    document: doc,
                    isBangla: isBangla,
                    onDownload: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isBangla
                                ? '${doc.fileName} সুরক্ষিতভাবে ডাউনলোড করা হচ্ছে'
                                : 'Downloading official document: ${doc.fileName}...',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                  ),
                )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
