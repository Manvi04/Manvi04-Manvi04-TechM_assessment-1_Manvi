import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BmiScreenState();
  }
}

class BmiScreenState extends State<BmiScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  double? bmi;

  calculateBMI() {
    if (heightController.text.isEmpty || weightController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Input Error'),
            content: Text('Please enter both height and weight'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    double height =
        double.parse(heightController.text) / 100; // Convert cm to m
    double weight = double.parse(weightController.text);
    setState(() {
      bmi = weight / (height * height);
    });
  }

  conditionBMI(double bmi) {
    if (bmi < 18.5) {
      return Text(
        'Underweight',
        style: TextStyle(fontSize: 24, color: Colors.red),
      );
    } else if (bmi < 24.9) {
      return Text(
        'Normal weight',
        style: TextStyle(fontSize: 24, color: Colors.green),
      );
    } else if (bmi < 29.9) {
      return Text(
        'Overweight',
        style: TextStyle(fontSize: 24, color: Colors.orange),
      );
    } else {
      return Text('Obesity', style: TextStyle(fontSize: 24, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121420),
      appBar: AppBar(
        title: Text('BMI'),
        centerTitle: true,
        backgroundColor: Color(0xFFB76D68),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Calculate Your BMI',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 10),
                // Image.asset is used to display an image from the assets folder
                Image.asset('assets/images/bmi.png', width: 200, height: 200),
                SizedBox(height: 20),
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(labelText: 'Weight (Kg)'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Color(0xFFB76D68),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                if (bmi != null)
                  Column(
                    children: [
                      Text(
                        'Your BMI is:',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        bmi!.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB76D68),
                        ),
                      ),
                      SizedBox(height: 10),
                      conditionBMI(bmi!),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}