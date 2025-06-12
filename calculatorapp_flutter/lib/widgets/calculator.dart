import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart' as math_expressions;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator> {
  String _expression = "";
  String screenText = "0";

  // Handles button press and updates the expression
  void onButtonGridPress(String label) {
    setState(() {
      if (label == 'AC') {
        _expression = '';
        screenText = '0';
      } else if (label == '%') {
        if (screenText != '0') {
          _expression += '%';
          screenText = _expression;
        }
      } else if (label == '.') {
        if (!_expression.contains('.')) {
          _expression += '.';
          screenText = _expression;
        }
      } else if (label == '=') {
        try {
          final expression = math_expressions.Parser().parse(
            _expression.replaceAll('X', '*'),
          );

          final contextModel = math_expressions.ContextModel();
          var answer = expression.evaluate(
            math_expressions.EvaluationType.REAL,
            contextModel,
          );

          if (_expression.contains("/0")) {
            answer = "Error: /zero";
          }

          screenText = answer.toString();
          _expression = answer.toString();
        } catch (e) {
          screenText = 'Error';
        }
      } else {
        _expression += label;
        screenText = _expression.isEmpty ? '0' : _expression;
      }
    });
  }

  // Builds a button with specific properties
  Widget buildButton({
    String label = "",
    bool isOperator = false,
    bool isAnswerButton = false,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5), // Adjusted margin for buttons
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator
                ? Colors.orangeAccent
                : (isAnswerButton ? Colors.greenAccent : Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 20), // Adjust padding
          ),
          onPressed: () => onButtonGridPress(label),
          child: Text(
            label,
            style: TextStyle(
              color: isOperator || isAnswerButton
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the top
        children: [
          // Calculator screen
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 244, 244),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    (screenText == '') ? '0' : screenText,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20), // Adjust height between screen and buttons

          // Button grid with 4 buttons per row
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton(label: "7"),
                    buildButton(label: "8"),
                    buildButton(label: "9"),
                    buildButton(label: "/", isOperator: true),
                  ],
                ),
                Row(
                  children: [
                    buildButton(label: "4"),
                    buildButton(label: "5"),
                    buildButton(label: "6"),
                    buildButton(label: "*", isOperator: true),
                  ],
                ),
                Row(
                  children: [
                    buildButton(label: "1"),
                    buildButton(label: "2"),
                    buildButton(label: "3"),
                    buildButton(label: "-", isOperator: true),
                  ],
                ),
                Row(
                  children: [
                    buildButton(label: "%", isOperator: true),
                    buildButton(label: "0"),
                    buildButton(label: ".", isOperator: true),
                    buildButton(label: "+", isOperator: true),
                  ],
                ),
                Row(
                  children: [
                    buildButton(label: "AC", isOperator: true),
                    buildButton(label: "=", isAnswerButton: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
