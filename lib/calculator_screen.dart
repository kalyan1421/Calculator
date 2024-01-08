// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool isDarkMode = false;
  String _input = '';
  String _output = '';

  // void _onButtonPressed(String buttonText) {
  //   if (buttonText == '=') {
  //     _calculate();
  //   } else if (buttonText == 'Del') {
  //     _delete();
  //   } else if (buttonText == 'C') {
  //     _clear();
  //   } else if (buttonText == '00') {
  //     _addDoubleZero();
  //   } else if (buttonText == '%') {
  //     if (_input.isNotEmpty) {
  //       final lastChar = _input[_input.length - 1];
  //       if (lastChar != '%') {
  //         setState(() {
  //           _input += buttonText;
  //         });
  //       }
  //     }
  //   } else {
  //     if (buttonText == '×') {
  //       buttonText = '*';
  //     } else if (buttonText == '÷') {
  //       buttonText = '/';
  //     }
  //     setState(() {
  //       _input += buttonText;
  //     });
  //   }
  // }
  void _onButtonPressed(String buttonText) {
    if (buttonText == 'Del') {
      _delete();
    } else if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '00') {
      _addDoubleZero();
    } else if (buttonText == '%') {
      if (_input.isNotEmpty) {
        final lastChar = _input[_input.length - 1];
        if (lastChar != '%') {
          setState(() {
            _input += buttonText;
          });
        }
      }
    } else {
      if (buttonText == '×') {
        buttonText = '*';
      } else if (buttonText == '÷') {
        buttonText = '/';
      }
      setState(() {
        _input += buttonText;
      });
    }

    // Update the output for all cases
    _calculate();
  }

  void _delete() {
    if (_input.isNotEmpty) {
      setState(() {
        _input = _input.substring(0, _input.length - 1);
      });
    }
  }

  void _calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _output = result.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error';
      });
    }
  }

  void _clear() {
    setState(() {
      _input = '';
      _output = '';
    });
  }

  void _addDoubleZero() {
    setState(() {
      _input += '00';
    });
  }

  final List<String> buttons = [
    'C',
    'Del',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '00',
    '.',
    '=',
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Text(
                _input,
                style: TextStyle(
                    fontSize: _input.length > 15 ? 20.0 : 24.0,
                    color: Colors.grey.shade500),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Text(
                _output.isNotEmpty ? "$_output" : '',
                style: TextStyle(fontSize: _output.length > 10 ? 38.0 : 48.0),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 50),
          ),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.2,
              crossAxisCount: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CalculatorButton(
                  text: buttons[index],
                  callback: _onButtonPressed,
                  isDarkMode: isDarkMode,
                );
              },
              childCount: buttons.length,
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function callback;
  final bool isDarkMode;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.callback,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color buttontextcolor;
    if (text == '1' ||
        text == '2' ||
        text == '3' ||
        text == '4' ||
        text == '5' ||
        text == '6' ||
        text == '7' ||
        text == '8' ||
        text == '9' ||
        text == '0' ||
        text == '00' ||
        text == '.') {
      buttonColor = Colors.white;
      buttontextcolor = Colors.black;
    } else if (text == '=') {
      buttonColor = Colors.indigo.shade500;
      buttontextcolor = Colors.white;
    } else {
      buttonColor = Colors.indigo.shade200;
      buttontextcolor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => callback(text),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: .5,
              style: BorderStyle.solid,
              color: isDarkMode ? Colors.black45 : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black26.withOpacity(0.3)
                    : Colors.grey.shade300.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: buttontextcolor,
            ),
          ),
        ),
      ),
    );
  }
}
