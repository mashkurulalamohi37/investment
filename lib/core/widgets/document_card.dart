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
  final VoidCallback? onTap;

  const DocumentCard({
    super.key,
    required this.document,
    this.isBangla = false,
    this.onDownload,
    this.onTap,
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

    return InkWell(
      onTap: widget.onTap ?? widget.onDownload,
      borderRadius: AppRadius.borderZero,
      child: Container(
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: AppRadius.borderZero,
          border: Border.all(color: palette.ruleStrong, width: 1.0),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Edge: 3px Full-Height Brass Sealed Bar (§10)
              Container(
                width: 3.0,
                color: palette.brass,
              ),

              // Main Content Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Title in Source Serif 4 + 20px Mini Seal (§10)
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
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isBangla ? doc.descriptionBn : doc.description,
                                  style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                                    color: palette.inkSecondary,
                                    fontSize: 11.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // 20px Seal Stamp (§10)
                          SealWidget(size: 24, isBangla: isBangla),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Middle: SHA-256 Hash Row in Monospace with Copy Affordance
                      InkWell(
                        onTap: _copyHash,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: palette.surfaceSunken,
                            border: Border.all(color: palette.rule, width: 0.8),
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

                      // Footer Row: Type, Size, and Action
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
                          Row(
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Backward compatibility alias for DocumentVaultCard
typedef DocumentVaultCard = DocumentCard;
