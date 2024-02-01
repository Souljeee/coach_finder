// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      authStatus: $enumDecode(_$AuthStatusEnumMap, json['authStatus']),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'authStatus': _$AuthStatusEnumMap[instance.authStatus]!,
      'token': instance.token,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.success: 'SUCCESS',
  AuthStatus.nonexistent_user: 'NONEXISTENT_USER',
  AuthStatus.wrong_password: 'WRONG_PASSWORD',
};
