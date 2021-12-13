import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Base class for all model in the application
abstract class BaseModel extends Equatable {
  @protected
  final Map<String, dynamic> $data;

  BaseModel(this.$data);

  @override
  List<Object?> get props => [];

  /// json converter
  Map<String, dynamic> toJson({Iterable<String> excludes = const []}) =>
      Map.from($data)..removeWhere((key, _) => excludes.contains(key));

  /// copyWith converter
  copyWith();
}
