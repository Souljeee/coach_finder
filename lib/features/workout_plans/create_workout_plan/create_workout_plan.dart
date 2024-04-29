import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/difficulty_enum.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/session_model.dart';
import 'package:coach_finder/features/workout_plans/create_workout_plan/bloc/create_workout_bloc.dart';
import 'package:coach_finder/features/workout_plans/create_workout_plan/widgets/add_sessions_slide.dart';
import 'package:coach_finder/features/workout_plans/create_workout_plan/widgets/input_general_info_slide.dart';
import 'package:coach_finder/features/workout_plans/create_workout_plan/widgets/result_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:collection/collection.dart';

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

  late List<SessionModel> _sessions = [];

  Difficulty _difficulty = Difficulty.all;

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
        onDifficultyChange: (difficulty) {
          setState(() {
            _difficulty = difficulty;
          });
        },
      ),
      CreateSessionsSlide(
        sessionsCount: _sessionsCount,
        onSessionChange: (SessionModel newSession) {
          final sameSession = _sessions
              .firstWhereOrNull((session) => session.orderNumber == newSession.orderNumber);

          if (sameSession == null) {
            _sessions.add(newSession);

            return;
          }

          final int updatedIndex = _sessions.indexOf(sameSession);

          _sessions[updatedIndex] = newSession;
        },
      ),
      ResultSlide(
        planNameController: _planNameController,
        descriptionController: _descriptionController,
        planDurationController: _planDurationController,
        difficulty: _difficulty,
        sessionPerWeek: _sessionsCount,
        sessions: _sessions,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Создать программу',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => CreateWorkoutBloc(
          userRepository: AppDependenciesScope.of(context).userRepository,
          workoutPlanRepository: AppDependenciesScope.of(context).workoutPlanRepository,
        ),
        child: SafeArea(
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
              BlocConsumer<CreateWorkoutBloc, CreateWorkoutState>(
                listener: (context, state) {
                  state.mapOrNull(
                    success: (_) {
                      context.pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Программа успешно создана',
                            style: TextStyle(color: AppColors.white),
                          ),
                          margin: EdgeInsets.all(16),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return Padding(
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
                            isLoading: state.isLoading,
                            title: 'Далее',
                            onTap: () => _onNextTap(context: context),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _onNextTap({required BuildContext context}) {
    if (_pageController.page == 0) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      return;
    }

    if (_pageController.page == 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );

      return;
    }

    BlocProvider.of<CreateWorkoutBloc>(context).add(
      CreateWorkoutEvent.createWorkoutPlan(
        title: _planNameController.value!,
        description: _descriptionController.value!,
        difficulty: _difficulty,
        type: 'power',
        // TODO: СДЕЛАТЬ ВЫБОР ТИПА ТРЕНИРОВКИ
        sessionsPerWeek: _sessionsCount,
        planDuration: _planDurationController.value!,
        sessions: _sessions,
      ),
    );
  }
}
