// ============================================================
//  WIDGET TEST  =  test what is on the screen
// ============================================================
//
// Run it with:   flutter test test/widget_test.dart
//
// Steps:
//   1. tester.pumpWidget(...)  -> show the widget
//   2. find.text('...')        -> look for something
//   3. expect(..., findsOneWidget)  -> check it is there
//   4. tester.tap(...) + pump  -> press a button and refresh

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// A tiny screen we will test: a number and a button that adds 1.
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('$count'),
            ElevatedButton(
              onPressed: () => setState(() => count++),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('shows 0 at the start', (tester) async {
    // 1. show the screen
    await tester.pumpWidget(const CounterScreen());

    // 2 + 3. the number 0 should be on screen
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('tapping Add changes 0 to 1', (tester) async {
    await tester.pumpWidget(const CounterScreen());

    // 4. tap the button, then refresh the screen
    await tester.tap(find.text('Add'));
    await tester.pump();

    // now it should show 1, not 0
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}
