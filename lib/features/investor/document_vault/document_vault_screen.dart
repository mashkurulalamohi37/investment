import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/document_card.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _filtersEn = ['All Documents', 'Partnership & Terms', 'Financial Audits', 'Tax & Progress'];
  final List<String> _filtersBn = ['সকল ডকুমেন্ট', 'পার্টনারশিপ চুক্তি', 'আর্থিক অডিট', 'ট্যাক্স ও অগ্রগতি'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDocumentInspector(BuildContext context, DocumentModel doc, AppPalette palette, bool isDark, bool isBangla) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: AppRadius.borderSheet,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 3,
                  decoration: BoxDecoration(
                    color: palette.ruleStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title & Verified Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBangla ? doc.titleBn : doc.title,
                          style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isBangla ? 'সংস্করণ ${doc.version} • সাইজ: ${doc.fileSize}' : 'Version ${doc.version} • Size: ${doc.fileSize}',
                          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                            color: palette.inkSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SealWidget(size: 38, isBangla: isBangla),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 14),

              // Metadata Table
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Column(
                  children: [
                    _docMetaRow(isBangla ? 'দলিল ক্যাটাগরি' : 'Category', isBangla ? doc.categoryNameBn : doc.categoryName, palette, isDark),
                    const Divider(height: 12),
                    _docMetaRow(isBangla ? 'যাচাইকারী কর্তৃপক্ষ' : 'Verified By', isBangla ? 'সাভার সাব-রেজিস্ট্রি ও লিগ্যাল কাউন্সিল' : 'Savar Sub-Registry & Legal Counsel', palette, isDark),
                    const Divider(height: 12),
                    _docMetaRow(isBangla ? 'আইনি স্ট্যাটাস' : 'Legal Status', isBangla ? 'সম্পূর্ণ যাচাইকৃত ও কার্যকর' : 'Active & Immutable Public Record', palette, isDark, highlight: true),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Cryptographic SHA-256 Hash
              Text(
                isBangla ? 'ক্রিপ্টোগ্রাফিক হ্যাশ (SHA-256 Checksum)' : 'Cryptographic SHA-256 Checksum',
                style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 11),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        doc.checksumSha256,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: palette.ink,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: doc.checksumSha256));
                        HapticFeedback.selectionClick();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'SHA-256 হ্যাশ কপি হয়েছে' : 'SHA-256 checksum copied'),
                            backgroundColor: palette.pine,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.copy_rounded, size: 16, color: palette.pine),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: isBangla ? 'দলিল ডাউনলোড করুন' : 'Download Document',
                      variant: AppButtonVariant.primary,
                      isBangla: isBangla,
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isBangla ? 'দলিল ডাউনলোড সম্পন্ন হয়েছে' : 'Document downloaded successfully'),
                            backgroundColor: palette.pine,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 90,
                    child: AppButton(
                      label: isBangla ? 'বন্ধ' : 'Close',
                      variant: AppButtonVariant.secondary,
                      isBangla: isBangla,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _docMetaRow(String label, String val, AppPalette palette, bool isDark, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 11.5, color: palette.inkSecondary)),
        Text(
          val,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
            color: highlight ? palette.pine : palette.ink,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.state.isBangla;
    final documents = widget.state.documents;
    final filterLabels = isBangla ? _filtersBn : _filtersEn;

    final filtered = documents.where((doc) {
      // Category filter
      if (_selectedFilter == 1) {
        if (doc.category != DocumentCategory.legal &&
            doc.category != DocumentCategory.projectDeed &&
            doc.category != DocumentCategory.govtApproval) {
          return false;
        }
      } else if (_selectedFilter == 2) {
        if (doc.category != DocumentCategory.financialAudit) {
          return false;
        }
      } else if (_selectedFilter == 3) {
        if (doc.category != DocumentCategory.taxCertificate) {
          return false;
        }
      }

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchTitle = doc.title.toLowerCase().contains(query);
        final matchTitleBn = doc.titleBn.toLowerCase().contains(query);
        final matchHash = doc.checksumSha256.toLowerCase().contains(query);
        final matchDesc = doc.description.toLowerCase().contains(query);
        if (!matchTitle && !matchTitleBn && !matchHash && !matchDesc) {
          return false;
        }
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
            // 1. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: AppRadius.borderControl,
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                  style: AppTypography.bodyStrong(isDark: isDark).copyWith(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: isBangla ? 'ডকুমেন্টের নাম, রেফারেন্স বা হ্যাশ দিয়ে খুঁজুন...' : 'Search by title, ref code, or SHA-256 hash...',
                    hintStyle: AppTypography.caption(isDark: isDark).copyWith(color: palette.inkTertiary),
                    prefixIcon: Icon(Icons.search_rounded, size: 18, color: palette.inkTertiary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                ),
              ),
            ),

            // 2. Hairline Filter Row with Matra Underline on Active One (§10)
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
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _selectedFilter = idx);
                      },
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
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // 3. Document Cards List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open_outlined, size: 36, color: palette.inkTertiary),
                          const SizedBox(height: 8),
                          Text(
                            isBangla ? 'কোনো দলিল পাওয়া যায়নি' : 'No matching documents found',
                            style: AppTypography.body(isDark: isDark, isBangla: isBangla).copyWith(
                              color: palette.inkSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final doc = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DocumentCard(
                            document: doc,
                            isBangla: isBangla,
                            onDownload: () => _showDocumentInspector(context, doc, palette, isDark, isBangla),
                            onTap: () => _showDocumentInspector(context, doc, palette, isDark, isBangla),
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
