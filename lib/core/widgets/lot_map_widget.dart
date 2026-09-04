import 'dart:math' as math;
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
  void _showLotInspectionModal(
    BuildContext context,
    int index,
    AppPalette palette,
    bool isDark,
    bool isBangla,
    Set<int> userIndices,
  ) {
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
                  height: 3.5,
                  decoration: BoxDecoration(
                    color: palette.ruleStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Header: Lot Title & Coordinates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isBangla ? 'চিহ্নিত ভূমি অংশ: লট-$lotNo' : 'Surveyed Parcel: LOT-$lotNo',
                        style: AppTypography.titleLarge(isDark: isDark, isBangla: isBangla).copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isBangla
                            ? 'ম্যাপ স্থানাঙ্ক: কলাম $colLetter, সারি $row • দাগ নং ৪১৮'
                            : 'Grid Coord: Col $colLetter, Row $row • RS Plot #418',
                        style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkSecondary,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  if (isUserLot)
                    SealWidget(size: 36, isBangla: isBangla)
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
                          fontFamily: isBangla ? null : 'monospace',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isAvailable ? palette.pine : palette.inkSecondary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(height: 1, color: palette.rule),
              const SizedBox(height: 14),

              // Share & Profit-Sharing Specifications Table
              Container(
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderCard,
                  border: Border.all(color: palette.rule, width: 1.0),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _detailRow(isBangla ? 'শেয়ার ইকুইটি অংশ' : 'Share Equity', isBangla ? '১.০% মোট লভ্যাংশ অংশীদারিত্ব' : '1.0% Total Profit Equity', palette, isDark),
                    Divider(height: 16, color: palette.rule),
                    _detailRow(isBangla ? 'নির্ধারিত ইউনিট মূল্য' : 'Fixed Unit Value', isBangla ? '৳ ২৫,৫০০ / ভাগ' : '৳ 25,500 / Share', palette, isDark),
                    Divider(height: 16, color: palette.rule),
                    _detailRow(isBangla ? 'লভ্যাংশ বণ্টন পদ্ধতি' : 'Payout Distribution', isBangla ? 'সরাসরি ব্যাংক / মোবাইল ওয়ালেট' : 'Direct Bank / Mobile Wallet', palette, isDark),
                    Divider(height: 16, color: palette.rule),
                    _detailRow(
                      isBangla ? 'শেয়ার স্ট্যাটাস' : 'Status',
                      isUserLot
                          ? (isBangla ? 'আপনার সক্রিয় বিনিয়োগকৃত শেয়ার' : 'Your Subscribed Share')
                          : (isAllocated
                              ? (isBangla ? 'বিনিয়োগকারী কর্তৃক সংরক্ষিত' : 'Allocated Investor Share')
                              : (isBangla ? 'বিনিয়োগের জন্য উন্মুক্ত' : 'Available for Subscription')),
                      palette,
                      isDark,
                      highlight: isUserLot,
                    ),
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
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: palette.surfaceSunken,
          child: CustomPaint(
            painter: _ArchitecturalSurveyPainter(
              palette: palette,
              totalShares: widget.totalShares,
              allocatedShares: widget.allocatedShares,
              userIndices: userIndices,
              selectedSharesCount: widget.selectedSharesCount,
              isBangla: isBangla,
              isCompact: true,
              isDark: isDark,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.borderCard,
        border: Border.all(color: palette.rule, width: 1.0),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cadastral Header & Architectural Compass Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: palette.pine,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            isBangla ? 'প্লট ৪১৮ — ১০০টি চিহ্নিত অংশ' : 'Plot 418 — 100 Surveyed Lots',
                            style: AppTypography.titleMedium(isDark: isDark, isBangla: isBangla).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isBangla
                          ? 'মৌজা: বিরুলিয়া • আরএস খতিয়ান ৯০২ • সাভার'
                          : 'Mouza: Birulia • RS Khatian #902 • Savar',
                      style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                        color: palette.inkSecondary,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Compass & Coordinate Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: palette.surfaceSunken,
                  borderRadius: AppRadius.borderChip,
                  border: Border.all(color: palette.ruleStrong, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.explore_outlined, size: 12, color: palette.pine),
                    const SizedBox(width: 4),
                    Text(
                      isBangla ? 'উত্তরমুখী ↑' : 'N 23.85° ↑',
                      style: TextStyle(
                        fontFamily: isBangla ? null : 'monospace',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: palette.pineDeep,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 2. The Architectural Cadastral Canvas
          LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth;
              const margin = 20.0;
              final fieldSize = size - (margin * 2);

              return Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121613) : const Color(0xFFF3F6F1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: palette.ruleStrong, width: 0.8),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: size,
                      height: size,
                      child: CustomPaint(
                        painter: _ArchitecturalSurveyPainter(
                          palette: palette,
                          totalShares: widget.totalShares,
                          allocatedShares: widget.allocatedShares,
                          userIndices: userIndices,
                          selectedSharesCount: widget.selectedSharesCount,
                          isBangla: isBangla,
                          isCompact: false,
                          isDark: isDark,
                        ),
                      ),
                    ),
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
                            crossAxisSpacing: 1.2,
                            mainAxisSpacing: 1.2,
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
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(2.5),
                                  splashColor: palette.pine.withValues(alpha: 0.25),
                                  highlightColor: palette.pine.withValues(alpha: 0.15),
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    widget.onLotTap?.call(index);
                                    _showLotInspectionModal(context, index, palette, isDark, isBangla, userIndices);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // 3. Cadastral Scale & Plot Note
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 2,
                      decoration: BoxDecoration(
                        color: palette.inkTertiary,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        isBangla ? '১ ঘর = ১/১০০ অংশ (১ কাঠা)' : '1 cell = 1/100 share (1 Katha)',
                        style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                          color: palette.inkTertiary,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isBangla ? 'স্পর্শ করে দেখুন' : 'Tap to inspect',
                style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                  color: palette.pine,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(height: 1, color: palette.rule),
          const SizedBox(height: 10),

          // 4. Elegant Interactive Legend Bar
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            spacing: 12,
            children: [
              _legendItem(
                box: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: palette.ruleStrong, width: 1.0),
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
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF222B24) : const Color(0xFFE2E8E0),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: palette.ruleStrong, width: 0.8),
                  ),
                  child: CustomPaint(painter: _SubtleMicroHatchPainter(color: palette.inkTertiary)),
                ),
                label: isBangla ? 'বরাদ্দকৃত' : 'Allocated',
                count: '${widget.allocatedShares - userIndices.length}',
                palette: palette,
                isDark: isDark,
                isBangla: isBangla,
              ),
              _legendItem(
                box: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [palette.pine, palette.pineDeep],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: palette.pine.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 3.5,
                      height: 3.5,
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
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ],
    );
  }
}

