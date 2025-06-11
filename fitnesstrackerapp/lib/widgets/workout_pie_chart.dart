import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/workout.dart';

class WorkoutPieChart extends StatefulWidget {
  final List<Workout> workouts;

  const WorkoutPieChart({super.key, required this.workouts});

  @override
  State<WorkoutPieChart> createState() => _WorkoutPieChartState();
}

class _WorkoutPieChartState extends State<WorkoutPieChart> {
  int touchedIndex = -1;

  Map<Category, int> _calculateCategoryCounts() {
    final Map<Category, int> counts = {};
    for (var workout in widget.workouts) {
      counts[workout.category] = (counts[workout.category] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final categoryCounts = _calculateCategoryCounts();
    final total = categoryCounts.values.fold(0, (sum, c) => sum + c);

    if (total == 0) {
      return const Center(child: Text("No data to show"));
    }

    return AspectRatio(
      aspectRatio: 1.2,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: 180,
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 4,
                      centerSpaceRadius: double.infinity,
                      sections: _generateSections(categoryCounts, total),
                    ),
                  ),
                ),
                Positioned(
                  width: 150,
                  top: 120,
                  child: Column(
                    children: [
                      Text(
                        'Total Workouts:',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$total',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(
    Map<Category, int> categoryCounts,
    int total,
  ) {
    final shadows = [const Shadow(color: Colors.black, blurRadius: 2)];

    return categoryCounts.entries.mapIndexed((index, entry) {
      final category = entry.key;
      final count = entry.value;
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percent = (count / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: Workout(
          title: '',
          category: category,
          duration: 0,
          date: DateTime.now(),
        ).getCategoryColor(),
        value: count.toDouble(),
        title: '$percent%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}

extension<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) {
    int index = 0;
    return map((item) => f(index++, item));
  }
}