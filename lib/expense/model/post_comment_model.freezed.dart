// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostCommentModel _$PostCommentModelFromJson(Map<String, dynamic> json) {
  return _PostCommentModel.fromJson(json);
}

/// @nodoc
mixin _$PostCommentModel {
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCommentModelCopyWith<PostCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommentModelCopyWith<$Res> {
  factory $PostCommentModelCopyWith(
          PostCommentModel value, $Res Function(PostCommentModel) then) =
      _$PostCommentModelCopyWithImpl<$Res, PostCommentModel>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class _$PostCommentModelCopyWithImpl<$Res, $Val extends PostCommentModel>
    implements $PostCommentModelCopyWith<$Res> {
  _$PostCommentModelCopyWithImpl(this._value, this._then);

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
abstract class _$$PostCommentModelImplCopyWith<$Res>
    implements $PostCommentModelCopyWith<$Res> {
  factory _$$PostCommentModelImplCopyWith(_$PostCommentModelImpl value,
          $Res Function(_$PostCommentModelImpl) then) =
      __$$PostCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$PostCommentModelImplCopyWithImpl<$Res>
    extends _$PostCommentModelCopyWithImpl<$Res, _$PostCommentModelImpl>
    implements _$$PostCommentModelImplCopyWith<$Res> {
  __$$PostCommentModelImplCopyWithImpl(_$PostCommentModelImpl _value,
      $Res Function(_$PostCommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$PostCommentModelImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCommentModelImpl implements _PostCommentModel {
  _$PostCommentModelImpl({required this.content});

  factory _$PostCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommentModelImplFromJson(json);

  @override
  final String content;

  @override
  String toString() {
    return 'PostCommentModel(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommentModelImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommentModelImplCopyWith<_$PostCommentModelImpl> get copyWith =>
      __$$PostCommentModelImplCopyWithImpl<_$PostCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommentModelImplToJson(
      this,
    );
  }
}

abstract class _PostCommentModel implements PostCommentModel {
  factory _PostCommentModel({required final String content}) =
      _$PostCommentModelImpl;

  factory _PostCommentModel.fromJson(Map<String, dynamic> json) =
      _$PostCommentModelImpl.fromJson;

  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$PostCommentModelImplCopyWith<_$PostCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
