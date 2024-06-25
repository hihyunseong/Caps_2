// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestCommentModel _$RequestCommentModelFromJson(Map<String, dynamic> json) {
  return _RequestCommentModel.fromJson(json);
}

/// @nodoc
mixin _$RequestCommentModel {
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestCommentModelCopyWith<RequestCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestCommentModelCopyWith<$Res> {
  factory $RequestCommentModelCopyWith(
          RequestCommentModel value, $Res Function(RequestCommentModel) then) =
      _$RequestCommentModelCopyWithImpl<$Res, RequestCommentModel>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$RequestCommentModelCopyWithImpl<$Res, $Val extends RequestCommentModel>
    implements $RequestCommentModelCopyWith<$Res> {
  _$RequestCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestCommentModelImplCopyWith<$Res>
    implements $RequestCommentModelCopyWith<$Res> {
  factory _$$RequestCommentModelImplCopyWith(_$RequestCommentModelImpl value,
          $Res Function(_$RequestCommentModelImpl) then) =
      __$$RequestCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$RequestCommentModelImplCopyWithImpl<$Res>
    extends _$RequestCommentModelCopyWithImpl<$Res, _$RequestCommentModelImpl>
    implements _$$RequestCommentModelImplCopyWith<$Res> {
  __$$RequestCommentModelImplCopyWithImpl(_$RequestCommentModelImpl _value,
      $Res Function(_$RequestCommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$RequestCommentModelImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestCommentModelImpl implements _RequestCommentModel {
  const _$RequestCommentModelImpl({required this.content});

  factory _$RequestCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestCommentModelImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'RequestCommentModel(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestCommentModelImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestCommentModelImplCopyWith<_$RequestCommentModelImpl> get copyWith =>
      __$$RequestCommentModelImplCopyWithImpl<_$RequestCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestCommentModelImplToJson(
      this,
    );
  }
}

abstract class _RequestCommentModel implements RequestCommentModel {
  const factory _RequestCommentModel({required final String content}) =
      _$RequestCommentModelImpl;

  factory _RequestCommentModel.fromJson(Map<String, dynamic> json) =
      _$RequestCommentModelImpl.fromJson;

  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$RequestCommentModelImplCopyWith<_$RequestCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
