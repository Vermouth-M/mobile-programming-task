import 'package:flutter_test/flutter_test.dart';
import 'package:pahlawan_nasional/main.dart';

void main() {
  testWidgets('PahlawanNasionalApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PahlawanNasionalApp());
    expect(find.text('Pahlawan Nasional'), findsOneWidget);
  });
}
