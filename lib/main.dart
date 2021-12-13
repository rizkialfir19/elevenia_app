import 'dart:async';
import 'dart:developer';

import 'package:elevenia_app/app.dart';
import 'package:elevenia_app/core/client/local_storage/shared_preference_client.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Clients instantiation
  final BaseLocalStorageClient _localStorageClient =
      SharedPreferenceClient.instance;
  // final BaseDioClient _dioClient =
  //     // SharedPreferenceClient.instance;

  // Repositories instantiation
  // final BaseHomeRepository _homeRepository =
  // HomeRepository(
  //   localStorageClient: _localStorageClient,
  // );

  runZonedGuarded(
    () => runApp(
      App(
        // apiClient: _apiClient,
        // firebaseClient: _firebaseClient,
        localStorageClient: _localStorageClient,
        // authenticationRepository: _authenticationRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
