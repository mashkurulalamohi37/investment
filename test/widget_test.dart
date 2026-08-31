import 'package:flutter_test/flutter_test.dart';
import 'package:swapnojatri/main.dart';

void main() {
  testWidgets('Swapnojatri app smoke & flow test', (WidgetTester tester) async {
    await tester.pumpWidget(const SwapnojatriApp());
    expect(find.byType(SwapnojatriApp), findsOneWidget);

    // Fast-forward past splash and onboarding animations
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
