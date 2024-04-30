import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_info_dto.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_rate_dto.dart';
import 'package:dio/dio.dart';

class CoachRemoteDataSource {
  final Dio _networkClient;

  const CoachRemoteDataSource({
    required Dio networkClient,
  }) : _networkClient = networkClient;

  Future<CoachInfoDto> getCoachInfo({required String userId}) async {
    final response = await _networkClient.get('/coach_info/$userId');

    return CoachInfoDto.fromJson(response.data);
  }

  Future<List<CoachRateDto>> getCoachRates({required String coachId}) async {
    final response = await _networkClient.get('/coach_rates/$coachId');

    return response.data
        .map<CoachRateDto>(
          (rateJson) => CoachRateDto.fromJson(rateJson),
        )
        .toList();
  }

  Future<List<String>> getCoachAchievements({required String coachId}) async {
    final response = await _networkClient.get('/coach_achievements/$coachId');

    return response.data;
  }
}
