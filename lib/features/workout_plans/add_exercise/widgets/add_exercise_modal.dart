import 'package:coach_finder/common/dependencies/app_dependencies.dart';
import 'package:coach_finder/common/theme/colors.dart';
import 'package:coach_finder/common/utils/debounce.dart';
import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:coach_finder/common/widgets/custom_text_field.dart';
import 'package:coach_finder/features/workout_plans/add_exercise/bloc/all_exercises_bloc.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/exercise_dto.dart';
import 'package:coach_finder/features/workout_plans/common/data/data_sources/dtos/muscle_groups_enum.dart';
import 'package:coach_finder/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddExerciseModal extends StatefulWidget {
  const AddExerciseModal({
    super.key,
  });

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends State<AddExerciseModal> {
  late final _allExercisesBloc = AllExercisesBloc(
    workoutPlanRepository: AppDependenciesScope.of(context).workoutPlanRepository,
  );

  List<MuscleGroups>? _appliedFilters;

  final _debounce = Debounce(const Duration(milliseconds: 300));
  final FormControl<String> _searchController = FormControl<String>();

  @override
  void initState() {
    super.initState();

    _allExercisesBloc.add(const AllExercisesEvent.fetchAllExercises());
  }

  @override
  Future<void> dispose() async {
    await _allExercisesBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _allExercisesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Добавить упражнение',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _searchController,
                              hint: 'Поиск',
                              onChanged: (controller) {
                                _debounce.call(() {
                                  _allExercisesBloc.add(
                                      AllExercisesEvent.searchExercises(query: controller.value));
                                });
                              },
                              prefixIcon: const Icon(
                                Icons.search,
                                color: AppColors.secondary,
                              ),
                              suffixIcon: BlocBuilder<AllExercisesBloc, AllExercisesState>(
                                builder: (context, state) {
                                  return state.maybeMap(
                                    orElse: () => const SizedBox.shrink(),
                                    success: (state) => IconButton(
                                      onPressed: () async => _showFilterBottomSheet(
                                        muscleGroups: state.muscleGroups,
                                        appliedFilters: _appliedFilters,
                                      ),
                                      icon: const Icon(
                                        Icons.filter_alt,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              cursorColor: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                BlocConsumer<AllExercisesBloc, AllExercisesState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return state.map(
                      loading: (_) => const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      success: (state) {
                        final List<ExerciseDto> searchedExercisesWithFilters =
                            _getSearchedExercisesWithFilter(
                          searchedExercises: state.searchedExercises,
                        );

                        return SliverList.builder(
                          itemCount: searchedExercisesWithFilters.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {},
                              title: Text(searchedExercisesWithFilters[index].name),
                              leading: Image.asset(
                                Assets.assetsImg,
                                height: 20,
                                width: 20,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                            );
                          },
                        );
                      },
                      error: (_) => Container(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ExerciseDto> _getSearchedExercisesWithFilter({
    required List<ExerciseDto> searchedExercises,
  }) {
    if (_appliedFilters == null) {
      return searchedExercises;
    }

    List<ExerciseDto> exercisesWithFilters = [];

    for (var filter in _appliedFilters!) {
      final exercisesWithFilter = searchedExercises
          .where(
            (exercise) => exercise.muscleGroups.contains(filter),
          )
          .toList();

      exercisesWithFilters = [...exercisesWithFilter, ...exercisesWithFilters];
    }

    return exercisesWithFilters;
  }

  Future<void> _showFilterBottomSheet({
    required List<MuscleGroups> muscleGroups,
    required List<MuscleGroups>? appliedFilters,
  }) async {
    final result = await showModalBottomSheet<List<MuscleGroups>>(
      context: context,
      builder: (context) {
        return _FilterBottomSheet(
          muscleGroups: muscleGroups,
          appliedFilters: appliedFilters,
        );
      },
    );

    if (result == null) {
      return;
    }

    if(result.isEmpty){
      setState(() {
        _appliedFilters = null;
      });

      return;
    }

    setState(() {
      _appliedFilters = result;
    });
  }
}

class _FilterBottomSheet extends StatefulWidget {
  final List<MuscleGroups> muscleGroups;
  final List<MuscleGroups>? appliedFilters;

  const _FilterBottomSheet({
    required this.muscleGroups,
    required this.appliedFilters,
    super.key,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late final List<MuscleGroups> _selectedMuscleGroup = widget.appliedFilters ?? [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Группы мышц',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.muscleGroups
              .map(
                (muscleGroup) => _MuscleGroupChip(
                  muscleGroup: muscleGroup,
                  isSelected: _selectedMuscleGroup.contains(muscleGroup),
                  onSelect: (value) {
                    setState(() {
                      if (value) {
                        _selectedMuscleGroup.add(muscleGroup);
                      } else {
                        _selectedMuscleGroup.remove(muscleGroup);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        CustomElevatedButton(
          title: 'Применить',
          onTap: () {
            context.pop(_selectedMuscleGroup);
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _MuscleGroupChip extends StatelessWidget {
  final MuscleGroups muscleGroup;
  final bool isSelected;

  final void Function(bool isSelect) onSelect;

  const _MuscleGroupChip({
    required this.muscleGroup,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(muscleGroup.name),
      selected: isSelected,
      onSelected: onSelect,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(color: isSelected ? AppColors.white : AppColors.secondary),
      checkmarkColor: isSelected ? AppColors.white : AppColors.secondary,
    );
  }
}
