import 'package:financial_chart/financial_chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('does not start a disposed value viewport animation', (
    tester,
  ) async {
    final viewPort = GValueViewPort(
      valuePrecision: 2,
      initialStartValue: 0,
      initialEndValue: 1,
      animationMilliseconds: 20,
    );
    viewPort.initializeAnimation(tester);

    viewPort.animateToRange(GRange.range(10, 20), true, true);
    viewPort.dispose();

    await tester.pump(const Duration(milliseconds: 20));
  });

  testWidgets('ignores a superseded value viewport animation', (tester) async {
    final viewPort = GValueViewPort(
      valuePrecision: 2,
      initialStartValue: 0,
      initialEndValue: 1,
      animationMilliseconds: 20,
    );
    viewPort.initializeAnimation(tester);
    var finishedCount = 0;

    await tester.pump();
    viewPort.animateToRange(
      GRange.range(10, 20),
      true,
      true,
      onFinished: () => finishedCount++,
    );
    viewPort.animateToRange(
      GRange.range(20, 30),
      true,
      true,
      onFinished: () => finishedCount++,
    );

    try {
      await tester.pumpAndSettle();
      expect(finishedCount, 1);
      expect(viewPort.range, GRange.range(20, 30));
    } finally {
      viewPort.dispose();
    }
  });

  testWidgets('does not start a disposed point viewport animation', (
    tester,
  ) async {
    final viewPort = GPointViewPort(
      initialStartPoint: 0,
      initialEndPoint: 1,
      animationMilliseconds: 20,
    );
    viewPort.initializeAnimation(tester);

    viewPort.animateToRange(GRange.range(10, 20), true, true);
    viewPort.dispose();

    await tester.pump(const Duration(milliseconds: 20));
  });
}
