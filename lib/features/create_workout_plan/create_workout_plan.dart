import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/features/create_workout_plan/widgets/add_sessions_slide.dart';
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
  final _pageController = PageController(initialPage: 0);

  final _planNameController = FormControl<String>(
    validators: [
      Validators.required,
    ],
  );

  final _descriptionController = FormControl<String>();
  final _planDurationController = FormControl<int>(
    validators: [
      Validators.required,
    ],
  );

  int _sessionsCount = 4;

  @override
  Widget build(BuildContext context) {
    final List<Widget> slides = [
      InputGeneralInfoSlide(
        planNameController: _planNameController,
        descriptionController: _descriptionController,
        planDurationController: _planDurationController,
        onSessionsCountChange: (sessionsCount) {
          setState(() {
            _sessionsCount = sessionsCount;
          });
        },
        onDifficultyChange: (difficulty) {},
      ),
      CreateSessionsSlide(
        sessionsCount: _sessionsCount,
      ),
    ];

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
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return slides[index];
                },
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
                      onTap: _onNextTap,
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

  void _onNextTap(){
    if(_pageController.page == 0){
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      return;
    }

    if(_pageController.page == 1){
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      return;
    }
  }
}
