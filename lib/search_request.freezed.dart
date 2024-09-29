// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) {
  return _SearchRequest.fromJson(json);
}

/// @nodoc
mixin _$SearchRequest {
  String get query => throw _privateConstructorUsedError;
  bool get useAdvanced => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  bool get epub => throw _privateConstructorUsedError;
  bool get pdf => throw _privateConstructorUsedError;

  /// Serializes this SearchRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchRequestCopyWith<SearchRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchRequestCopyWith<$Res> {
  factory $SearchRequestCopyWith(
          SearchRequest value, $Res Function(SearchRequest) then) =
      _$SearchRequestCopyWithImpl<$Res, SearchRequest>;
  @useResult
  $Res call(
      {String query, bool useAdvanced, String author, bool epub, bool pdf});
}

/// @nodoc
class _$SearchRequestCopyWithImpl<$Res, $Val extends SearchRequest>
    implements $SearchRequestCopyWith<$Res> {
  _$SearchRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? useAdvanced = null,
    Object? author = null,
    Object? epub = null,
    Object? pdf = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      useAdvanced: null == useAdvanced
          ? _value.useAdvanced
          : useAdvanced // ignore: cast_nullable_to_non_nullable
              as bool,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      epub: null == epub
          ? _value.epub
          : epub // ignore: cast_nullable_to_non_nullable
              as bool,
      pdf: null == pdf
          ? _value.pdf
          : pdf // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchRequestImplCopyWith<$Res>
    implements $SearchRequestCopyWith<$Res> {
  factory _$$SearchRequestImplCopyWith(
          _$SearchRequestImpl value, $Res Function(_$SearchRequestImpl) then) =
      __$$SearchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query, bool useAdvanced, String author, bool epub, bool pdf});
}

/// @nodoc
class __$$SearchRequestImplCopyWithImpl<$Res>
    extends _$SearchRequestCopyWithImpl<$Res, _$SearchRequestImpl>
    implements _$$SearchRequestImplCopyWith<$Res> {
  __$$SearchRequestImplCopyWithImpl(
      _$SearchRequestImpl _value, $Res Function(_$SearchRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? useAdvanced = null,
    Object? author = null,
    Object? epub = null,
    Object? pdf = null,
  }) {
    return _then(_$SearchRequestImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      useAdvanced: null == useAdvanced
          ? _value.useAdvanced
          : useAdvanced // ignore: cast_nullable_to_non_nullable
              as bool,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      epub: null == epub
          ? _value.epub
          : epub // ignore: cast_nullable_to_non_nullable
              as bool,
      pdf: null == pdf
          ? _value.pdf
          : pdf // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchRequestImpl implements _SearchRequest {
  const _$SearchRequestImpl(
      {required this.query,
      required this.useAdvanced,
      required this.author,
      required this.epub,
      required this.pdf});

  factory _$SearchRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchRequestImplFromJson(json);

  @override
  final String query;
  @override
  final bool useAdvanced;
  @override
  final String author;
  @override
  final bool epub;
  @override
  final bool pdf;

  @override
  String toString() {
    return 'SearchRequest(query: $query, useAdvanced: $useAdvanced, author: $author, epub: $epub, pdf: $pdf)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchRequestImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.useAdvanced, useAdvanced) ||
                other.useAdvanced == useAdvanced) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.epub, epub) || other.epub == epub) &&
            (identical(other.pdf, pdf) || other.pdf == pdf));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, query, useAdvanced, author, epub, pdf);

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchRequestImplCopyWith<_$SearchRequestImpl> get copyWith =>
      __$$SearchRequestImplCopyWithImpl<_$SearchRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchRequestImplToJson(
      this,
    );
  }
}

abstract class _SearchRequest implements SearchRequest {
  const factory _SearchRequest(
      {required final String query,
      required final bool useAdvanced,
      required final String author,
      required final bool epub,
      required final bool pdf}) = _$SearchRequestImpl;

  factory _SearchRequest.fromJson(Map<String, dynamic> json) =
      _$SearchRequestImpl.fromJson;

  @override
  String get query;
  @override
  bool get useAdvanced;
  @override
  String get author;
  @override
  bool get epub;
  @override
  bool get pdf;

  /// Create a copy of SearchRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchRequestImplCopyWith<_$SearchRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
