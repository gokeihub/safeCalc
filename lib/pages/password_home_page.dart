import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculetor/pages/home_page.dart';
import '../package/double_back_to_close_app.dart';
import '../utils/button.dart';

class PasswordHomePage extends StatefulWidget {
  // ignore: use_super_parameters
  const PasswordHomePage({key}) : super(key: key);

  @override
  State<PasswordHomePage> createState() => _PasswordHomePageState();
}

class _PasswordHomePageState extends State<PasswordHomePage> {
  var input = '';

  addNumber(String value) {
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

  late _AppLifecycleObserver _appLifecycleObserver;

  @override
  void initState() {
    super.initState();
    _appLifecycleObserver = _AppLifecycleObserver();
    WidgetsBinding.instance.addObserver(_appLifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appLifecycleObserver);
    super.dispose();
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
                      child: AutoSizeText(
                        input,
                        maxLines: 3,
                        maxFontSize: 40,
                        minFontSize: 20,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SelectableText(
                        '',
                        style: TextStyle(color: Colors.white38, fontSize: 30),
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
                      if (input == '01907') {
                        _appLifecycleObserver.setPasswordPageVisibility(false);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (b) => const HomePage(),
                        ));
                      }
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

class _AppLifecycleObserver extends WidgetsBindingObserver {
  bool _isPasswordPageVisible = true;

  void setPasswordPageVisibility(bool isVisible) {
    _isPasswordPageVisible = isVisible;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isPasswordPageVisible && state == AppLifecycleState.paused) {
      SystemNavigator.pop();
    }
  }
}
