import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

part 'product_repository.dart';

abstract class BaseProductRepository {
  Future<List<ProductList>> getProductList({
    required String page,
  });

  Future<ProductDetail> getProductDetail({
    required String productNo,
  });
}
