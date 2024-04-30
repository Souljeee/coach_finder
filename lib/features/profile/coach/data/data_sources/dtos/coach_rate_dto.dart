import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coach_rate_dto.g.dart';

@JsonSerializable()
class CoachRateDto extends Equatable {
  final int rate;
  final String positiveComment;
  final String negativeComment;

  const CoachRateDto({
    required this.rate,
    required this.positiveComment,
    required this.negativeComment,
  });

  factory CoachRateDto.fromJson(Map<String, dynamic> json) => _$CoachRateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CoachRateDtoToJson(this);

  @override
  List<Object?> get props => [
    rate,
    positiveComment,
    negativeComment,
  ];
}
