import 'package:brain_fuck_compiler/compiler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BrainFucked());
}

class BrainFucked extends StatefulWidget {
  const BrainFucked({Key? key}) : super(key: key);

  @override
  State<BrainFucked> createState() => _BrainFuckedState();
}

class _BrainFuckedState extends State<BrainFucked> {
  Compiler compiler = Compiler();
  TextEditingController controller = TextEditingController();
  String output = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainF*cked',
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLines: null,
                  onEditingComplete: () {},
                  enableInteractiveSelection: true,
                  decoration: const InputDecoration(
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          String? result =
                              compiler.parse(controller.value.text);
                          setState(() {
                            output = result ?? 'Error';
                          });
                        },
                        child: const Text('Run')),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    SelectableText(output),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
