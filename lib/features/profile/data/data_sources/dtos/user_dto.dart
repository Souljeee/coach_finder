import 'package:coach_finder/common/data/account_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final DateTime createAccountDate;
  final String email;
  final AccountType accountType;

  const UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createAccountDate,
    required this.email,
    required this.accountType,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        createAccountDate,
        email,
        accountType,
      ];
}
