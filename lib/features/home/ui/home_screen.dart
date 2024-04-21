import 'package:coach_finder/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomElevatedButton(
                title: 'Создать программу',
                onTap: (){
                  context.pushNamed('create_workout_plan');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
