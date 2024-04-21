import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/features/create_workout_plan/widgets/input_general_info_slide.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateWorkoutPlanScreen extends StatefulWidget {
  const CreateWorkoutPlanScreen({
    super.key,
  });

  @override
  State<CreateWorkoutPlanScreen> createState() => _CreateWorkoutPlanScreenState();
}

class _CreateWorkoutPlanScreenState extends State<CreateWorkoutPlanScreen> {
  final _planNameController = FormControl<String>(
    validators: [
      Validators.required,
    ],
  );

  final _descriptionController = FormControl<String>();
  final _planDurationController = FormControl<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Создать программу',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  InputGeneralInfoSlide(
                    planNameController: _planNameController,
                    descriptionController: _descriptionController,
                    planDurationController: _planDurationController,
                    onSessionsCountChange: (sessionsCount){},
                    onDifficultyChange: (difficulty){},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      title: 'Назад',
                      style: ElevatedButtonStyle.transparent,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      title: 'Далее',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
