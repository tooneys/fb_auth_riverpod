import 'package:freezed_annotation/freezed_annotation.dart';

import 'location.dart';

part 'search_location.freezed.dart';

@freezed
class SearchLocate with _$SearchLocate {
  const factory SearchLocate({
    Locate? loc,
    @Default(0.0) double km,
  }) = _SearchLocate;
}
