// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calc/main.dart';

void main() {

  testWidgets("Height Only Entered", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byKey(Key('height')), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.enterText(find.byKey(Key('height')), '1');
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Please enter the required value!'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

  });
  testWidgets("Height & Weight Entered", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byKey(Key('height')), findsOneWidget);
    expect(find.byKey(Key('weight')), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.enterText(find.byKey(Key('height')), '1');
    await tester.enterText(find.byKey(Key('weight')), '1');
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text(''), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
