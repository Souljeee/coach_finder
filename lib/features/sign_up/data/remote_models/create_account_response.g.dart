// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountResponse _$CreateAccountResponseFromJson(
        Map<String, dynamic> json) =>
    CreateAccountResponse(
      accessAllowed: json['accessAllowed'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CreateAccountResponseToJson(
        CreateAccountResponse instance) =>
    <String, dynamic>{
      'accessAllowed': instance.accessAllowed,
      'message': instance.message,
    };
