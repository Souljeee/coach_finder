import 'package:coach_finder/features/profile/coach/data/data_sources/coach_remote_data_source.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_info_dto.dart';
import 'package:coach_finder/features/profile/coach/data/data_sources/dtos/coach_rate_dto.dart';

class CoachRepository {
  final CoachRemoteDataSource _coachRemoteDataSource;

  const CoachRepository({
    required CoachRemoteDataSource coachRemoteDataSource,
  }) : _coachRemoteDataSource = coachRemoteDataSource;

  Future<CoachInfoDto> getCoachInfo({required String userId}) async {
    return _coachRemoteDataSource.getCoachInfo(userId: userId);
  }

  Future<List<CoachRateDto>> getCoachRates({required String coachId}) async {
    return _coachRemoteDataSource.getCoachRates(coachId: coachId);
  }

  Future<List<String>> getCoachAchievements({required String coachId}) async {
    return _coachRemoteDataSource.getCoachAchievements(coachId: coachId);
  }
}
