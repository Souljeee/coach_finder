import 'package:json_annotation/json_annotation.dart';

part 'approach_dto.g.dart';

@JsonSerializable()
class ApproachDto{
  final int orderNumber;
  final int repsCount;
  final double weight;
  final int rest;

  const ApproachDto({
    required this.orderNumber,
    required this.repsCount,
    required this.weight,
    required this.rest,
  });

  factory ApproachDto.fromJson(Map<String, dynamic> json) => _$ApproachDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApproachDtoToJson(this);
}