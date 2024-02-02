import 'package:json_annotation/json_annotation.dart';

enum AccountType{
  @JsonValue('coach')
  coach,
  @JsonValue('client')
  client;
}