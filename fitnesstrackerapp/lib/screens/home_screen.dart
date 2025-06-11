import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:fitnesstrackerapp/screens/add_workout_screen.dart';
import 'package:fitnesstrackerapp/screens/bmi_screen.dart';
import 'package:fitnesstrackerapp/screens/summary_screen.dart';
import 'package:fitnesstrackerapp/widgets/workout_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final List<Workout> registeredWorkouts = [
    Workout(
      title: "Push Ups",
      category: Category.strength,
      duration: 10,
      date: DateTime.now(),
    ),
    Workout(
      title: "Surya Namaskar Asana",
      category: Category.yoga,
      duration: 15,
      date: DateTime.now(),
    ),
  ];

  void _addWorkout(Workout workout) {
    setState(() => registeredWorkouts.add(workout));
  }

  void _onAddNewWorkoutPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AddWorkoutScreen(onAddWorkoutButtonPress: _addWorkout),
      ),
    );
  }

  void _removeWorkout(Workout workout, int index) {
    setState(() {
      registeredWorkouts.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Workout removed'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              registeredWorkouts.insert(index, workout);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Scaffold(
        appBar: AppBar(
          title: const Text('Fitness Tracker'),
          centerTitle: true,
          backgroundColor: Color(0xFFB76D68),
        ),
        body: registeredWorkouts.isEmpty
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
                        'No workouts registered yet.',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Your Workouts',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: WorkoutList(
                        workouts: registeredWorkouts,
                        onRemoveWorkout: _removeWorkout,
                      ),
                    ),
                  ],
                ),
              ),
        backgroundColor: const Color(0xFF121420),
        floatingActionButton: FloatingActionButton(
          onPressed: _onAddNewWorkoutPress,
          backgroundColor: const Color(0xFFB76D68),
          child: const Icon(Icons.add),
        ),
      ),
      BmiScreen(),
      SummaryScreen(workouts: registeredWorkouts),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: ((int index) {
          setState(() {
            currentPageIndex = index;
          });
        }),
        // surfaceTintColor: Colors.white,
        // indicatorColor: const Color(0xFFB76D68),
        selectedIndex: currentPageIndex,
        // backgroundColor: const Color(0xFF121420),
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.monitor_weight), label: 'BMI'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Summary'),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}