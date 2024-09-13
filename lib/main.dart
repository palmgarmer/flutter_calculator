import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _changeTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
      ),
      home: MyHomePage(changeTheme: _changeTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback changeTheme;

  MyHomePage({required this.changeTheme});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _resultController = TextEditingController();
  final evaluator = const ExpressionEvaluator();

  void _calculator(String text) {
    setState(() {
      if (text == 'c') {
        _resultController.clear();
      } else if (text == '+/-') {
        if (_resultController.text.isNotEmpty) {
          if (_resultController.text.startsWith('-')) {
            _resultController.text = _resultController.text.substring(1);
          } else {
            _resultController.text = '-${_resultController.text}';
          }
        }
      } else if (text == '=') {
        try {
          final expression = Expression.parse(
              _resultController.text.replaceAll('×', '*').replaceAll('÷', '/'));
          final result = evaluator.eval(expression, {});
          _resultController.text = result.toString();
        } catch (e) {
          _resultController.text = 'Error';
        }
      } else {
        _resultController.text += text;
      }
    });
  }

  Widget _buildButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        _calculator(text);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: Colors.black,
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }

  Widget _buildVerticalButton(BuildContext context, String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        _calculator(text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: text
            .split('')
            .map((char) => Text(
                  char,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.brightness_6),
                      onPressed: widget.changeTheme,
                      iconSize: 20,
                    ),
                    Expanded(
                      child: Text(
                        _resultController.text,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Digital-7',
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildButton(context, 'c'),
                  ),
                  Expanded(
                    child: _buildButton(context, '+/-'),
                  ),
                  Expanded(
                    child: _buildButton(context, '%'),
                  ),
                  Expanded(
                    child: _buildButton(context, '÷'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildButton(context, '7'),
                  ),
                  Expanded(
                    child: _buildButton(context, '8'),
                  ),
                  Expanded(
                    child: _buildButton(context, '9'),
                  ),
                  Expanded(
                    child: _buildButton(context, '×'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildButton(context, '4'),
                  ),
                  Expanded(
                    child: _buildButton(context, '5'),
                  ),
                  Expanded(
                    child: _buildButton(context, '6'),
                  ),
                  Expanded(
                    child: _buildButton(context, '+'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildButton(context, '1'),
                  ),
                  Expanded(
                    child: _buildButton(context, '2'),
                  ),
                  Expanded(
                    child: _buildButton(context, '3'),
                  ),
                  Expanded(
                    child: _buildButton(context, '-'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildButton(context, '0'),
                  ),
                  Expanded(
                    child: _buildButton(context, '.'),
                  ),
                  Expanded(
                    child: _buildVerticalButton(context, '=', Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
