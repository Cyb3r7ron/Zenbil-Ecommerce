import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenbil_two/inner_screens/brands_navigation_rail.dart';
//import 'package:zenbil_two/inner_screens/categories_feeds.dart';

void main() {
  testWidgets('brands navigation rail ...', (WidgetTester tester) async {
    BrandNavigationRailScreen connectComponent =
        new BrandNavigationRailScreen();
    var button = find.byType(Carousel);
    expect(find.text('Dell'), findsOneWidget);
    await tester.tap(button);
    expect(find.text('No products related to this brand'), findsOneWidget);
  });
}
