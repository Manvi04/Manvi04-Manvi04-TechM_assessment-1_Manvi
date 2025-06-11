// for the internationalization that supports formatting of data
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// enum variable Cateogry to store different categories
enum Category { strength, cardio, flexibility, balance, yoga, other }

// to use uuid functions which helps in creating unique IDs without collision
final uuid = Uuid();

// to format the datetime
final formatter = DateFormat().add_yMd();

// a workout model with specific attributes and functionalities
class Workout {
  Workout({
    required this.title,
    required this.category,
    required this.duration,
    required this.date,
  }) : id = uuid.v4();

  final String id; // workout id
  final String title; // workout title (eg. Push Ups)
  final Category category; // workout category (eg. strength)
  final double duration; // workout duration (eg. 20 mins)
  final DateTime date; // workout date (eg. 06/08/2025 i.e. Jun 06, 2025)

  // function to get formatted date based on the format string passed during call
  String formattedDate({formatString = "yMd"}) {
    return switch (formatString) {
      "y" => DateFormat().add_y().format(date),
      "yM" => DateFormat().add_yMMM().format(date),
      "MMM" => DateFormat().add_MMM().format(date),
      "MMMd" => DateFormat().add_MMMd().format(date),
      _ => formatter.format(date),
    };
  }

  Widget getCategoryIcon() {
    return switch (category) {
      Category.strength => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(
          Icons.fitness_center,
          size: 30,
          // color: getCategoryColor()
        ),
      ),
      Category.cardio => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(
          Icons.directions_run,
          size: 30,
          //  color: getCategoryColor()
        ),
      ),
      Category.flexibility => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(
          Icons.accessibility_new,
          size: 30,
          // color: getCategoryColor(),
        ), // balcony
      ),
      Category.balance => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(
          Icons.balance,
          size: 30,
          //  color: getCategoryColor()
        ),
      ),
      Category.yoga => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(
          Icons.self_improvement,
          size: 30,
          // color: getCategoryColor()
        ),
      ),
      _ => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(
          Icons.category,
          size: 30,
          // color: getCategoryColor()
        ),
      ),
    };
  }

  Color getCategoryColor() {
    return switch (category) {
      Category.strength => Colors.red.shade600,
      Category.cardio => Colors.blue.shade600,
      Category.flexibility => Colors.green.shade600,
      Category.balance => Colors.yellow.shade600,
      Category.yoga => Colors.purple.shade600,
      _ => Colors.grey.shade600,
    };
  }
}