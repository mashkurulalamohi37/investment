import 'package:flutter/material.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/document_card.dart';
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
  int _selectedFilter = 0;

  final List<String> _filtersEn = ['All Documents', 'Title Deeds & Mutation', 'Legal Vetting'];
  final List<String> _filtersBn = ['সকল দলিল', 'খতিয়ান ও দলিল', 'আইনি অডিট'];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final documents = widget.state.documents;
    final filterLabels = isBangla ? _filtersBn : _filtersEn;

    final filtered = documents.where((doc) {
      if (_selectedFilter == 1) {
        return doc.category == DocumentCategory.legal ||
            doc.category == DocumentCategory.projectDeed ||
            doc.category == DocumentCategory.govtApproval;
      }
      if (_selectedFilter == 2) {
        return doc.category == DocumentCategory.financialAudit ||
            doc.category == DocumentCategory.taxCertificate;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        title: Text(
          isBangla ? 'দলিল ও অডিট ভল্ট' : 'Document & Title Vault',
          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Hairline Filter Row with Matra Underline on Active One (§10)
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Document Cards List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: filtered.length,
                separatorBuilder: (context, idx) => const SizedBox(height: 12),
                itemBuilder: (context, idx) {
                  final doc = filtered[idx];
                  return DocumentCard(
                    document: doc,
                    isBangla: isBangla,
                    onDownload: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isBangla ? 'দলিল ডাউনলোড হচ্ছে...' : 'Downloading document...'),
                          backgroundColor: palette.pine,
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
