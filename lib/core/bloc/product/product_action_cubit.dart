import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductActionCubit extends Cubit<BaseState> {
  final BaseLocalStorageClient localStorageClient;
  final BaseProductRepository productRepository;

  ProductActionCubit({
    required this.localStorageClient,
    required this.productRepository,
  }) : super(InitializedState());

  /// Get & Parse Product List from API
  void loadMore({
    required List<ProductList> lastResult,
    required String page,
  }) async {
    emit(LoadingState());

    await Future.delayed(const Duration(seconds: 1));

    List<ProductList> _results = [];

    /// Get list product from repository
    try {
      _results = await productRepository.getProductList(
        page: page,
      );

      if (_results.isEmpty) {
        emit(EmptyState());
        return;
      }
    } catch (e, s) {
      debugPrint("===> Error $e");
      debugPrint("===> Error $s");
      emit(
        ErrorState(
          error: '$this - Get LoadMore List Product Data] - Error : $e',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    /// Dump results data
    for (int i = 0; i < lastResult.length; i++) {
      _results.insert(i, lastResult[i]);
    }

    /// All validate pass
    emit(
      LoadedState(
        data: _results,
        timestamp: DateTime.now(),
      ),
    );
  }
}
