// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachInfoDto _$CoachInfoDtoFromJson(Map<String, dynamic> json) => CoachInfoDto(
      id: json['coachId'] as String,
      experience: json['experience'] as int,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$CoachInfoDtoToJson(CoachInfoDto instance) =>
    <String, dynamic>{
      'coachId': instance.id,
      'experience': instance.experience,
      'description': instance.description,
      'rating': instance.rating,
    };
