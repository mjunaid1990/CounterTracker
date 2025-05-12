import 'package:flutter/material.dart';
import 'package:flutter_counter/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Find the increment button and tap it.
    final increaseFinder = find.byIcon(Icons.add);
    await tester.tap(increaseFinder);
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    // Find the reset button and tap it.
    final resetFinder = find.byIcon(Icons.refresh);
    await tester.tap(resetFinder);
    await tester.pump();

    // Verify that our counter is back to 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
