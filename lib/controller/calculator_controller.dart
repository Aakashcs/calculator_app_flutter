import '../stack.dart';

class CalculatorController {
  // top horizontal inputs
  String inputString = '';
  String output = "";
  String lastNumber = "";

  bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

  buttonPressed(String buttonText) {
    if (buttonText == 'AC') {
      inputString = '';
      lastNumber = "";
      output = "0";
    } else if (buttonText == "＋" ||
        buttonText == "－" ||
        buttonText == "÷" ||
        buttonText == "x") {
      if (lastNumber.isEmpty) {
        inputString = inputString.substring(0, inputString.length - 1);
      }
      inputString += buttonText;
      lastNumber = "";
    } else if (buttonText == '%') {
    } else if (buttonText == '+/-') {
    } else if (buttonText == "＝") {
      output = calculate(inputString);
    } else if (buttonText == "." &&
        (inputString.endsWith(".") || lastNumber.isEmpty)) {
    } else {
      inputString += buttonText;
      lastNumber = buttonText;
    }
  }

  calculate(String exp) {
    Stack<String> ops = Stack();
    Stack<double> values = Stack();

    for (int i = 0; i < exp.length; i++) {
      if (isDigit(exp, i)) {
        String val = "";

        while (i < exp.length && (isDigit(exp, i) || exp[i] == ".")) {
          val += exp[i];
          i++;
        }
        i--;
        values.push(double.parse(val));
        print('val = $val');
      } else {
        while (ops.isNotEmpty && precedence(ops.peek) >= precedence(exp[i])) {
          double val2 = values.pop();
          double val1 = values.pop();
          String operator = ops.pop();
          values.push(applyOperator(val1, val2, operator));
        }

        ops.push(exp[i]);
      }
    }

    while (ops.isNotEmpty) {
      double val2 = values.pop();
      double val1 = values.pop();
      String operator = ops.pop();
      values.push(applyOperator(val1, val2, operator));
    }

    return values.pop().toString();
  }

  int precedence(String op) {
    if (op == '＋' || op == '－')
      return 1;
    else if (op == 'x' || op == '÷') return 2;

    return 0;
  }

  applyOperator(double a, double b, String op) {
    switch (op) {
      case '＋':
        {
          return a + b;
        }
      case '－':
        {
          return a - b;
        }
      case 'x':
        {
          return a * b;
        }
      case '÷':
        {
          return a ~/ b;
        }
    }
  }
}
