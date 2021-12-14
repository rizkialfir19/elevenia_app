import 'package:elevenia_app/common/common.dart';

class ProductList extends BaseModel {
  final String? productName;
  final String? productNo;
  final String? productSellQty;
  final String? categoryName;
  final String? categoryNameMid;
  final String? categoryNameRoot;
  final String? price;
  final String? stock;

  ProductList({
    this.productName,
    this.productNo,
    this.productSellQty,
    this.categoryName,
    this.categoryNameMid,
    this.categoryNameRoot,
    this.price,
    this.stock,
  }) : super({
          "prdNm": productName,
          "prdNo": productNo,
          "prdSelQty": productSellQty,
          "dispCtgrNm": categoryName,
          "dispCtgrNmMid": categoryNameMid,
          "dispCtgrNmRoot": categoryNameRoot,
          "selPrc": price,
          "stock": stock,
        });

  factory ProductList.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Null JSON provided');
    }

    return ProductList(
      productName: json['prdNm'],
      productNo: json['prdNo'],
      productSellQty: json['prdSelQty'],
      categoryName: json['dispCtgrNm'],
      categoryNameMid: json['dispCtgrNmMid'],
      categoryNameRoot: json['dispCtgrNmRoot'],
      price: json['selPrc'],
      stock: json['stock'],
    );
  }

  @override
  copyWith({
    String? productName,
    String? productNo,
    String? productSellQty,
    String? categoryName,
    String? categoryNameMid,
    String? categoryNameRoot,
    String? price,
    String? stock,
  }) {
    return ProductList(
      productName: productName ?? this.productName,
      productNo: productNo ?? this.productNo,
      productSellQty: productSellQty ?? this.productSellQty,
      categoryName: categoryName ?? this.categoryName,
      categoryNameMid: categoryNameMid ?? this.categoryNameMid,
      categoryNameRoot: categoryNameRoot ?? this.categoryNameRoot,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}
