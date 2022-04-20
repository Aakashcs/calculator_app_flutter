import 'package:calculator_app/controller/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  CalculatorController calculator = CalculatorController();

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        backgroundColor: SchedulerBinding.instance!.window.platformBrightness ==
                Brightness.dark
            ? Color(0xFF242424)
            : Color(0xFFeeeeee),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(calculator.output,
                            maxLines: 1, style: TextStyle(fontSize: 60)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Keyboard(calculator: calculator, notifyParent: refresh)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  Keyboard({required this.calculator, required this.notifyParent});

  final CalculatorController calculator;
  final Function() notifyParent;

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
            ? Colors.white
            : Colors.black;
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        children: [
          ButtonRow([
            Button(
                text: "AC",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "+/-",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "%",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "÷",
                calculatorController: calculator,
                textColor: Color(0xFFe8822c),
                notifyParent: notifyParent),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(
                text: "7",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "8",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "9",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "x",
                calculatorController: calculator,
                textColor: Color(0xFFe8822c),
                notifyParent: notifyParent),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(
                text: "4",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "5",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "6",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "－",
                calculatorController: calculator,
                textColor: Color(0xFFe8822c),
                notifyParent: notifyParent),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(
                text: "1",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "2",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "3",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "＋",
                calculatorController: calculator,
                textColor: Color(0xFFe8822c),
                notifyParent: notifyParent),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(
                text: "0",
                calculatorController: calculator,
                textColor: buttonColor,
                flex: 2,
                notifyParent: notifyParent),
            Button(
                text: ".",
                calculatorController: calculator,
                textColor: buttonColor,
                notifyParent: notifyParent),
            Button(
                text: "＝",
                calculatorController: calculator,
                textColor: Color(0xFFe8822c),
                notifyParent: notifyParent),
          ]),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  ButtonRow(this.buttons);

  final List<Button> buttons;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buttons,
        ));
  }
}

class Button extends StatefulWidget {
  Button(
      {required this.text,
      required this.calculatorController,
      this.flex = 1,
      required this.notifyParent,
      this.textColor = Colors.white});

  final String text;
  final Color textColor;
  final CalculatorController calculatorController;
  final int flex;
  final Function() notifyParent;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  var clicked = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: widget.flex,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 5, vertical: widget.flex == 2 ? 10 : 0),
          decoration: BoxDecoration(
            color: SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.dark
                ? Color(0xFF242424)
                : Color(0xFFeeeeee),
            shape: widget.flex == 2 ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: widget.flex == 2 ? BorderRadius.circular(40) : null,
            boxShadow: [
              BoxShadow(
                  color: SchedulerBinding.instance!.window.platformBrightness ==
                          Brightness.dark
                      ? Colors.black.withAlpha(50)
                      : Colors.grey.shade300,
                  spreadRadius: 2.0,
                  blurRadius: 3.0,
                  offset: Offset(clicked ? -3.0 : 3.0, clicked ? -3.0 : 3.0)),
              BoxShadow(
                  color: SchedulerBinding.instance!.window.platformBrightness ==
                          Brightness.dark
                      ? Colors.black.withAlpha(5)
                      : Colors.grey.shade200,
                  spreadRadius: 2.0,
                  blurRadius: 3.0 / 2,
                  offset: Offset(-3.0, -3.0)),
            ],
          ),
          child: GestureDetector(
            onTapDown: (details) => {
              setState(() {
                clicked = true;
                widget.calculatorController.buttonPressed(widget.text);
                widget.notifyParent();
              })
            },
            onTapUp: (detals) => {
              setState(() {
                clicked = false;
              })
            },
            child: Container(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.text,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30, color: widget.textColor),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
