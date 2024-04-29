import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/workout_plans/add_exercise/widgets/add_exercise_modal.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/exercise_model.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/session_model.dart';
import 'package:coach_finder/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateSessionsSlide extends StatefulWidget {
  final int sessionsCount;
  final void Function(SessionModel session) onSessionChange;

  const CreateSessionsSlide({
    required this.sessionsCount,
    required this.onSessionChange,
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
            onSessionChange: widget.onSessionChange,
          ),
        );
      },
    );
  }
}

class _SessionPanel extends StatefulWidget {
  final int sessionOrderNumber;
  final void Function(SessionModel session) onSessionChange;

  const _SessionPanel({
    required this.sessionOrderNumber,
    required this.onSessionChange,
    super.key,
  });

  @override
  State<_SessionPanel> createState() => _SessionPanelState();
}

class _SessionPanelState extends State<_SessionPanel> {
  final List<ExerciseModel> exercises = [];
  final FormControl<int> _durationController = FormControl<int>();

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
            CustomTextField(
              controller: _durationController,
              hint: 'Длительность тренировки',
            ),
            const SizedBox(height: 8),
            ...exercises.mapIndexed(
              (index, exercise) {
                return Container(
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

                    final session = SessionModel(
                      orderNumber: widget.sessionOrderNumber,
                      type: 'power',
                      duration: _durationController.value!,
                      exercises: exercises,
                    );

                    widget.onSessionChange(session);
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
