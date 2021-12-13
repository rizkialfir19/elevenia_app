import 'dart:async';

import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/bloc/app_setup/app_setup.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<BaseState> {
  final AppSetupCubit appSetupCubit;

  late StreamSubscription appSetupCubitSubs;

  AuthenticationCubit({
    required this.appSetupCubit,
  }) : super(InitializedState()) {
    appSetupCubitSubs = appSetupCubit.stream.listen((state) {
      if (state == AppSetupState.success) {
        initialize();
      }
    });
  }

  /// Initialize Authenticated or UnAuthenticated
  void initialize() async {
    debugPrint("---> Enter initialize authDataCubit");

    try {
      emit(UnauthenticatedState());
    } catch (e) {
      emit(UnauthenticatedState());
      return;
    }
  }
}
