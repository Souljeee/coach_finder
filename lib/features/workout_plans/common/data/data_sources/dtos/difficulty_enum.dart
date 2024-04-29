import 'package:json_annotation/json_annotation.dart';

enum Difficulty{
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
  @JsonValue('all')
  all;
}