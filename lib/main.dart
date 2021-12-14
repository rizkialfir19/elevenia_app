import 'dart:async';
import 'dart:developer';

import 'package:elevenia_app/app.dart';
import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/client/local_storage/shared_preference_client.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Clients instantiation
  final BaseLocalStorageClient _localStorageClient =
      SharedPreferenceClient.instance;
  final BaseApiClient _apiClient = DioClient.instance;

  /// Change Base Url Here
  final String _baseUrl = EnvConfig.BASE_PROD_URL;

  // Repositories instantiation
  final BaseProductRepository _productRepository = ProductRepository(
    baseUrl: _baseUrl,
    apiClient: _apiClient,
  );

  runZonedGuarded(
    () => runApp(
      App(
        //Client
        apiClient: _apiClient,
        localStorageClient: _localStorageClient,
        //Repository
        productRepository: _productRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
