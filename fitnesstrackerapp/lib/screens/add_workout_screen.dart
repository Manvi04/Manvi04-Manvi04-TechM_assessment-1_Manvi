import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key, required this.onAddWorkoutButtonPress});

  final void Function(Workout) onAddWorkoutButtonPress;

  @override
  AddWorkoutScreenState createState() {
    return AddWorkoutScreenState();
  }
}

class AddWorkoutScreenState extends State<AddWorkoutScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  Category selectedCategory = Category.other;
  DateTime selectedDate = DateTime.now();

  // Function to validate inputs and return an error message if any
  String validateInputs() {
    final String errorMessage;
    if (titleController.text.isEmpty || durationController.text.isEmpty) {
      errorMessage = 'Please fill in all fields';
    } else if (double.tryParse(durationController.text) == null ||
        double.parse(durationController.text) <= 0) {
      errorMessage = 'Please enter a valid duration';
    } else {
      errorMessage = '';
    }
    return errorMessage;
  }

  // Function to show a dialog with the validation message
  void showValidationDialog(String message) {
    // Show a dialog with the validation message
    if (message.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to get the category icon based on the selected category
  Widget getCategoryIcon(Category category) {
    // Returns a CircleAvatar with an icon based on the category
    // and a background color that matches the category.
    return switch (category) {
      Category.strength => CircleAvatar(
        backgroundColor: Colors.red.shade600.withAlpha(185),
        child: Icon(Icons.fitness_center, size: 30),
      ),
      Category.cardio => CircleAvatar(
        backgroundColor: Colors.blue.shade600.withAlpha(185),
        child: Icon(Icons.directions_run, size: 30),
      ),
      Category.flexibility => CircleAvatar(
        backgroundColor: Colors.green.shade600.withAlpha(185),
        child: Icon(Icons.accessibility_new, size: 30),
      ),
      Category.balance => CircleAvatar(
        backgroundColor: Colors.yellow.shade600.withAlpha(175),
        child: Icon(Icons.balance, size: 30),
      ),
      Category.yoga => CircleAvatar(
        backgroundColor: Colors.purple.shade600.withAlpha(175),
        child: Icon(Icons.self_improvement, size: 30),
      ),
      _ => CircleAvatar(
        backgroundColor: Colors.grey.shade600.withAlpha(175),
        child: Icon(Icons.category, size: 30),
      ),
    };
  }

  // Function to open the date picker and set the selected date
  void openDatePicker() async {
    DateTime firstDate = DateTime(2025, 1, 1);
    DateTime lastDate = DateTime(2025, 12, 31);

    final dateSelected = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    // If the user selects a date, update the selectedDate state
    // If the user cancels the date picker, dateSelected will be null
    // and does not update the selectedDate state.
    if (dateSelected != null) {
      setState(() {
        selectedDate = dateSelected;
      });
    }
  }

  // Function to build the dropdown label with the category icon and name
  Widget buildDropdownLabel(Category category, {bool isSelected = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Use the getCategoryIcon method to get the icon for the category
        getCategoryIcon(category),
        const SizedBox(width: 10),
        Text(
          // capitalize the first letter of the category name
          category.name[0].toUpperCase() + category.name.substring(1),
          style: TextStyle(
            color: isSelected ? Color(0xFFB76D68) : Colors.white,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new workout'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Image.asset(
              'assets/images/add_workout.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            TextField(
              maxLength: 50,
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final double parentWidth = constraints.maxWidth;

                return Theme(
                  data: Theme.of(context).copyWith(
                    dropdownMenuTheme: DropdownMenuThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white, width: 1),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color(0xFFB76D68),
                            width: 2,
                          ),
                        ),

                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFF2C2B3C),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(
                            parentWidth,
                            double.infinity,
                          ), // Match parent width
                        ),
                        elevation: WidgetStateProperty.all(5),
                      ),
                    ),
                  ),
                  child: DropdownMenu<Category>(
                    width: parentWidth,
                    initialSelection: selectedCategory,
                    label: const Text('Select Category'),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: Category.strength,
                        label: 'Strength',
                        labelWidget: buildDropdownLabel(Category.strength),
                      ),
                      DropdownMenuEntry(
                        value: Category.cardio,
                        label: 'Cardio',
                        labelWidget: buildDropdownLabel(Category.cardio),
                      ),
                      DropdownMenuEntry(
                        value: Category.flexibility,
                        label: 'Flexibility',
                        labelWidget: buildDropdownLabel(Category.flexibility),
                      ),
                      DropdownMenuEntry(
                        value: Category.balance,
                        label: 'Balance',
                        labelWidget: buildDropdownLabel(Category.balance),
                      ),
                      DropdownMenuEntry(
                        value: Category.yoga,
                        label: 'Yoga',
                        labelWidget: buildDropdownLabel(Category.yoga),
                      ),
                      DropdownMenuEntry(
                        value: Category.other,
                        label: 'Other',
                        labelWidget: buildDropdownLabel(
                          Category.other,
                          isSelected: true,
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: durationController,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      suffixText: 'min',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Spacer(),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.right,
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis, // prevent overflow
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          openDatePicker();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF403F4C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    fixedSize: Size(150, 50),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    final validationMessage = validateInputs();
                    // If validation fails, show a dialog and return
                    if (validationMessage.isNotEmpty) {
                      showValidationDialog(validationMessage);
                      return;
                    }
                    // Create a new Workout object and pass it to the callback
                    Workout workout = Workout(
                      title: titleController.text,
                      category: selectedCategory,
                      duration: double.parse(durationController.text),
                      date: selectedDate,
                    );
                    widget.onAddWorkoutButtonPress(workout);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('New workout added'),
                        elevation: 5,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFB76D68),
                    fixedSize: Size(150, 50),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}