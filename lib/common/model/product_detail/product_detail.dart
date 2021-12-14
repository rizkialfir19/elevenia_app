import 'package:elevenia_app/common/common.dart';

class ProductDetail extends BaseModel {
  final String? productName;
  final String? productNo;
  final String? productDetail;
  final String? productSellQty;
  final String? sellerProductCd;
  final String? price;
  final String? stock;

  ProductDetail({
    this.productName,
    this.productNo,
    this.productDetail,
    this.productSellQty,
    this.sellerProductCd,
    this.price,
    this.stock,
  }) : super({
          "prdNm": productName,
          "prdNo": productNo,
          "htmlDetail": productDetail,
          "prdSelQty": productSellQty,
          "sellerPrdCd": sellerProductCd,
          "selPrc": price,
          "stock": stock,
        });

  factory ProductDetail.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Null JSON provided');
    }

    return ProductDetail(
      productName: json['prdNm'],
      productNo: json['prdNo'],
      productDetail: json['htmlDetail'],
      productSellQty: json['prdSelQty'],
      sellerProductCd: json['sellerPrdCd'],
      price: json['selPrc'],
      stock: json['stock'],
    );
  }

  @override
  copyWith({
    String? productName,
    String? productNo,
    String? productDetail,
    String? productSellQty,
    String? categoryName,
    String? categoryNameMid,
    String? categoryNameRoot,
    String? price,
    String? stock,
  }) {
    return ProductDetail(
      productName: productName ?? this.productName,
      productNo: productNo ?? this.productNo,
      productDetail: productDetail ?? this.productDetail,
      productSellQty: productSellQty ?? this.productSellQty,
      sellerProductCd: sellerProductCd ?? this.sellerProductCd,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}
