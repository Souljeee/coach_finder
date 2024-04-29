// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDetailsDto _$ExerciseDetailsDtoFromJson(Map<String, dynamic> json) =>
    ExerciseDetailsDto(
      exerciseId: json['exerciseId'] as int,
      comment: json['comment'] as String?,
      orderNumber: json['orderNumber'] as int,
      approaches: (json['approaches'] as List<dynamic>)
          .map((e) => ApproachDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciseDetailsDtoToJson(ExerciseDetailsDto instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'comment': instance.comment,
      'orderNumber': instance.orderNumber,
      'approaches': instance.approaches,
    };