class _SubtleMicroHatchPainter extends CustomPainter {
  final Color color;
  const _SubtleMicroHatchPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 0.75
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width / 2, 0), paint);
    canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant _SubtleMicroHatchPainter oldDelegate) => oldDelegate.color != color;
}

class _ArchitecturalSurveyPainter extends CustomPainter {
  final AppPalette palette;
  final int totalShares;
  final int allocatedShares;
  final Set<int> userIndices;
  final int selectedSharesCount;
  final bool isBangla;
  final bool isCompact;
  final bool isDark;

  const _ArchitecturalSurveyPainter({
    required this.palette,
    required this.totalShares,
    required this.allocatedShares,
    required this.userIndices,
    required this.selectedSharesCount,
    required this.isBangla,
    required this.isCompact,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);

    final margin = isCompact ? 0.0 : 20.0;
    final maxGridDimension = isCompact
        ? math.min(size.width, size.height)
        : (size.width - (margin * 2));
    final cellSize = maxGridDimension / 10.0;
    const gap = 1.2;

    final startX = isCompact ? (size.width - (cellSize * 10)) / 2 : margin;
    final startY = isCompact ? (size.height - (cellSize * 10)) / 2 : margin;

    // Corner crosshair registration markers (Architectural Blueprint Style)
    if (!isCompact) {
      final crosshairPaint = Paint()
        ..color = palette.ruleStrong
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;

      final pts = [
        Offset(startX - 6, startY - 6),
        Offset(startX + (cellSize * 10) + 6, startY - 6),
        Offset(startX - 6, startY + (cellSize * 10) + 6),
        Offset(startX + (cellSize * 10) + 6, startY + (cellSize * 10) + 6),
      ];

      for (var pt in pts) {
        canvas.drawLine(Offset(pt.dx - 3, pt.dy), Offset(pt.dx + 3, pt.dy), crosshairPaint);
        canvas.drawLine(Offset(pt.dx, pt.dy - 3), Offset(pt.dx, pt.dy + 3), crosshairPaint);
      }

      // Axis Labels (A-J on top, 1-10 on left)
      final textStyle = TextStyle(
        fontFamily: isBangla ? null : 'monospace',
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
        tpCol.paint(canvas, Offset(startX + (i * cellSize) + (cellSize - tpCol.width) / 2, startY - 14));

        final rowNum = isBangla ? CurrencyFormatter.toBanglaDigits((i + 1).toString()) : '${i + 1}';
        final tpRow = TextPainter(
          text: TextSpan(text: rowNum, style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        tpRow.paint(canvas, Offset(startX - 15, startY + (i * cellSize) + (cellSize - tpRow.height) / 2));
      }
    }

    // Cell Paint definitions
    final availableFill = Paint()
      ..color = palette.surface
      ..style = PaintingStyle.fill;

    final allocatedFill = Paint()
      ..color = isDark ? const Color(0xFF202722) : const Color(0xFFE3E8E1)
      ..style = PaintingStyle.fill;

    final cellBorderPaint = Paint()
      ..color = isDark ? const Color(0xFF2C352E) : const Color(0xFFD4DBD0)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    final microHatchPaint = Paint()
      ..color = palette.inkTertiary.withValues(alpha: 0.35)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = palette.brass
      ..style = PaintingStyle.fill;

    final dotRingPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 0.75
      ..style = PaintingStyle.stroke;

    final selectedBorderPaint = Paint()
      ..color = palette.pine
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final selectedFillPaint = Paint()
      ..color = palette.pineTint.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    // Draw 10x10 Shared Cells
    for (int index = 0; index < totalShares; index++) {
      final col = index % 10;
      final row = index ~/ 10;

      final cellRect = Rect.fromLTWH(
        startX + (col * cellSize) + (gap / 2),
        startY + (row * cellSize) + (gap / 2),
        cellSize - gap,
        cellSize - gap,
      );

      final rrect = RRect.fromRectAndRadius(cellRect, const Radius.circular(2.5));

      final isUserLot = userIndices.contains(index);
      final isAllocated = index < allocatedShares && !isUserLot;
      final isAvailable = index >= allocatedShares;
      final isSelected = isAvailable && (index < allocatedShares + selectedSharesCount);

      if (isUserLot) {
        // Deep emerald gradient fill
        final gradient = LinearGradient(
          colors: [palette.pine, palette.pineDeep],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
        final userPaint = Paint()
          ..shader = gradient.createShader(cellRect)
          ..style = PaintingStyle.fill;

        canvas.drawRRect(rrect, userPaint);

        // Gold center pip with ring
        final center = cellRect.center;
        canvas.drawCircle(center, isCompact ? 1.5 : 2.5, dotPaint);
        if (!isCompact) {
          canvas.drawCircle(center, 4.2, dotRingPaint);
        }
      } else if (isAllocated) {
        // Muted archival survey tile with fine micro-hatching
        canvas.drawRRect(rrect, allocatedFill);
        canvas.save();
        canvas.clipRRect(rrect);
        final step = isCompact ? 3.0 : 3.5;
        for (double p = -cellSize; p < cellSize * 2; p += step) {
          canvas.drawLine(
            Offset(cellRect.left + p, cellRect.bottom),
            Offset(cellRect.left + p + cellSize, cellRect.top),
            microHatchPaint,
          );
        }
        canvas.restore();
        canvas.drawRRect(rrect, cellBorderPaint);
      } else {
        // Available Parcel
        if (isSelected) {
          canvas.drawRRect(rrect, selectedFillPaint);
          canvas.drawRRect(rrect, selectedBorderPaint);
        } else {
          canvas.drawRRect(rrect, availableFill);
          canvas.drawRRect(rrect, cellBorderPaint);
        }
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArchitecturalSurveyPainter oldDelegate) {
    return oldDelegate.allocatedShares != allocatedShares ||
        oldDelegate.selectedSharesCount != selectedSharesCount ||
        oldDelegate.palette != palette ||
        oldDelegate.isBangla != isBangla ||
        oldDelegate.isDark != isDark;
  }
}
