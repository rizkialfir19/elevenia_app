import 'package:bloc_test/bloc_test.dart';
import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

///Cubits
// class MockTabCubit extends MockCubit<BaseState> implements TabCubit {}

class MockProductDataCubit extends MockCubit<BaseState>
    implements ProductDataCubit {}

class MockProductActionCubit extends MockCubit<BaseState>
    implements ProductActionCubit {}

class MockCartCubit extends MockCubit<BaseState> implements CartCubit {}

///Fakes
class FakeBaseStateExampleData extends Fake implements BaseState<ProductList> {}

class FakeBaseState extends Fake implements BaseState {}
