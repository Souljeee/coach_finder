// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      orderNumber: json['orderNumber'] as int,
      type: json['type'] as String,
      duration: json['duration'] as int,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseDetailsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'type': instance.type,
      'duration': instance.duration,
      'exercises': instance.exercises,
    };
