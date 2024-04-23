import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/approach_model.dart';
import 'package:coach_finder/features/workout_plans/common/ui/models/exercise_model.dart';
import 'package:coach_finder/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:collection/collection.dart';

class AddApproachesModal extends StatefulWidget {
  final ExerciseDto exercise;
  final int exerciseOrderNumber;

  const AddApproachesModal({
    required this.exercise,
    required this.exerciseOrderNumber,
    super.key,
  });

  @override
  State<AddApproachesModal> createState() => _AddApproachesModalState();
}

class _AddApproachesModalState extends State<AddApproachesModal> {
  List<_ControllersListModel> _controllersModelsList = [];

  final FormControl<String> _commentController = FormControl<String>();

  @override
  void initState() {
    super.initState();

    _controllersModelsList.add(
      _ControllersListModel(
        repsCountController: FormControl<String>(),
        weightController: FormControl<String>(),
        restController: FormControl<String>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          'Настройка упражнения',
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.assetsImg,
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(width: 42),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.exercise.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (widget.exercise.description != null) ...[
              const Text(
                'Описание:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.exercise.description!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: 16),
            CustomTextField(
              controller: _commentController,
              hint: 'Комментарий',
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Подходы',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ..._controllersModelsList.mapIndexed(
              (index, controllersModel) => _InputDataRow(
                key: ValueKey(controllersModel),
                approachCount: index + 1,
                repsCountController: controllersModel.repsCountController,
                weightController: controllersModel.weightController,
                restController: controllersModel.restController,
                onRemoveTap: () {
                  setState(() {
                    _controllersModelsList.remove(controllersModel);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: CustomElevatedButton(
                onTap: () {
                  setState(() {
                    _controllersModelsList.add(
                      _ControllersListModel(
                        repsCountController: FormControl<String>(),
                        weightController: FormControl<String>(),
                        restController: FormControl<String>(),
                      ),
                    );
                  });
                },
                title: 'Добавить подход',
                style: ElevatedButtonStyle.transparent,
                icon: Icons.add,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: CustomElevatedButton(
                onTap: () {
                  final List<ApproachModel> approaches = _controllersModelsList
                      .mapIndexed(
                        (index, controllerModel) => ApproachModel(
                          orderNumber: index + 1,
                          repsCount: int.parse(controllerModel.repsCountController.value!),
                          weight: int.parse(controllerModel.weightController.value!),
                          rest: int.parse(controllerModel.restController.value!),
                        ),
                      )
                      .toList();

                  final exercise = ExerciseModel(
                    id: widget.exercise.id,
                    name: widget.exercise.name,
                    type: widget.exercise.type,
                    description: widget.exercise.description,
                    imageUrl: widget.exercise.imageUrl,
                    videoUrl: widget.exercise.videoUrl,
                    authorId: widget.exercise.authorId,
                    difficulty: widget.exercise.difficulty,
                    muscleGroups: widget.exercise.muscleGroups,
                    orderNumber: widget.exerciseOrderNumber,
                    comment: _commentController.value,
                    approaches: approaches,
                  );

                  context.pop(exercise);
                },
                title: 'Сохранить',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControllersListModel {
  final FormControl<String> repsCountController;
  final FormControl<String> weightController;
  final FormControl<String> restController;

  const _ControllersListModel({
    required this.repsCountController,
    required this.weightController,
    required this.restController,
  });
}

class _InputDataRow extends StatelessWidget {
  final int approachCount;
  final FormControl<String> repsCountController;
  final FormControl<String> weightController;
  final FormControl<String> restController;
  final VoidCallback onRemoveTap;

  const _InputDataRow({
    required this.approachCount,
    required this.repsCountController,
    required this.weightController,
    required this.restController,
    required this.onRemoveTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50),
          child: Row(
            children: [
              Text(
                '$approachCount.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  controller: repsCountController,
                  hint: 'Повторения',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  controller: weightController,
                  hint: 'Вес',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  controller: restController,
                  hint: 'Отдых',
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onRemoveTap,
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
