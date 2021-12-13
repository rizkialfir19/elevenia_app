import 'package:elevenia_app/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for handling tab interaction
/// We can add more logic as the user tap the tab
class TabCubit extends Cubit<AppTab> {
  TabCubit() : super(AppTab.home);

  /// Change tab
  void changeTab({
    required AppTab tab,
  }) {
    emit(tab);
  }
}
