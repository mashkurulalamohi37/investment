import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';
import 'package:swapnojatri/core/widgets/app_button.dart';
import 'package:swapnojatri/core/widgets/seal_painter.dart';

class LotMapWidget extends StatefulWidget {
  final int totalShares;
  final int allocatedShares;
  final List<String> userLots;
  final int selectedSharesCount;
  final Function(int sharesCount)? onSelectShares;
  final Function(int lotIndex)? onLotTap;
  final bool isBangla;
  final bool isInteractive;
  final bool isCompact;

  const LotMapWidget({
    super.key,
    this.totalShares = 100,
    required this.allocatedShares,
    this.userLots = const ['LOT-041', 'LOT-042', 'LOT-043', 'LOT-044'],
    this.selectedSharesCount = 2,
    this.onSelectShares,
    this.onLotTap,
    this.isBangla = false,
    this.isInteractive = true,
    this.isCompact = false,
  });

  @override
  State<LotMapWidget> createState() => _LotMapWidgetState();
}

class _LotMapWidgetState extends State<LotMapWidget> {
  void _showLotInspectionModal(BuildContext context, int index, AppPalette palette, bool isDark, bool isBangla, Set<int> userIndices) {
    final lotNo = (index + 1).toString().padLeft(3, '0');
    final isUserLot = userIndices.contains(index);
    final isAllocated = index < widget.allocatedShares && !isUserLot;
    final isAvailable = index >= widget.allocatedShares;

    final row = (index ~/ 10) + 1;
    final colLetter = String.fromCharCode(65 + (index % 10));

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
              // Sheet Drag Handle
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

              // Header: Lot Title & Coordinates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'নির্দিষ্ট ভূমি অংশ: লট-$lotNo' : 'Surveyed Parcel: LOT-$lotNo',
                        style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isBangla
                            ? 'গ্রিড স্থানাঙ্ক: কলাম $colLetter, সারি $row • দাগ নং ৪১৮'
                            : 'Grid Coord: Col $colLetter, Row $row • RS Plot #418',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (isUserLot)
                    SealWidget(size: 38, isBangla: isBangla)
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAvailable ? palette.pineTint : palette.surfaceSunken,
                        borderRadius: AppRadius.borderChip,
                        border: Border.all(color: isAvailable ? palette.pine : palette.rule, width: 1.0),
                      ),
                      child: Text(
                        isAvailable
                            ? (isBangla ? 'উপলব্ধ' : 'AVAILABLE')
                            : (isBangla ? 'বরাদ্দকৃত' : 'ALLOCATED'),
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isAvailable ? palette.pine : palette.inkSecondary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 14),

