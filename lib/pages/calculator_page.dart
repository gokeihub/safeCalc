// ignore_for_file: use_build_context_synchronously
//! old code use only 23 line not change
import 'dart:io';
import 'package:calculetor/package/double_back_to_close_app.dart';
import 'package:calculetor/pages/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'Home/widget/button_widget.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with WidgetsBindingObserver {
  var input = '';
  String? savedPassword;
  String? calculationResult = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPassword();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      exit(0);
    }
  }

  Future<void> _loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedPassword = prefs.getString('savedPassword');
    });
  }

  void addNumber(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        calculationResult = null;
      } else if (value == 'Del') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '%') {
        input += '/100';
      } else if (value == '()') {
        if (input.isEmpty ||
            input.endsWith('(') ||
            input.endsWith('+') ||
            input.endsWith('-') ||
            input.endsWith('×') ||
            input.endsWith('÷')) {
          input += '(';
        } else if (input.endsWith(')')) {
          input += '*(';
        } else {
          int openCount = 0;
          int closeCount = 0;
          for (var char in input.split('')) {
            if (char == '(') openCount++;
            if (char == ')') closeCount++;
          }
          if (openCount > closeCount) {
            input += ')';
          } else {
            input += '(';
          }
        }
      } else {
        input += value;
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      NumberFormat formatter = NumberFormat('#,##0.################');
      return formatter.format(eval);
    } catch (e) {
      return 'Error';
    }
  }

  void handlePasswordSubmission() {
    if (input == savedPassword) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (builder) => StartPage(),
        ),
      );
      input = '';
      calculationResult = '';
    } else {}
  }

  void setPassword() {
    showDialog(
      context: context,
      builder: (context) {
        String oldPasswordInput = '';
        return AlertDialog(
          title: const Text('Enter Old Password'),
          content: TextField(
            onChanged: (value) {
              oldPasswordInput = value;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Old Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (savedPassword == null ||
                    oldPasswordInput == savedPassword) {
                  Navigator.of(context).pop();
                  _promptNewPassword();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Old password is incorrect')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _promptNewPassword() {
    showDialog(
      context: context,
      builder: (context) {
        String newPassword = '';
        return AlertDialog(
          title: const Text('Set New Password'),
          content: TextField(
            onChanged: (value) {
              newPassword = value;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter New Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newPassword.isNotEmpty) {
                  setState(() {
                    savedPassword = newPassword;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('savedPassword', newPassword);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Password changed successfully')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to leave')),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          padding: EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SelectableText(
                              input,
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (calculationResult != null)
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            padding: EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SelectableText(
                                calculationResult!,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(
                    color: Color.fromARGB(115, 84, 77, 77),
                    thickness: 2,
                    indent: 15,
                    endIndent: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(
                        text: 'C',
                        textColor: Colors.red,
                        onTap: () => addNumber("C")),
                    ButtonWidget(
                        text: '()',
                        textColor: Colors.green,
                        onTap: () => addNumber("()")),
                    ButtonWidget(
                        text: '%',
                        textColor: Colors.green,
                        onTap: () => addNumber("%")),
                    ButtonWidget(
                        text: '÷',
                        textColor: Colors.green,
                        onTap: () => addNumber("÷")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(text: '7', onTap: () => addNumber("7")),
                    ButtonWidget(text: '8', onTap: () => addNumber("8")),
                    ButtonWidget(text: '9', onTap: () => addNumber("9")),
                    ButtonWidget(
                        text: '×',
                        textColor: Colors.green,
                        onTap: () => addNumber("×")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(text: '4', onTap: () => addNumber("4")),
                    ButtonWidget(text: '5', onTap: () => addNumber("5")),
                    ButtonWidget(text: '6', onTap: () => addNumber("6")),
                    ButtonWidget(
                        text: '-',
                        textColor: Colors.green,
                        onTap: () => addNumber("-")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(text: '1', onTap: () => addNumber("1")),
                    ButtonWidget(text: '2', onTap: () => addNumber("2")),
                    ButtonWidget(text: '3', onTap: () => addNumber("3")),
                    ButtonWidget(
                        text: '+',
                        textColor: Colors.green,
                        onTap: () => addNumber("+")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonWidget(text: '0', onTap: () => addNumber("0")),
                    ButtonWidget(text: '.', onTap: () => addNumber(".")),
                    ButtonWidget(
                      text: 'Del',
                      boxColor: Colors.red,
                      onTap: () {
                        if (input.isNotEmpty) {
                          input = input.substring(0, input.length - 1);
                          setState(() {});
                        }
                      },
                    ),
                    GestureDetector(
                      onLongPress: setPassword,
                      child: ButtonWidget(
                        text: '=',
                        boxColor: Colors.green,
                        onTap: () {
                          if (savedPassword == null) {
                            _promptNewPassword();
                          } else {
                            String result = evaluateExpression(input);
                            setState(() {
                              calculationResult = result;
                            });
                            handlePasswordSubmission();
                            setState(() {});
                          }
                        },
                      ),
                    ),
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




// //ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:calculetor/package/double_back_to_close_app.dart';
// import 'package:calculetor/pages/main_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:math_expressions/math_expressions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'Home/widget/button_widget.dart';

// class CalculatorPage extends StatefulWidget {
//   const CalculatorPage({super.key});

//   @override
//   State<CalculatorPage> createState() => _CalculatorPageState();
// }

// class _CalculatorPageState extends State<CalculatorPage>
//     with WidgetsBindingObserver {
//   var input = '';
//   String? savedPassword;
//   String? calculationResult;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadPassword();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       exit(0);
//     }
//   }

//   Future<void> _loadPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       savedPassword = prefs.getString('savedPassword');
//     });
//   }

//   void addNumber(String value) {
//     setState(() {
//       if (value == 'C') {
//         input = '';
//         calculationResult = null;
//       } else if (value == 'Del') {
//         if (input.isNotEmpty) {
//           input = input.substring(0, input.length - 1);
//         }
//       } else if (value == '%') {
//         input += '/100';
//       } else if (value == '()') {
//         if (input.isEmpty ||
//             input.endsWith('(') ||
//             input.endsWith('+') ||
//             input.endsWith('-') ||
//             input.endsWith('×') ||
//             input.endsWith('÷')) {
//           input += '(';
//         } else if (input.endsWith(')')) {
//           input += '*(';
//         } else {
//           int openCount = 0;
//           int closeCount = 0;
//           for (var char in input.split('')) {
//             if (char == '(') openCount++;
//             if (char == ')') closeCount++;
//           }
//           if (openCount > closeCount) {
//             input += ')';
//           } else {
//             input += '(';
//           }
//         }
//       } else if (value == 'π') {
//         input += '3.141592653589793';
//       } else if (value == 'e') {
//         input += '2.718281828459045';
//       } else {
//         input += value;
//       }
//     });
//   }

//   String evaluateExpression(String expression) {
//     try {
//       expression = expression
//           .replaceAll('×', '*')
//           .replaceAll('÷', '/')
//           .replaceAll('√', 'sqrt')
//           .replaceAll('π', '3.141592653589793')
//           .replaceAll('e', '2.718281828459045');
//       Parser p = Parser();
//       Expression exp = p.parse(expression);
//       ContextModel cm = ContextModel();
//       double eval = exp.evaluate(EvaluationType.REAL, cm);
//       NumberFormat formatter = NumberFormat('#,##0.################');
//       return formatter.format(eval);
//     } catch (e) {
//       return 'Error';
//     }
//   }

//   void handlePasswordSubmission() {
//     if (input == savedPassword) {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (builder) => StartPage(),
//         ),
//       );
//       input = '';
//       calculationResult = '';
//     } else {}
//   }

//   void setPassword() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String oldPasswordInput = '';
//         return AlertDialog(
//           title: const Text('Enter Old Password'),
//           content: TextField(
//             onChanged: (value) {
//               oldPasswordInput = value;
//             },
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Old Password'),
//             obscureText: true,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (savedPassword == null ||
//                     oldPasswordInput == savedPassword) {
//                   Navigator.of(context).pop();
//                   _promptNewPassword();
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Old password is incorrect')),
//                   );
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _promptNewPassword() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String newPassword = '';
//         return AlertDialog(
//           title: const Text('Set New Password'),
//           content: TextField(
//             onChanged: (value) {
//               newPassword = value;
//             },
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(labelText: 'Enter New Password'),
//             obscureText: true,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (newPassword.isNotEmpty) {
//                   setState(() {
//                     savedPassword = newPassword;
//                   });
//                   final prefs = await SharedPreferences.getInstance();
//                   await prefs.setString('savedPassword', newPassword);
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Password changed successfully')),
//                   );
//                 }
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: DoubleBackToCloseApp(
//           snackBar: const SnackBar(content: Text('Tap back again to leave')),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               SizedBox(
//                 height: size.height * 0.2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         reverse: true,
//                         padding: EdgeInsets.all(20),
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: SelectableText(
//                             input,
//                             style: TextStyle(
//                               fontSize: 45,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     if (calculationResult != null)
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           reverse: true,
//                           padding: EdgeInsets.all(20),
//                           child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: SelectableText(
//                               calculationResult!,
//                               style: TextStyle(
//                                 fontSize: 35,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Color.fromARGB(115, 84, 77, 77),
//                 thickness: 2,
//                 indent: 15,
//                 endIndent: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: 'sin', onTap: () => addNumber("sin(")),
//                   ButtonWidget(text: 'cos', onTap: () => addNumber("cos(")),
//                   ButtonWidget(text: 'tan', onTap: () => addNumber("tan(")),
//                   ButtonWidget(text: '√', onTap: () => addNumber("√(")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: 'log', onTap: () => addNumber("log(")),
//                   ButtonWidget(text: 'ln', onTap: () => addNumber("ln(")),
//                   ButtonWidget(text: '^', onTap: () => addNumber("^")),
//                   ButtonWidget(text: 'π', onTap: () => addNumber("π")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(
//                       text: 'C',
//                       textColor: Colors.red,
//                       onTap: () => addNumber("C")),
//                   ButtonWidget(
//                       text: '()',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("()")),
//                   ButtonWidget(
//                       text: '%',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("%")),
//                   ButtonWidget(
//                       text: '÷',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("÷")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: '7', onTap: () => addNumber("7")),
//                   ButtonWidget(text: '8', onTap: () => addNumber("8")),
//                   ButtonWidget(text: '9', onTap: () => addNumber("9")),
//                   ButtonWidget(
//                       text: '×',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("×")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: '4', onTap: () => addNumber("4")),
//                   ButtonWidget(text: '5', onTap: () => addNumber("5")),
//                   ButtonWidget(text: '6', onTap: () => addNumber("6")),
//                   ButtonWidget(
//                       text: '-',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("-")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: '1', onTap: () => addNumber("1")),
//                   ButtonWidget(text: '2', onTap: () => addNumber("2")),
//                   ButtonWidget(text: '3', onTap: () => addNumber("3")),
//                   ButtonWidget(
//                       text: '+',
//                       textColor: Colors.green,
//                       onTap: () => addNumber("+")),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ButtonWidget(text: '0', onTap: () => addNumber("0")),
//                   ButtonWidget(text: '.', onTap: () => addNumber(".")),
//                   ButtonWidget(
//                     text: 'Del',
//                     boxColor: Colors.red,
//                     onTap: () {
//                       if (input.isNotEmpty) {
//                         input = input.substring(0, input.length - 1);
//                         setState(() {});
//                       }
//                     },
//                   ),
//                   GestureDetector(
//                     onLongPress: setPassword,
//                     child: ButtonWidget(
//                       text: '=',
//                       boxColor: Colors.green,
//                       onTap: () {
//                         if (savedPassword == null) {
//                           _promptNewPassword();
//                         } else {
//                           String result = evaluateExpression(input);
//                           setState(() {
//                             calculationResult = result;
//                           });
//                           handlePasswordSubmission();
//                           setState(() {});
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
