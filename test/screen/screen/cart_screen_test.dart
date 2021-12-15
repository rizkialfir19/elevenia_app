import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductDataCubit>.value(
            value: productDataCubit,
          ),
          BlocProvider<ProductActionCubit>.value(
            value: productActionCubit,
          ),
          BlocProvider<CartCubit>.value(
            value: cartCubit,
          ),
        ],
        child: const MaterialApp(
          home: CartView(),
        ),
      ),
    );
  }

  group("cart_screen.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render CartScreen - Then: Success',
          (WidgetTester tester) async {
        when(() => productDataCubit.state).thenReturn(
          LoadedState(),
        );

        when(() => cartCubit.state).thenReturn(
          LoadedState(),
        );

        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(CartView),
          findsOneWidget,
        );
      });
    });
  });
}
