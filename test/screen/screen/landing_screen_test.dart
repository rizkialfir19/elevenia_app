import 'package:elevenia_app/ui/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocktail/mocktail.dart' as mocktail;

void main() {
  late mocktail.MockProductDataCubit productDataCubit;
  late mocktail.MockProductActionCubit productActionCubit;
  late mocktail.MockCartCubit cartCubit;

  setUpAll(() {
    registerFallbackValue(mocktail.FakeBaseState());

    productDataCubit = mocktail.MockProductDataCubit();
    productActionCubit = mocktail.MockProductActionCubit();
    cartCubit = mocktail.MockCartCubit();
  });

  Future pumpScreenWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LandingScreen(),
      ),
    );
  }

  group("landing_screen.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render LandingScreen - Then: Success',
          (WidgetTester tester) async {
        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(LandingScreen),
          findsOneWidget,
        );
      });
    });
  });
}
