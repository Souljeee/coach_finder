import 'package:json_annotation/json_annotation.dart';

enum Difficulty{
  @JsonValue('coach')
  easy,
  @JsonValue('client')
  medium,
  @JsonValue('hard')
  hard,
  @JsonValue('all')
  all;
}