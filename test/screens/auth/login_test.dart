import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:zenbil_two/screens/auth/login.dart';

void main() {
  testWidgets('empty email and password', (WidgetTester tester) async {
    LoginScreen connectComponent = new LoginScreen();
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    var button = find.byType(ButtonBar);
    expect(button, findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    await tester.tap(button);
    expect(find.text('Please enter a valid Password'), findsOneWidget);
  });
}
