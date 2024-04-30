// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_rate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachRateDto _$CoachRateDtoFromJson(Map<String, dynamic> json) => CoachRateDto(
      rate: json['rate'] as int,
      positiveComment: json['positiveComment'] as String,
      negativeComment: json['negativeComment'] as String,
    );

Map<String, dynamic> _$CoachRateDtoToJson(CoachRateDto instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'positiveComment': instance.positiveComment,
      'negativeComment': instance.negativeComment,
    };
