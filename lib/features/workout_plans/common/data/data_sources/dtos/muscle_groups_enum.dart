import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'key')
enum MuscleGroups {
  shouldersAnteriorDelta(
    key: 'shoulders_anterior_delta',
    name: 'Передняя дельта плеча',
  ),
  biceps(
    key: 'biceps',
    name: 'Бицепс',
  ),
  triceps(
    key: 'triceps',
    name: 'Трицепс',
  ),
  calfMuscle(
    key: 'calf_muscle',
    name: 'Икроножная мышца',
  ),
  latissimusDorsi(
    key: 'latissimus_dorsi',
    name: 'Широчайшие мышцы спины',
  );

  final String key;
  final String name;

  const MuscleGroups({
    required this.key,
    required this.name,
  });
}
