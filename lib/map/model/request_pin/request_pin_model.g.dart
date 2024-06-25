// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestPinModelImpl _$$RequestPinModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestPinModelImpl(
      file: json['file'] as String?,
      dto: DtoModel.fromJson(json['dto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RequestPinModelImplToJson(
        _$RequestPinModelImpl instance) =>
    <String, dynamic>{
      'file': instance.file,
      'dto': instance.dto,
    };
