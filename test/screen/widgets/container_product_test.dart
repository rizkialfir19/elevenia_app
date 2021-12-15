import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future pumpScreenWidget(WidgetTester tester) async {
    ProductList _dummyData = ProductList(
      productName: "This is Name",
      price: "10000",
      productSellQty: "3314",
      stock: "23",
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerProduct(
          productData: _dummyData,
        ),
      ),
    );
  }

  group("container_product.dart", () {
    group("Given: Example - No Exception", () {
      testWidgets('When: Render ContainerProductWidget - Then: Success',
          (WidgetTester tester) async {
        await pumpScreenWidget(tester);

        await expectLater(
          find.byType(ContainerProduct),
          findsOneWidget,
        );
      });
    });
  });
}
