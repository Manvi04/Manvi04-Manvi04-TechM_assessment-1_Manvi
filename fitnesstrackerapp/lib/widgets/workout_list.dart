import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:fitnesstrackerapp/widgets/workout_card.dart';
import 'package:flutter/material.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    super.key,
    required this.workouts,
    required this.onRemoveWorkout,
  });
  final List<Workout> workouts;
  final void Function(Workout, int) onRemoveWorkout;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(workouts[index]),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'DELETE',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        onDismissed: (_) => onRemoveWorkout(workouts[index], index),
        child: WorkoutCard(workout: workouts[index]),
      ),
    );
  }
}