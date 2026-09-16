import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wedding/main.dart';
import 'package:wedding/widgets/invitation.dart';

void main() {
  testWidgets('opens the invitation directly', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(InvitationView), findsOneWidget);
    expect(find.text('Thực & Yến'), findsOneWidget);
    expect(find.text('Xác nhận tham dự'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
