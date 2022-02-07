import 'package:flutter/services.dart';

/// This class compiles a given brain f*ck code
/// A brain f*ck code is composed of:
///  - a one dimentional array of length 30,000 bytes all initialized to 0 and
///  - symbols > < , . + - and [ ] to manipulate the array.
///
/// Each symbol is used as follows
///  - `>` to move the pointer to one index to the right
///  - `<` to move the pointer to one index to the left
///  - `,` to request input and store it at the current pointer location
///  - `.` to output the value at the current pointer location
///  - `+` to increment the value at the current pointer location by one
///  - `-` to decrement the value at the current pointer location by one
///  - `[ ]` to execute the code inside the brackets in a loop until the value at the current pointer location is zero
///
/// Other values/symbols are ignored and considered as comments as the standard of the original compiler
class Compiler {
  final List<int> _array = List.filled(30000, 0, growable: false);
  int _index = 0;
  int _inputCounter = 0;
  // PUBLIC METHODS

  /// This function interpretes [command] as a brainf*cked code with optional inputs [inputs] if requested.
  ///
  /// If [command] requests inputs while [inputs] is empty then 0 is given by default
  ///
  ///
  /// It returns the output created by `.` commands in [command].
  /// But if [command] doesn't produce any outputs empty string is returned
  Future<List<String>?> compile(String command,
      {List<int> inputs = const []}) async {
    _clear();
    if (!_parseInput(command)) return null;
    inputs = _getParsedInputs(command, inputs);
    List<String> output = parse(command, inputs: inputs);
    return output;
  }

  List<String> parse(String command, {List<int> inputs = const []}) {
    List<String> output = [];
    for (int i = 0; i < command.length; i++) {
      // for each input variable
      switch (command.codeUnitAt(i)) {
        case 62: // >
          _incrementIndex();
          break;
        case 60: // <
          _decrementIndex();
          break;
        case 43: // +
          _incrementValue();
          break;
        case 45: // -
          _decrementValue();
          break;
        case 44: // ,
          _setInput(inputs[_inputCounter++]);
          break;
        case 46: // .
          // output += _getOutput();
          output.add(_getOutput());
          break;
        case 91: // [
          while (_array[_index] != 0) {
            // loop
            //output +=
            output.addAll(
                parse(command.substring(i + 1, _indexOfBracket(command, i))));
          }
          i = _indexOfBracket(command, i) + 1;
          break;
        default: // comment character
      }
    }
    return output;
  }

  int getInputCount(String command) {
    return command.codeUnits.where((element) => element == 44).length;
  }

  // PRIVATE METHODS

  void _clear() {
    _array.setAll(0, List.filled(30000, 0, growable: false));
    _inputCounter = 0;
    _index = 0;
  }

  bool _parseInput(String command) {
    int exCloBrackets = 0;
    for (int codeUnit in command.codeUnits) {
      if (codeUnit == 91) {
        exCloBrackets++;
      } else if (codeUnit == 93) {
        if (--exCloBrackets < 0) return false;
      }
    }
    return exCloBrackets == 0;
  }

  /// Unsafe method
  int _indexOfBracket(String command, int index) {
    int counter = 0;
    for (int i = index + 1; i < command.length; i++) {
      if (command.codeUnitAt(i) == 91) {
        counter++;
      } else if (command.codeUnitAt(i) == 93) {
        if (counter == 0) return i;
        counter--;
      }
    }
    return -1;
  }

  List<int> _getParsedInputs(String command, List<int> inputs) {
    int counter = 0;
    for (int unit in command.codeUnits) {
      if (unit == 44) counter++;
    }
    if (counter == 0) return [];
    return counter > inputs.length
        ? List<int>.generate(
            counter, (index) => index < inputs.length - 1 ? inputs[index] : 0)
        : inputs;
  }

  void _incrementIndex() {
    if (_index == 29999) {
      _index = 0;
    } else {
      _index++;
    }
  }

  void _decrementIndex() {
    if (_index == 0) {
      _index = 29999;
    } else {
      _index--;
    }
  }

  void _incrementValue() {
    if (_array[_index] == 255) {
      _array[_index] = 0;
    } else {
      _array[_index]++;
    }
  }

  void _decrementValue() {
    if (_array[_index] == 0) {
      _array[_index] = 255;
    } else {
      _array[_index]--;
    }
  }

  void _setInput(int input) {
    _array[_index] = input.abs() % 256; // set input inside a byte limit
  }

  String _getOutput() {
    return String.fromCharCode(_array[_index]);
  }
}