              // Cadastral Specifications Table
              Container(
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _detailRow(isBangla ? 'ভূমির পরিমাণ' : 'Land Area', isBangla ? '০.২২৫ শতাংশ (০.১৩৬ কাঠা)' : '0.225 Decimals (0.136 Katha)', palette, isDark),
                    const Divider(height: 14),
                    _detailRow(isBangla ? 'মৌজা ও খতিয়ান' : 'Mouza & Khatian', isBangla ? 'বিরুলিয়া মৌজা, আরএস খতিয়ান ৯০২' : 'Birulia Mouza, RS Khatian 902', palette, isDark),
                    const Divider(height: 14),
                    _detailRow(isBangla ? 'সাব-রেজিস্ট্রি অফিস' : 'Sub-Registry', isBangla ? 'সাভার সাব-রেজিস্ট্রি অফিস, ঢাকা' : 'Savar Sub-Registry Office, Dhaka', palette, isDark),
                    const Divider(height: 14),
                    _detailRow(
                      isBangla ? 'মালিকানা অবস্থা' : 'Status',
                      isUserLot
                          ? (isBangla ? 'আপনার সক্রিয় মালিকানা (দলিল ৪৯৮২/২৬)' : 'Your Ownership (Deed #4982/26)')
                          : (isAllocated
                              ? (isBangla ? 'নিবন্ধিত বিনিয়োগকারীর অংশ' : 'Allocated Investor Lot')
                              : (isBangla ? 'ক্রয়ের জন্য সম্পূর্ণ প্রস্তুত' : 'Ready for Immediate Subscription')),
                      palette,
                      isDark,
                      highlight: isUserLot,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Legal Boundary Schedule (চৌহদ্দি)
              Text(
                isBangla ? 'চৌহদ্দি সীমানা তালিকা (Schedule of Boundaries)' : 'Schedule of Boundaries',
                style: AppTypography.sectionLabel(isDark: isDark, isBangla: isBangla).copyWith(fontSize: 11),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: palette.surface,
                  border: Border.all(color: palette.rule, width: 1.0),
                  borderRadius: AppRadius.borderChip,
                ),
                child: Column(
                  children: [
                    _boundaryRow('উত্তর (North)', 'আরএস দাগ নং ৪১৭ (মৌজা সীমানা প্রাচীর)', palette),
                    const SizedBox(height: 4),
                    _boundaryRow('দক্ষিণ (South)', '২০ ফুট প্রশস্ত অভ্যন্তরীণ পাকা রাস্তা', palette),
                    const SizedBox(height: 4),
                    _boundaryRow('পূর্ব (East)', 'লট নং ${(index + 2).clamp(1, 100).toString().padLeft(3, '0')} (অভ্যন্তরীণ প্লট)', palette),
                    const SizedBox(height: 4),
                    _boundaryRow('পশ্চিম (West)', 'লট নং ${(index).clamp(1, 100).toString().padLeft(3, '0')} (অভ্যন্তরীণ প্লট)', palette),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Actions
              if (isAvailable && widget.onSelectShares != null) ...[
                AppButton(
                  label: isBangla ? 'এই লট নির্বাচন করে সাবস্ক্রাইব করুন' : 'Select & Subscribe to This Lot',
                  variant: AppButtonVariant.primary,
                  isBangla: isBangla,
                  onPressed: () {
                    Navigator.pop(context);
                    final count = (index - widget.allocatedShares + 1).clamp(1, 4);
                    widget.onSelectShares!(count);
                  },
                ),
              ] else ...[
                AppButton(
                  label: isBangla ? 'বন্ধ করুন' : 'Close',
                  variant: AppButtonVariant.secondary,
                  isBangla: isBangla,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String val, AppPalette palette, bool isDark, {bool highlight = false}) {
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

  Widget _boundaryRow(String dir, String desc, AppPalette palette) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(dir, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: palette.inkSecondary)),
        ),
        Expanded(
          child: Text(desc, style: TextStyle(fontSize: 10.5, color: palette.ink)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBangla = widget.isBangla;

    final userIndices = <int>{};
    for (var lot in widget.userLots) {
      final numStr = lot.replaceAll('LOT-', '');
      final idx = int.tryParse(numStr);
      if (idx != null) {
        userIndices.add(idx - 1);
      }
    }

    if (widget.isCompact) {
      return AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: palette.surfaceSunken,
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          child: CustomPaint(
            painter: _SurveySheetPainter(
              palette: palette,
              totalShares: widget.totalShares,
              allocatedShares: widget.allocatedShares,
              userIndices: userIndices,
              selectedSharesCount: widget.selectedSharesCount,
              isBangla: isBangla,
              isCompact: true,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderZero,
        border: Border.all(color: palette.ruleStrong, width: 1.0),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isBangla ? 'প্লট ৪১৮ — ১০০টি চিহ্নিত অংশ' : 'Plot 418 — 100 Surveyed Lots',
                    style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isBangla
                        ? 'মৌজা: বিরুলিয়া, সাভার • আরএস খতিয়ান ৯০২'
                        : 'Mouza: Birulia, Savar • RS Khatian #902',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                child: Text(
                  'CADASTRAL 10×10',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: palette.inkSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Survey Sheet Canvas with Interactive Grid Overlay
          LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth;
              const margin = 16.0;
              final fieldSize = size - (margin * 2);

              return Stack(
                children: [
                  // Drawn Cadastral Canvas
                  Container(
                    width: size,
                    height: size,
                    color: palette.surfaceSunken,
                    child: CustomPaint(
                      painter: _SurveySheetPainter(
                        palette: palette,
                        totalShares: widget.totalShares,
                        allocatedShares: widget.allocatedShares,
                        userIndices: userIndices,
                        selectedSharesCount: widget.selectedSharesCount,
                        isBangla: isBangla,
                        isCompact: false,
                      ),
                    ),
                  ),

                  // Transparent 44x44 Hit Target Grid Overlay
                  if (widget.isInteractive)
                    Positioned(
                      left: margin,
                      top: margin,
                      width: fieldSize,
                      height: fieldSize,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.totalShares,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final lotNo = (index + 1).toString().padLeft(3, '0');
                          final isUserLot = userIndices.contains(index);
                          final isAllocated = index < widget.allocatedShares && !isUserLot;

                          String semLabel;
                          if (isUserLot) {
                            semLabel = 'Lot $lotNo, allocated to you';
                          } else if (isAllocated) {
                            semLabel = 'Lot $lotNo, allocated to another investor';
                          } else {
                            semLabel = 'Lot $lotNo, available for subscription';
                          }

                          return Semantics(
                            label: semLabel,
                            button: true,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                widget.onLotTap?.call(index);
                                _showLotInspectionModal(context, index, palette, isDark, isBangla, userIndices);
                              },
                              child: Container(color: Colors.transparent),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Scale & Reference Note
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(width: 24, height: 1, color: palette.inkTertiary),
                  const SizedBox(width: 6),
                  Text(
                    isBangla ? '১ ঘর = ১/১০০ অংশ (০.২২৫ শতাংশ)' : '1 cell = 1/100 share (0.225 dec)',
                    style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                      color: palette.inkTertiary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Text(
                isBangla ? 'উত্তরমুখী নকশা ↑' : 'True North ↑',
                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.inkTertiary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Ruled Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _legendItem(
                box: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: palette.surface,
                    border: Border.all(color: palette.rule, width: 1.0),
                  ),
                ),
                label: isBangla ? 'উপলব্ধ' : 'Available',
                count: '${widget.totalShares - widget.allocatedShares}',
                palette: palette,
                isDark: isDark,
                isBangla: isBangla,
              ),
              _legendItem(
                box: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: palette.surface,
                    border: Border.all(color: palette.rule, width: 1.0),
                  ),
                  child: CustomPaint(painter: _HatchPatternPainter(color: palette.inkTertiary)),
                ),
                label: isBangla ? 'বরাদ্দকৃত' : 'Allocated',
                count: '${widget.allocatedShares - userIndices.length}',
                palette: palette,
                isDark: isDark,
                isBangla: isBangla,
              ),
              _legendItem(
                box: Container(
                  width: 12,
                  height: 12,
                  color: palette.pine,
                  child: Center(
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: palette.brass,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                label: isBangla ? 'আপনার অংশ' : 'Yours',
                count: '${userIndices.length}',
                palette: palette,
                isDark: isDark,
                isBangla: isBangla,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem({
    required Widget box,
    required String label,
    required String count,
    required AppPalette palette,
    required bool isDark,
    required bool isBangla,
  }) {
    return Row(
      children: [
        box,
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 11,
            color: palette.inkSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${isBangla ? CurrencyFormatter.toBanglaDigits(count) : count})',
          style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: palette.ink,
          ),
        ),
      ],
    );
  }
}

class _HatchPatternPainter extends CustomPainter {
  final Color color;
  const _HatchPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width / 2, 0), paint);
    canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant _HatchPatternPainter oldDelegate) => oldDelegate.color != color;
}

class _SurveySheetPainter extends CustomPainter {
  final AppPalette palette;
  final int totalShares;
  final int allocatedShares;
  final Set<int> userIndices;
  final int selectedSharesCount;
  final bool isBangla;
  final bool isCompact;

  const _SurveySheetPainter({
    required this.palette,
    required this.totalShares,
    required this.allocatedShares,
    required this.userIndices,
    required this.selectedSharesCount,
    required this.isBangla,
    required this.isCompact,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final margin = isCompact ? 0.0 : 16.0;
    final gridWidth = size.width - (margin * 2);
    final cellSize = gridWidth / 10.0;

    final cellBorderPaint = Paint()
      ..color = palette.rule
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final hatchPaint = Paint()
      ..color = palette.inkTertiary.withValues(alpha: 0.5)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final userBgPaint = Paint()
      ..color = palette.pine
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = palette.brass
      ..style = PaintingStyle.fill;

    final availableBgPaint = Paint()
      ..color = palette.surface
      ..style = PaintingStyle.fill;

    final selectedBorderPaint = Paint()
      ..color = palette.pine
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw Margin Coordinates
    if (!isCompact) {
      final textStyle = TextStyle(
        fontFamily: 'serif',
        fontSize: 8.5,
        color: palette.inkTertiary,
        fontWeight: FontWeight.w600,
      );

      for (int i = 0; i < 10; i++) {
        final colLetter = String.fromCharCode(65 + i); // A-J
        final tpCol = TextPainter(
          text: TextSpan(text: colLetter, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        tpCol.paint(canvas, Offset(margin + (i * cellSize) + (cellSize - tpCol.width) / 2, 3));

        final rowNum = isBangla ? CurrencyFormatter.toBanglaDigits((i + 1).toString()) : '${i + 1}';
        final tpRow = TextPainter(
          text: TextSpan(text: rowNum, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        tpRow.paint(canvas, Offset(3, margin + (i * cellSize) + (cellSize - tpRow.height) / 2));
      }
    }

    // Draw 10x10 Shared Cells
    for (int index = 0; index < totalShares; index++) {
      final col = index % 10;
      final row = index ~/ 10;

      final rect = Rect.fromLTWH(
        margin + (col * cellSize),
        margin + (row * cellSize),
        cellSize,
        cellSize,
      );

      final isUserLot = userIndices.contains(index);
      final isAllocated = index < allocatedShares && !isUserLot;
      final isAvailable = index >= allocatedShares;
      final isSelected = isAvailable && (index < allocatedShares + selectedSharesCount);

      if (isUserLot) {
        canvas.drawRect(rect, userBgPaint);
        canvas.drawCircle(rect.center, 2.5, dotPaint);
      } else if (isAllocated) {
        canvas.drawRect(rect, availableBgPaint);
        canvas.save();
        canvas.clipRect(rect);
        for (double p = -cellSize; p < cellSize * 2; p += 4.0) {
          canvas.drawLine(
            Offset(rect.left + p, rect.bottom),
            Offset(rect.left + p + cellSize, rect.top),
            hatchPaint,
          );
        }
        canvas.restore();
      } else {
        canvas.drawRect(rect, availableBgPaint);
      }

      // Shared 1px hairline border
      canvas.drawRect(rect, cellBorderPaint);

      // Selected for investment indicator
      if (isSelected) {
        canvas.drawRect(rect.deflate(0.75), selectedBorderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SurveySheetPainter oldDelegate) {
    return oldDelegate.allocatedShares != allocatedShares ||
        oldDelegate.selectedSharesCount != selectedSharesCount ||
        oldDelegate.palette != palette ||
        oldDelegate.isBangla != isBangla;
  }
}
