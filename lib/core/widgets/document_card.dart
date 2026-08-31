import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';
import 'package:swapnojatri/data/models/document_model.dart';

class DocumentCard extends StatefulWidget {
  final DocumentModel document;
  final bool isBangla;
  final VoidCallback? onDownload;

  const DocumentCard({
    super.key,
    required this.document,
    this.isBangla = false,
    this.onDownload,
  });

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  bool _copied = false;

  void _copyHash() {
    Clipboard.setData(ClipboardData(text: widget.document.sha256Hash));
    HapticFeedback.selectionClick();
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.isBangla;
    final doc = widget.document;

    // Truncated SHA-256 (first 8 and last 8 chars)
    final hash = doc.sha256Hash;
    final displayHash = hash.length > 16
        ? '${hash.substring(0, 8)}...${hash.substring(hash.length - 8)}'
        : hash;

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderZero,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Edge: 3px Full-Height Brass Sealed Bar
            Container(
              width: 3.0,
              color: palette.brass,
            ),

            // Main Content Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Title & 20px Seal
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBangla ? doc.titleBn : doc.title,
                                style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isBangla ? 'সনদকারী: ${doc.verifiedBy}' : 'Issuer: ${doc.verifiedBy}',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: palette.inkSecondary,
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SealWidget(size: 24, isBangla: isBangla),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // SHA-256 Hash Row (Clickable)
                    InkWell(
                      onTap: _copyHash,
                      borderRadius: AppRadius.borderChip,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: palette.surfaceSunken,
                          borderRadius: AppRadius.borderChip,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'SHA-256: $displayHash',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: palette.inkTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _copied
                                  ? (isBangla ? 'কপি হয়েছে' : 'Hash copied')
                                  : (isBangla ? 'কপি' : 'Copy'),
                              style: TextStyle(
                                fontSize: 9.5,
                                color: _copied ? palette.jade : palette.inkSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 8),

                    // Footer Row: Type, Size (Vertical Hairline separated), and Download Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              doc.fileType.toUpperCase(),
                              style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                color: palette.inkSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 1,
                              height: 10,
                              color: palette.rule,
                            ),
                            Text(
                              doc.fileSize,
                              style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                                color: palette.inkTertiary,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: widget.onDownload,
                          child: Row(
                            children: [
                              Icon(Icons.download_rounded, size: 14, color: palette.pine),
                              const SizedBox(width: 4),
                              Text(
                                isBangla ? 'দলিল দেখুন' : 'View Document',
                                style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                  color: palette.pine,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Backward compatibility alias for DocumentVaultCard
typedef DocumentVaultCard = DocumentCard;
