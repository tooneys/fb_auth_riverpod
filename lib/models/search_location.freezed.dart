// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchLocate {
  Locate? get loc => throw _privateConstructorUsedError;
  double get km => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchLocateCopyWith<SearchLocate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchLocateCopyWith<$Res> {
  factory $SearchLocateCopyWith(
          SearchLocate value, $Res Function(SearchLocate) then) =
      _$SearchLocateCopyWithImpl<$Res, SearchLocate>;
  @useResult
  $Res call({Locate? loc, double km});

  $LocateCopyWith<$Res>? get loc;
}

/// @nodoc
class _$SearchLocateCopyWithImpl<$Res, $Val extends SearchLocate>
    implements $SearchLocateCopyWith<$Res> {
  _$SearchLocateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = freezed,
    Object? km = null,
  }) {
    return _then(_value.copyWith(
      loc: freezed == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Locate?,
      km: null == km
          ? _value.km
          : km // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocateCopyWith<$Res>? get loc {
    if (_value.loc == null) {
      return null;
    }

    return $LocateCopyWith<$Res>(_value.loc!, (value) {
      return _then(_value.copyWith(loc: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SearchLocateCopyWith<$Res>
    implements $SearchLocateCopyWith<$Res> {
  factory _$$_SearchLocateCopyWith(
          _$_SearchLocate value, $Res Function(_$_SearchLocate) then) =
      __$$_SearchLocateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Locate? loc, double km});

  @override
  $LocateCopyWith<$Res>? get loc;
}

/// @nodoc
class __$$_SearchLocateCopyWithImpl<$Res>
    extends _$SearchLocateCopyWithImpl<$Res, _$_SearchLocate>
    implements _$$_SearchLocateCopyWith<$Res> {
  __$$_SearchLocateCopyWithImpl(
      _$_SearchLocate _value, $Res Function(_$_SearchLocate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = freezed,
    Object? km = null,
  }) {
    return _then(_$_SearchLocate(
      loc: freezed == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Locate?,
      km: null == km
          ? _value.km
          : km // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_SearchLocate implements _SearchLocate {
  const _$_SearchLocate({this.loc, this.km = 0.0});

  @override
  final Locate? loc;
  @override
  @JsonKey()
  final double km;

  @override
  String toString() {
    return 'SearchLocate(loc: $loc, km: $km)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchLocate &&
            (identical(other.loc, loc) || other.loc == loc) &&
            (identical(other.km, km) || other.km == km));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loc, km);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchLocateCopyWith<_$_SearchLocate> get copyWith =>
      __$$_SearchLocateCopyWithImpl<_$_SearchLocate>(this, _$identity);
}

abstract class _SearchLocate implements SearchLocate {
  const factory _SearchLocate({final Locate? loc, final double km}) =
      _$_SearchLocate;

  @override
  Locate? get loc;
  @override
  double get km;
  @override
  @JsonKey(ignore: true)
  _$$_SearchLocateCopyWith<_$_SearchLocate> get copyWith =>
      throw _privateConstructorUsedError;
}
