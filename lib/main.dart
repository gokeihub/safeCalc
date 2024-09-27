// import 'package:calculetor/firebase_options.dart';
import 'package:calculetor/pages/image_page.dart';
import 'package:calculetor/pages/password_home_page.dart';
import 'package:camera/camera.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PasswordHomePage(),
      home: PasswordHomePage(),
    );
  }
}





// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Simple Calculator')),
//         body: Calculator(),
//       ),
//     );
//   }
// }

// class Calculator extends StatefulWidget {
//   @override
//   _CalculatorState createState() => _CalculatorState();
// }

// class _CalculatorState extends State<Calculator> {
//   String _displayString = '0';
//   double _result = 0.0;
//   String _operation = '';

//   void _handleNumber(String number) {
//     setState(() {
//       if (_displayString == '0' || _displayString == 'Error') {
//         _displayString = number;
//       } else {
//         _displayString += number;
//       }
//     });
//   }

//   void _handleOperation(String operation) {
//     if (_operation != '') {
//       switch (_operation) {
//         case '+':
//           setState(() {
//             _result += double.parse(_displayString);
//             _displayString = _result.toString();
//           });
//           break;
//         case '-':
//           setState(() {
//             _result -= double.parse(_displayString);
//             _displayString = _result.toString();
//           });
//           break;
//         case '*':
//           setState(() {
//             _result *= double.parse(_displayString);
//             _displayString = _result.toString();
//           });
//           break;
//         case '/':
//           setState(() {
//             if (double.parse(_displayString) != 0) {
//               _result /= double.parse(_displayString);
//               _displayString = _result.toString();
//             } else {
//               _displayString = 'Error';
//             }
//           });
//           break;
//       }
//       _operation = '';
//     } else {
//       _result = double.parse(_displayString);
//       _operation = operation;
//       _displayString = '0';
//     }
//   }

//   void _handleClear() {
//     setState(() {
//       _displayString = '0';
//       _result = 0.0;
//       _operation = '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Text(
//           _displayString,
//           style: TextStyle(fontSize: 40.0),
//         ),
//         Row(
//           children: <Widget>[
//             _buildButton('7', () => _handleNumber('7')),
//             _buildButton('8', () => _handleNumber('8')),
//             _buildButton('9', () => _handleNumber('9')),
//             _buildButton('/', () => _handleOperation('/')),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             _buildButton('4', () => _handleNumber('4')),
//             _buildButton('5', () => _handleNumber('5')),
//             _buildButton('6', () => _handleNumber('6')),
//             _buildButton('*', () => _handleOperation('*')),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             _buildButton('1', () => _handleNumber('1')),
//             _buildButton('2', () => _handleNumber('2')),
//             _buildButton('3', () => _handleNumber('3')),
//             _buildButton('-', () => _handleOperation('-')),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             _buildButton('0', () => _handleNumber('0')),
//             _buildButton('.', () => _handleNumber('.')),
//             _buildButton('=', () => _handleOperation('')),
//             _buildButton('+', () => _handleOperation('+')),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             _buildButton('Clear', () => _handleClear()),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildButton(String label, Function()? onPressed) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: Text(
//             label,
//             style: TextStyle(fontSize: 20.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
