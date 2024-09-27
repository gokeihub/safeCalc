import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculetor/pages/home_page.dart';
import '../package/double_back_to_close_app.dart';
import '../utils/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordHomePage extends StatefulWidget {
  const PasswordHomePage({super.key});

  @override
  State<PasswordHomePage> createState() => _PasswordHomePageState();
}

class _PasswordHomePageState extends State<PasswordHomePage>
    with WidgetsBindingObserver {
  var input = '';
  String? savedPassword;
  String? calculationResult;

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
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  void handlePasswordSubmission() {
    if (input == savedPassword) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  void setPassword() {
    showDialog(
      context: context,
      builder: (context) {
        String newPassword = '';
        return AlertDialog(
          title: const Text('Set Password'),
          content: TextField(
            onChanged: (value) {
              newPassword = value;
            },
            decoration: const InputDecoration(labelText: 'Enter new password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  savedPassword = newPassword;
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('savedPassword', newPassword);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AutoSizeText(
                        input,
                        maxLines: 3,
                        maxFontSize: 40,
                        minFontSize: 20,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    if (calculationResult != null)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          calculationResult!,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 30),
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
                  Button(
                      text: 'C',
                      textColor: Colors.red,
                      onTap: () => addNumber("C")),
                  Button(text: '()', textColor: Colors.green, onTap: () {}),
                  Button(text: '%', textColor: Colors.green, onTap: () {}),
                  Button(
                      text: '÷',
                      textColor: Colors.green,
                      onTap: () => addNumber("÷")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(text: '7', onTap: () => addNumber("7")),
                  Button(text: '8', onTap: () => addNumber("8")),
                  Button(text: '9', onTap: () => addNumber("9")),
                  Button(
                      text: '×',
                      textColor: Colors.green,
                      onTap: () => addNumber("×")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(text: '4', onTap: () => addNumber("4")),
                  Button(text: '5', onTap: () => addNumber("5")),
                  Button(text: '6', onTap: () => addNumber("6")),
                  Button(
                      text: '-',
                      textColor: Colors.green,
                      onTap: () => addNumber("-")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(text: '1', onTap: () => addNumber("1")),
                  Button(text: '2', onTap: () => addNumber("2")),
                  Button(text: '3', onTap: () => addNumber("3")),
                  Button(
                      text: '+',
                      textColor: Colors.green,
                      onTap: () => addNumber("+")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(text: '0', onTap: () => addNumber("0")),
                  Button(text: '.', onTap: () => addNumber(".")),
                  Button(
                      text: 'Del',
                      boxColor: Colors.red,
                      onTap: () {
                        if (input.isNotEmpty) {
                          input = input.substring(0, input.length - 1);
                          setState(() {});
                        }
                      }),
                  Button(
                      text: '=',
                      boxColor: Colors.green,
                      onTap: () {
                        if (savedPassword == null) {
                          setPassword();
                        } else {
                          String result = evaluateExpression(input);
                          setState(() {
                            calculationResult = result;
                          });
                          handlePasswordSubmission();
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
