import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDataCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;
  final BaseProductRepository productRepository;

  ProductDataCubit({
    required this.localStorageClient,
    required this.productRepository,
  }) : super(InitializedState());

  /// Get List of Product
  void getData({
    required String page,
  }) async {
    emit(LoadingState());

    List<ProductList> _results = [];

    /// Get data from repository
    try {
      _results = await productRepository.getProductList(page: page);

      if (_results.isEmpty) {
        emit(EmptyState());
        return;
      }
    } catch (e, s) {
      debugPrint("===> Error $e");
      debugPrint("===> Error $s");
      emit(
        ErrorState(
          error: '$this - Get List Product Data] - Error : $e',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    /// All validate pass
    emit(
      LoadedState(
        data: _results,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Get Detail of Product
  void getDetail({
    required String productNo,
  }) async {
    emit(LoadingState());

    ProductDetail? _result;

    /// Get data from repository
    try {
      _result = await productRepository.getProductDetail(productNo: productNo);
    } catch (e, s) {
      debugPrint("===> Error $e");
      debugPrint("===> Error $s");
      emit(
        ErrorState(
          error: '$this - Get Detail Product Data] - Error : $e',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    /// All validate pass
    emit(
      LoadedState(
        data: _result,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Update Current Data from Action loadMore
  void dumpData({
    required List<ProductList> data,
  }) async {
    emit(
      LoadedState(data: data),
    );
  }
}
