import 'package:flutter/material.dart';

void main() {
  runApp(const BrainFucked());
}

class BrainFucked extends StatelessWidget {
  const BrainFucked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BrainF*cked',
      home: Scaffold(
        body: Text('Hello world'),
      ),
    );
  }
}
