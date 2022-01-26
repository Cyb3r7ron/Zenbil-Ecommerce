import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenbil_two/screens/cart/cart.dart';
import 'package:zenbil_two/screens/cart/cart_empty.dart';

void main() {
  testWidgets('cart empty ...', (tester) async {
    CartScreen connectComponent = new CartScreen();
    var textField = find.byType(TextField);
    expect(find.text('Looks Like You didn\'t \n add anything to your cart yet'),
        findsOneWidget);
    var button = find.text('Shop now');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
  });
}
