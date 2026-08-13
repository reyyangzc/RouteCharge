import 'package:flutter_test/flutter_test.dart';
import 'package:routecharge_mobile/main.dart';

void main() {
  testWidgets('App launches with splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RouteChargeApp());
    expect(find.text('RouteCharge'), findsOneWidget);
  });
}
