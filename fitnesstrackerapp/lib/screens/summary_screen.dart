import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:flutter/material.dart';
import '../widgets/workout_pie_chart.dart';

class SummaryScreen extends StatelessWidget {
  // static const routeName = '/summary';

  const SummaryScreen({super.key, required this.workouts});

  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    // function to get total workouts per category
    String getTotalWorkoutPerCategory(Category category) {
      int total = 0;
      for (var workout in workouts) {
        if (workout.category == category) {
          total++;
        }
      }
      return total.toString();
    }

    // function to get category color by name
    Color getCategoryColorByName(String categoryName) {
      switch (categoryName) {
        case "strength":
          return Colors.red;
        case "cardio":
          return Colors.blue;
        case "flexibility":
          return Colors.green;
        case "balance":
          return Colors.yellow;
        case "yoga":
          return Colors.purple;
        default:
          return Colors.grey; // unknown category kept in other
      }
    }

    // function to build the summary content
    Widget buildSummaryContent(BuildContext context, List<Workout> workouts) {
      return SingleChildScrollView(
        child: Column(
          children: [
            WorkoutPieChart(workouts: workouts),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              children: List.generate(Category.values.length, (index) {
                final category = Category.values[index];
                final totalWorkouts = getTotalWorkoutPerCategory(category);
                return ListTile(
                  style: ListTileStyle.drawer,
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  leadingAndTrailingTextStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: getCategoryColorByName(category.name),
                    radius: 10,
                  ),
                  title: Text(category.name),
                  trailing: Text(totalWorkouts),
                );
              }),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Summary')),
      body: workouts.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/empty_workout.png',
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No workouts recorded yet.',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          // if workouts are not empty, show the summary
          : buildSummaryContent(context, workouts),
    );
  }
}