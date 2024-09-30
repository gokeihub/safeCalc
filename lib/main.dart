import 'package:calculetor/pages/Home/pages/image_page.dart';
import 'package:calculetor/pages/calculator_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white70),
      ),
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:math_expressions/math_expressions.dart';

// void main() => runApp(AdvancedCalculator());

// class AdvancedCalculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Advanced Flutter Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CalculatorHomePage(),
//     );
//   }
// }

// class CalculatorHomePage extends StatefulWidget {
//   @override
//   _CalculatorHomePageState createState() => _CalculatorHomePageState();
// }

// class _CalculatorHomePageState extends State<CalculatorHomePage> {
//   String _expression = '';
//   String _result = '0';

//   final List<String> buttons = [
//     '7', '8', '9', 'DEL', 'AC',
//     '4', '5', '6', '×', '÷',
//     '1', '2', '3', '+', '-',
//     '0', '.', '=', '(', ')',
//     'sin', 'cos', 'tan', 'cot', '√',
//     'log', 'ln', 'π', 'e', '^',
//     'Deg', 'Rad', '!', 'mod', 'EXP'
//   ];

//   /// Function to handle button presses
//   void buttonPressed(String buttonText) {
//     setState(() {
//       if (buttonText == 'AC') {
//         _expression = '';
//         _result = '0';
//       } else if (buttonText == 'DEL') {
//         _expression = _expression.length > 0
//             ? _expression.substring(0, _expression.length - 1)
//             : '';
//       } else if (buttonText == '=') {
//         _result = evaluateExpression(_expression);
//       } else if (buttonText == 'Deg' || buttonText == 'Rad') {
//         // Handle degree to radian toggle (this is a simplified toggle)
//         _expression += (buttonText == 'Deg') ? '*' + (3.14159 / 180).toString() : '';
//       } else if (buttonText == 'π') {
//         _expression += '3.14159';
//       } else if (buttonText == 'e') {
//         _expression += '2.71828';
//       } else {
//         _expression += buttonText;
//       }
//     });
//   }

//   /// Function to evaluate the mathematical expression using `math_expressions` package
//   String evaluateExpression(String expression) {
//     try {
//       Parser p = Parser();
//       Expression exp = p.parse(expression.replaceAll('×', '*').replaceAll('÷', '/'));
//       ContextModel cm = ContextModel();
//       double eval = exp.evaluate(EvaluationType.REAL, cm);
//       return eval.toString();
//     } catch (e) {
//       return 'Error';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Advanced Flutter Calculator'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           // Horizontal scroll for input and result
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               reverse: true,
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 _expression,
//                 style: TextStyle(fontSize: 28),
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               reverse: true,
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 _result,
//                 style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
          
//           // Non-scrollable, responsive button layout
//           Expanded(
//             flex: 3,
//             child: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 double buttonHeight = constraints.maxHeight / 6;
//                 double buttonWidth = constraints.maxWidth / 5;

//                 return GridView.builder(
//                   physics: NeverScrollableScrollPhysics(), // Make buttons non-scrollable
//                   itemCount: buttons.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 5,
//                     childAspectRatio: buttonWidth / buttonHeight,
//                   ),
//                   itemBuilder: (BuildContext context, int index) {
//                     return CalculatorButton(
//                       buttonText: buttons[index],
//                       onTap: () => buttonPressed(buttons[index]),
//                       width: buttonWidth,
//                       height: buttonHeight,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CalculatorButton extends StatelessWidget {
//   final String buttonText;
//   final VoidCallback onTap;
//   final double width;
//   final double height;

//   const CalculatorButton({
//     required this.buttonText,
//     required this.onTap,
//     required this.width,
//     required this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ElevatedButton(
//         onPressed: onTap,
//         child: Text(
//           buttonText,
//           style: TextStyle(fontSize: 20),
//         ),
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.all(8.0),
//           minimumSize: Size(width, height),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
