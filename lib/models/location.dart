import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

@freezed
class Locate with _$Locate {
  const factory Locate({
    @Default('') String name,
    @Default(0) double lat,
    @Default(0) double lng,
  }) = _Locate;
}
