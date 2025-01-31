import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart'; // Ensure MyApp is imported

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the counter starts at 0.
    expect(find.text('0'), findsOneWidget);  // Look for '0' on the screen
    expect(find.text('1'), findsNothing);   // Ensure '1' is not shown yet

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));  // Find the add button and tap it
    await tester.pump();  // Rebuild the widget to reflect the change

    // Verify that the counter has incremented.
    expect(find.text('0'), findsNothing);     // Ensure '0' is no longer on the screen
    expect(find.text('1'), findsOneWidget);  // Ensure '1' is now visible
  });
}
