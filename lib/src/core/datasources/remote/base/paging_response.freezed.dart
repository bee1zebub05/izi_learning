// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PagingResponse _$PagingResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PagingResponse.fromJson(
    json,
  );
}

/// @nodoc
mixin _$PagingResponse {
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasPreviousPage => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingResponseCopyWith<PagingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingResponseCopyWith<$Res> {
  factory $PagingResponseCopyWith(
          PagingResponse value, $Res Function(PagingResponse) then) =
      _$PagingResponseCopyWithImpl<$Res, PagingResponse>;
  @useResult
  $Res call(
      {int currentPage,
      int pageSize,
      int totalItems,
      int totalPages,
      bool hasPreviousPage,
      bool hasNextPage});
}

/// @nodoc
class _$PagingResponseCopyWithImpl<$Res, $Val extends PagingResponse>
    implements $PagingResponseCopyWith<$Res> {
  _$PagingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? pageSize = null,
    Object? totalItems = null,
    Object? totalPages = null,
    Object? hasPreviousPage = null,
    Object? hasNextPage = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasPreviousPage: null == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagingResponseImplCopyWith<$Res>
    implements $PagingResponseCopyWith<$Res> {
  factory _$$PagingResponseImplCopyWith(_$PagingResponseImpl value,
          $Res Function(_$PagingResponseImpl) then) =
      __$$PagingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      int pageSize,
      int totalItems,
      int totalPages,
      bool hasPreviousPage,
      bool hasNextPage});
}

/// @nodoc
class __$$PagingResponseImplCopyWithImpl<$Res>
    extends _$PagingResponseCopyWithImpl<$Res, _$PagingResponseImpl>
    implements _$$PagingResponseImplCopyWith<$Res> {
  __$$PagingResponseImplCopyWithImpl(
      _$PagingResponseImpl _value, $Res Function(_$PagingResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? pageSize = null,
    Object? totalItems = null,
    Object? totalPages = null,
    Object? hasPreviousPage = null,
    Object? hasNextPage = null,
  }) {
    return _then(_$PagingResponseImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasPreviousPage: null == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagingResponseImpl implements _PagingResponse {
  const _$PagingResponseImpl(
      {required this.currentPage,
      required this.pageSize,
      required this.totalItems,
      required this.totalPages,
      required this.hasPreviousPage,
      required this.hasNextPage});

  factory _$PagingResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$$PagingResponseImplFromJson(
        json,
      );

  @override
  final int currentPage;
  @override
  final int pageSize;
  @override
  final int totalItems;
  @override
  final int totalPages;
  @override
  final bool hasPreviousPage;
  @override
  final bool hasNextPage;

  @override
  String toString() {
    return 'PagingResponse(currentPage: $currentPage, pageSize: $pageSize, totalItems: $totalItems, totalPages: $totalPages, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagingResponseImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage, pageSize,
      totalItems, totalPages, hasPreviousPage, hasNextPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PagingResponseImplCopyWith<_$PagingResponseImpl> get copyWith =>
      __$$PagingResponseImplCopyWithImpl<_$PagingResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagingResponseImplToJson(
      this,
    );
  }
}

abstract class _PagingResponse implements PagingResponse {
  const factory _PagingResponse(
      {required final int currentPage,
      required final int pageSize,
      required final int totalItems,
      required final int totalPages,
      required final bool hasPreviousPage,
      required final bool hasNextPage}) = _$PagingResponseImpl;

  factory _PagingResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$PagingResponseImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  int get totalItems;
  @override
  int get totalPages;
  @override
  bool get hasPreviousPage;
  @override
  bool get hasNextPage;
  @override
  @JsonKey(ignore: true)
  _$$PagingResponseImplCopyWith<_$PagingResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
