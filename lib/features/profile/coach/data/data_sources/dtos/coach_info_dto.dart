import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coach_info_dto.g.dart';

@JsonSerializable()
class CoachInfoDto extends Equatable {
  @JsonKey(name: 'coachId')
  final String id;
  final int? experience;
  final String? description;
  final double rating;

  const CoachInfoDto({
    required this.id,
    required this.experience,
    required this.description,
    required this.rating,
  });

  factory CoachInfoDto.fromJson(Map<String, dynamic> json) => _$CoachInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoachInfoDtoToJson(this);

  @override
  List<Object?> get props => [
    id,
    experience,
    description,
    rating,
  ];
}
