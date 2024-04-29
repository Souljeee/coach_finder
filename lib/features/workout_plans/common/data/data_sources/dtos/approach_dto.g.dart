// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approach_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproachDto _$ApproachDtoFromJson(Map<String, dynamic> json) => ApproachDto(
      orderNumber: json['orderNumber'] as int,
      repsCount: json['repsCount'] as int,
      weight: (json['weight'] as num).toDouble(),
      rest: json['rest'] as int,
    );

Map<String, dynamic> _$ApproachDtoToJson(ApproachDto instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'repsCount': instance.repsCount,
      'weight': instance.weight,
      'rest': instance.rest,
    };
