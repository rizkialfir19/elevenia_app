import 'package:elevenia_app/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSetupCubit extends Cubit<AppSetupState> {
  AppSetupCubit() : super(AppSetupState.uninitialized);

  /// Initialize all setups that required by the application
  void initialize() async {
    try {
      // await firebaseClient.initializeApp();
      // await firebaseClient.initializeAuth();

      await Future.delayed(const Duration(seconds: 2));

      emit(AppSetupState.success);
    } catch (e) {
      emit(AppSetupState.failed);
    }
  }
}
