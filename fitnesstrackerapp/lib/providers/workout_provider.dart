import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:flutter/material.dart';

class WorkoutProvider extends ChangeNotifier {
  final List<Workout> _workouts = [];

  List<Workout> get workouts => [..._workouts];

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void removeWorkout(Workout workout, int index) {
    _workouts.remove(workout);
    notifyListeners();
  }

  Map<Category, int> get categoryCount {
    final Map<Category, int> counts = {
      Category.cardio: 0,
      Category.strength: 0,
      Category.yoga: 0,
      Category.balance: 0,
      Category.flexibility: 0,
      Category.other: 0,
    };
    for (var w in _workouts) {
      counts[w.category] = (counts[w.category] ?? 0) + 1;
    }
    return counts;
  }
}