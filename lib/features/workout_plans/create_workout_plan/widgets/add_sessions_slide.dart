import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/features/workout_plans/add_exercise/widgets/add_exercise_modal.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CreateSessionsSlide extends StatefulWidget {
  final int sessionsCount;

  const CreateSessionsSlide({
    required this.sessionsCount,
    super.key,
  });

  @override
  State<CreateSessionsSlide> createState() => _CreateSessionsSlideState();
}

class _CreateSessionsSlideState extends State<CreateSessionsSlide> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      itemCount: widget.sessionsCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _SessionPanel(
            sessionOrderNumber: index + 1,
          ),
        );
      },
    );
  }
}

class _SessionPanel extends StatefulWidget {
  final int sessionOrderNumber;

  const _SessionPanel({
    required this.sessionOrderNumber,
    super.key,
  });

  @override
  State<_SessionPanel> createState() => _SessionPanelState();
}

class _SessionPanelState extends State<_SessionPanel> {
  final List<ExerciseModel> exercises = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('${widget.sessionOrderNumber}-ая тренировка'),
      initiallyExpanded: widget.sessionOrderNumber == 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.primary),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.primary),
      ),
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      textColor: AppColors.secondary,
      collapsedTextColor: AppColors.secondary,
      collapsedIconColor: AppColors.secondary,
      iconColor: AppColors.secondary,
      children: [
        Column(
          children: [
            ...exercises.mapIndexed(
              (index, exercise) {
                return ListTile(
                  title: Text(exercise.name),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomElevatedButton(
                title: 'Добавить упражнение',
                icon: Icons.add,
                style: ElevatedButtonStyle.tonal,
                onTap: () async {
                  final ExerciseModel? result = await Navigator.of(context).push<ExerciseModel>(
                    MaterialPageRoute(
                      builder: (context) => AddExerciseModal(
                        exerciseOrderNumber: exercises.length + 1,
                      ),
                    ),
                  );

                  if (result == null) {
                    return;
                  }

                  setState(() {
                    exercises.add(result);
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
