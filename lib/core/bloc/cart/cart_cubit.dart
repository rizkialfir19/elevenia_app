import 'dart:convert';

import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;

  CartCubit({required this.localStorageClient}) : super(InitializedState());

  Future<void> addCartData({
    required ProductList data,
  }) async {
    /// Save to local storage
    try {
      List<ProductList> _tempData = [];
      String? _rawTempData;
      print("----> Data: $data");
      print("----> tempData before: $_tempData");

      _rawTempData = await localStorageClient.getByKey(
        SharedPrefKey.cartData,
        SharedPrefType.string,
      );

      print("----> rawData before: $_rawTempData");

      if (_rawTempData != null) {
        _tempData.add(ProductList.fromJson(jsonDecode(_rawTempData)));
        print("----> tempData after 1: $_tempData");
      }

      _tempData.add(data);
      _tempData.add(data);
      print("----> tempData after 2: $_tempData");

      await localStorageClient.saveByKey(
        jsonEncode(data.toJson()),
        SharedPrefKey.cartData,
        SharedPrefType.string,
      );
    } catch (e, s) {
      debugPrint("---> e: $e");
      debugPrint("---> s: $s");
      emit(
        ErrorState(error: "Terjadi kesalahan saat menyimpan data"),
      );

      return;
    }
  }
}
