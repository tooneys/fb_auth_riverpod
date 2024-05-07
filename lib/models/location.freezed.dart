// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Locate {
  String get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocateCopyWith<Locate> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocateCopyWith<$Res> {
  factory $LocateCopyWith(Locate value, $Res Function(Locate) then) =
      _$LocateCopyWithImpl<$Res, Locate>;
  @useResult
  $Res call({String name, double lat, double lng});
}

/// @nodoc
class _$LocateCopyWithImpl<$Res, $Val extends Locate>
    implements $LocateCopyWith<$Res> {
  _$LocateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocateCopyWith<$Res> implements $LocateCopyWith<$Res> {
  factory _$$_LocateCopyWith(_$_Locate value, $Res Function(_$_Locate) then) =
      __$$_LocateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double lat, double lng});
}

/// @nodoc
class __$$_LocateCopyWithImpl<$Res>
    extends _$LocateCopyWithImpl<$Res, _$_Locate>
    implements _$$_LocateCopyWith<$Res> {
  __$$_LocateCopyWithImpl(_$_Locate _value, $Res Function(_$_Locate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_$_Locate(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_Locate implements _Locate {
  const _$_Locate({this.name = '', this.lat = 0, this.lng = 0});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double lat;
  @override
  @JsonKey()
  final double lng;

  @override
  String toString() {
    return 'Locate(name: $name, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Locate &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocateCopyWith<_$_Locate> get copyWith =>
      __$$_LocateCopyWithImpl<_$_Locate>(this, _$identity);
}

abstract class _Locate implements Locate {
  const factory _Locate(
      {final String name, final double lat, final double lng}) = _$_Locate;

  @override
  String get name;
  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(ignore: true)
  _$$_LocateCopyWith<_$_Locate> get copyWith =>
      throw _privateConstructorUsedError;
}
