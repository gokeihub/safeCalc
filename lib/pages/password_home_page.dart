import 'package:calculetor/package/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'home_page.dart';

class PasswordHomePage extends StatefulWidget {
  const PasswordHomePage({super.key});

  @override
  State<PasswordHomePage> createState() => _PasswordHomePageState();
}

class _PasswordHomePageState extends State<PasswordHomePage>
    with WidgetsBindingObserver {
  var input = '';
  String? storedPassword;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkFirstTime();
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

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedPassword = prefs.getString('password');

    if (storedPassword == null) {
      isFirstTime = true;
      _showSetPasswordDialog();
    } else {
      isFirstTime = false;
    }
    setState(() {});
  }

  Future<void> _savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
    storedPassword = password;
    setState(() {});
  }

  void _showSetPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPassword = '';
        return AlertDialog(
          title: const Text('Set Password'),
          content: TextField(
            onChanged: (value) {
              newPassword = value;
            },
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Number ....'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (newPassword.isNotEmpty) {
                  _savePassword(newPassword);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void addNumber(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
      } else if (value == 'Del') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input = input + value;
      }
    });
  }

  void _submitPassword() {
    if (isFirstTime) {
      _savePassword(input).then((_) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      });
    } else {
      if (input == storedPassword) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      } else {}
    }
    input = '';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
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
                      child: Text(
                        input,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        isFirstTime ? 'Set a password' : 'Enter password',
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
                endIndent: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: 'C',
                    textColor: Colors.red,
                    onTap: () {
                      addNumber("C");
                    },
                  ),
                  Button(
                    text: '()',
                    textColor: Colors.green,
                    onTap: () {},
                  ),
                  Button(
                    text: '%',
                    textColor: Colors.green,
                    onTap: () {},
                  ),
                  Button(
                    text: '÷',
                    textColor: Colors.green,
                    onTap: () {
                      addNumber("÷");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: '7',
                    onTap: () {
                      addNumber("7");
                    },
                  ),
                  Button(
                    text: '8',
                    onTap: () {
                      addNumber("8");
                    },
                  ),
                  Button(
                    text: '9',
                    onTap: () {
                      addNumber("9");
                    },
                  ),
                  Button(
                    text: '×',
                    textColor: Colors.green,
                    onTap: () {
                      addNumber("×");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: '4',
                    onTap: () {
                      addNumber("4");
                    },
                  ),
                  Button(
                    text: '5',
                    onTap: () {
                      addNumber("5");
                    },
                  ),
                  Button(
                    text: '6',
                    onTap: () {
                      addNumber("6");
                    },
                  ),
                  Button(
                    text: '-',
                    textColor: Colors.green,
                    onTap: () {
                      addNumber("-");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: '1',
                    onTap: () {
                      addNumber("1");
                    },
                  ),
                  Button(
                    text: '2',
                    onTap: () {
                      addNumber("2");
                    },
                  ),
                  Button(
                    text: '3',
                    onTap: () {
                      addNumber("3");
                    },
                  ),
                  Button(
                    text: '+',
                    textColor: Colors.green,
                    onTap: () {
                      addNumber("+");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    text: '0',
                    onTap: () {
                      addNumber("0");
                    },
                  ),
                  Button(
                    text: '.',
                    onTap: () {
                      addNumber(".");
                    },
                  ),
                  Button(
                    text: 'Del',
                    boxColor: Colors.red,
                    onTap: () {
                      if (input.isNotEmpty) {
                        input = input.substring(0, input.length - 1);
                        setState(() {});
                      }
                    },
                  ),
                  Button(
                    text: '=',
                    boxColor: Colors.green,
                    onTap: () {
                      _submitPassword();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final Color? boxColor;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.white,
    this.boxColor = const Color.fromARGB(115, 61, 57, 57),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.24,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: boxColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 40,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
