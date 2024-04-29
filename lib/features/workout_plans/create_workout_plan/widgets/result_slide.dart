import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/session_model.dart';
import 'package:coach_finder/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:collection/collection.dart';

class ResultSlide extends StatelessWidget {
  final FormControl<String> planNameController;
  final FormControl<String> descriptionController;
  final FormControl<int> planDurationController;
  final Difficulty difficulty;
  final int sessionPerWeek;
  final List<SessionModel> sessions;

  const ResultSlide({
    required this.planNameController,
    required this.descriptionController,
    required this.planDurationController,
    required this.difficulty,
    required this.sessionPerWeek,
    required this.sessions,
    super.key,
  });

  String get planName => planNameController.value!;

  String? get description => descriptionController.value;

  int get planDuration => planDurationController.value!;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 16),
        Text(
          'Название: $planName',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        if (description != null) ...[
          Text(
            'Описание: ${description!}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
        ],
        Text(
          'Длительность: $planDuration недель',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Сложность: ${difficulty.name}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Тренировок в неделю: $sessionPerWeek',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Тренировки:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...sessions.mapIndexed(
          (index, session) {
            final sessionOrder = index + 1;

            return Column(
              children: [
                Text(
                  '$sessionOrder - ая',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...session.exercises.map(
                      (exercise) => Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {},
                      title: Text(exercise.name),
                      leading: Image.asset(
                        Assets.assetsImg,
                        height: 20,
                        width: 20,
                      ),
                      subtitle: Text('Подходы: ${exercise.approaches.length}'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
