import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/core/theme/app_radius.dart';
import 'package:swapnojatri/core/theme/app_typography.dart';
import 'package:swapnojatri/core/localization/currency_formatter.dart';

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
  int? _inspectedLotIndex;

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
                          final isAvailable = index >= widget.allocatedShares;

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
                                setState(() => _inspectedLotIndex = index);
                                widget.onLotTap?.call(index);

                                if (isAvailable && widget.onSelectShares != null) {
                                  final count = (index - widget.allocatedShares + 1).clamp(1, 4);
                                  widget.onSelectShares!(count);
                                }
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

          if (_inspectedLotIndex != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.surfaceSunken,
                borderRadius: AppRadius.borderChip,
                border: Border.all(color: palette.rule, width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBangla
                        ? 'লট নং: LOT-${(_inspectedLotIndex! + 1).toString().padLeft(3, '0')}'
                        : 'Lot Ref: LOT-${(_inspectedLotIndex! + 1).toString().padLeft(3, '0')}',
                    style: AppTypography.caption(isDark: isDark, isBangla: isBangla).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    userIndices.contains(_inspectedLotIndex!)
                        ? (isBangla ? 'আপনার মালিকানাধীন' : 'Your Ownership')
                        : (_inspectedLotIndex! < widget.allocatedShares
                            ? (isBangla ? 'অন্যান্য বিনিয়োগকারীর বরাদ্দ' : 'Allocated')
                            : (isBangla ? 'নির্বাচনযোগ্য (৳ ২৫,৫০০)' : 'Available (৳ 25,500)')),
                    style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
                      color: userIndices.contains(_inspectedLotIndex!)
                          ? palette.pine
                          : (_inspectedLotIndex! < widget.allocatedShares ? palette.inkTertiary : palette.jade),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            color: palette.inkSecondary,
            fontSize: 11.5,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${isBangla ? CurrencyFormatter.toBanglaDigits(count) : count})',
          style: AppTypography.micro(isDark: isDark, isBangla: isBangla).copyWith(
            color: palette.inkTertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SurveySheetPainter extends CustomPainter {
  final AppPalette palette;
  final int totalShares;
  final int allocatedShares;
  final Set<int> userIndices;
  final int selectedSharesCount;
  final bool isBangla;
  final bool isCompact;

  _SurveySheetPainter({
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
    final fieldSize = size.width - (margin * 2);
    final cellSize = fieldSize / 10;

    final rulePaint = Paint()
      ..color = palette.rule
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final outerFramePaint = Paint()
      ..color = palette.ruleStrong
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw Outer Frame
    canvas.drawRect(Rect.fromLTWH(margin, margin, fieldSize, fieldSize), outerFramePaint);

    if (!isCompact) {
      // Draw Margin Coordinate Letters (A-J) and Numbers (1-10)
      const cols = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
      final tickPaint = Paint()
        ..color = palette.inkTertiary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      for (int i = 0; i < 10; i++) {
        // Col Letters
        final colSpan = TextSpan(
          text: cols[i],
          style: TextStyle(
            color: palette.inkTertiary,
            fontSize: 8.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        );
        final colPainter = TextPainter(text: colSpan, textDirection: TextDirection.ltr)..layout();
        colPainter.paint(
          canvas,
          Offset(margin + (i * cellSize) + (cellSize / 2) - (colPainter.width / 2), 3),
        );

        // Row Numbers
        final rowSpan = TextSpan(
          text: (i + 1).toString(),
          style: TextStyle(
            color: palette.inkTertiary,
            fontSize: 8.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        );
        final rowPainter = TextPainter(text: rowSpan, textDirection: TextDirection.ltr)..layout();
        rowPainter.paint(
          canvas,
          Offset(3, margin + (i * cellSize) + (cellSize / 2) - (rowPainter.height / 2)),
        );

        // Boundary Ticks
        canvas.drawLine(
          Offset(margin + i * cellSize, margin - 3),
          Offset(margin + i * cellSize, margin),
          tickPaint,
        );
        canvas.drawLine(
          Offset(margin - 3, margin + i * cellSize),
          Offset(margin, margin + i * cellSize),
          tickPaint,
        );
      }
    }

    // Draw 10x10 Shared Cells
    for (int index = 0; index < totalShares; index++) {
      final col = index % 10;
      final row = index ~/ 10;

      final cellRect = Rect.fromLTWH(
        margin + (col * cellSize),
        margin + (row * cellSize),
        cellSize,
        cellSize,
      );

      final isUserLot = userIndices.contains(index);
      final isAllocated = index < allocatedShares && !isUserLot;
      final isSelectedInCalc = (index >= allocatedShares) && (index < allocatedShares + selectedSharesCount);

      if (isUserLot) {
        // YOURS: Pine Fill with Brass Corner Dot
        canvas.drawRect(cellRect, Paint()..color = palette.pine);
        canvas.drawRect(cellRect, rulePaint);

        // Brass corner dot
        canvas.drawCircle(
          Offset(cellRect.right - 3, cellRect.top + 3),
          1.8,
          Paint()..color = palette.brass,
        );

        if (!isCompact && cellSize >= 20) {
          final lotSpan = TextSpan(
            text: (index + 1).toString().padLeft(2, '0'),
            style: TextStyle(
              color: palette.canvas,
              fontSize: 8,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          );
          final lotPainter = TextPainter(text: lotSpan, textDirection: TextDirection.ltr)..layout();
          lotPainter.paint(
            canvas,
            Offset(cellRect.center.dx - lotPainter.width / 2, cellRect.center.dy - lotPainter.height / 2),
          );
        }
      } else if (isAllocated) {
        // ALLOCATED: 45° Hatch lines, no number
        canvas.drawRect(cellRect, Paint()..color = palette.surface);
        canvas.drawRect(cellRect, rulePaint);

        _drawCellHatch(canvas, cellRect, palette.inkTertiary.withValues(alpha: 0.22));
      } else if (isSelectedInCalc) {
        // SELECTED: Pine 1.5px border over surface with top-left corner tick
        canvas.drawRect(cellRect, Paint()..color = palette.surface);
        canvas.drawRect(
          cellRect,
          Paint()
            ..color = palette.pine
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );

        // Corner tick
        canvas.drawLine(cellRect.topLeft, Offset(cellRect.left + 4, cellRect.top), Paint()..color = palette.pine..strokeWidth = 2.0);
        canvas.drawLine(cellRect.topLeft, Offset(cellRect.left, cellRect.top + 4), Paint()..color = palette.pine..strokeWidth = 2.0);

        if (!isCompact && cellSize >= 20) {
          final lotSpan = TextSpan(
            text: (index + 1).toString().padLeft(2, '0'),
            style: TextStyle(
              color: palette.pine,
              fontSize: 8,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          );
          final lotPainter = TextPainter(text: lotSpan, textDirection: TextDirection.ltr)..layout();
          lotPainter.paint(
            canvas,
            Offset(cellRect.center.dx - lotPainter.width / 2, cellRect.center.dy - lotPainter.height / 2),
          );
        }
      } else {
        // AVAILABLE: Surface fill with 1px rule border and lot number in mapTick
        canvas.drawRect(cellRect, Paint()..color = palette.surface);
        canvas.drawRect(cellRect, rulePaint);

        if (!isCompact && cellSize >= 20) {
          final lotSpan = TextSpan(
            text: (index + 1).toString().padLeft(2, '0'),
            style: TextStyle(
              color: palette.inkTertiary,
              fontSize: 8,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w500,
            ),
          );
          final lotPainter = TextPainter(text: lotSpan, textDirection: TextDirection.ltr)..layout();
          lotPainter.paint(
            canvas,
            Offset(cellRect.center.dx - lotPainter.width / 2, cellRect.center.dy - lotPainter.height / 2),
          );
        }
      }
    }
  }

  void _drawCellHatch(Canvas canvas, Rect rect, Color hatchColor) {
    final hatchPaint = Paint()
      ..color = hatchColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.save();
    canvas.clipRect(rect);

    const pitch = 7.0;
    for (double d = -rect.height; d < rect.width + rect.height; d += pitch) {
      canvas.drawLine(
        Offset(rect.left + d, rect.bottom),
        Offset(rect.left + d + rect.height, rect.top),
        hatchPaint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SurveySheetPainter oldDelegate) {
    return oldDelegate.allocatedShares != allocatedShares ||
        oldDelegate.selectedSharesCount != selectedSharesCount ||
        oldDelegate.userIndices.length != userIndices.length ||
        oldDelegate.palette != palette;
  }
}

class _HatchPatternPainter extends CustomPainter {
  final Color color;

  _HatchPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (double d = -size.height; d < size.width + size.height; d += 4.0) {
      canvas.drawLine(Offset(d, size.height), Offset(d + size.height, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HatchPatternPainter oldDelegate) => oldDelegate.color != color;
}

// Backward compatibility alias for ShareGridMatrixWidget
typedef ShareGridMatrixWidget = LotMapWidget;
