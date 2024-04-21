import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/create_workout_plan/data/data_sources/dtos/difficulty_enum.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InputGeneralInfoSlide extends StatelessWidget {
  final FormControl<String> planNameController;
  final FormControl<String> descriptionController;
  final FormControl<int> planDurationController;

  final void Function(int sessionsCount) onSessionsCountChange;
  final void Function(Difficulty difficulty) onDifficultyChange;

  const InputGeneralInfoSlide({
    required this.planNameController,
    required this.descriptionController,
    required this.planDurationController,
    required this.onSessionsCountChange,
    required this.onDifficultyChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: ListView(
        children: [
          CustomTextField(
            controller: planNameController,
            hint: 'Название',
            validationMessages: {ValidationMessage.required: (_) => 'Обязательное поле'},
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: descriptionController,
            hint: 'Описание',
            maxLines: 4,
          ),
          const SizedBox(height: 8),
          _ChipList(onDifficultyChange: onDifficultyChange),
          const SizedBox(height: 16),
          _SessionsPerWeekSlider(onSessionsCountChange: onSessionsCountChange),
          const SizedBox(height: 8),
          CustomTextField(
            controller: planDurationController,
            hint: 'Длительность програмы',
            helperText: 'Укажите длительность в неделях',
          ),
        ],
      ),
    );
  }
}

class _SessionsPerWeekSlider extends StatefulWidget {
  final void Function(int sessionsCount) onSessionsCountChange;

  const _SessionsPerWeekSlider({
    required this.onSessionsCountChange,
  });

  @override
  State<_SessionsPerWeekSlider> createState() => _SessionsPerWeekSliderState();
}

class _SessionsPerWeekSliderState extends State<_SessionsPerWeekSlider> {
  double _sessionsPerWeekCount = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Количество тренировок в неделю: ${_sessionsPerWeekCount.toInt().toString()}'),
        const SizedBox(height: 24),
        Slider(
          activeColor: AppColors.primary,
          value: _sessionsPerWeekCount,
          min: 1,
          max: 7,
          divisions: 6,
          label: _sessionsPerWeekCount.toInt().toString(),
          onChanged: (value) {
            setState(() {
              _sessionsPerWeekCount = value;

              widget.onSessionsCountChange(value.toInt());
            });
          },
        )
      ],
    );
  }
}

class _ChipList extends StatefulWidget {
  final void Function(Difficulty difficulty) onDifficultyChange;

  const _ChipList({
    required this.onDifficultyChange,
  });

  @override
  State<_ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<_ChipList> {
  Difficulty _selectedChip = Difficulty.all;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: Difficulty.values
          .map(
            (difficulty) => _DifficultyChip(
              difficulty: difficulty,
              isSelected: _selectedChip == difficulty,
              onSelect: (value) {
                setState(() {
                  if (value) {
                    _selectedChip = difficulty;
                    widget.onDifficultyChange(difficulty);
                  }
                });
              },
            ),
          )
          .toList(),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final Difficulty difficulty;
  final bool isSelected;
  final void Function(bool isSelect) onSelect;

  const _DifficultyChip({
    required this.difficulty,
    required this.isSelected,
    required this.onSelect,
  });

  String get _difficultyLabel => switch (difficulty) {
        Difficulty.easy => 'Легкая',
        Difficulty.medium => 'Средняя',
        Difficulty.hard => 'Тяжелая',
        Difficulty.all => 'Для всех',
      };

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(_difficultyLabel),
      selected: isSelected,
      onSelected: onSelect,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.secondary),
      checkmarkColor: isSelected ? AppColors.white : AppColors.secondary,
    );
  }
}
