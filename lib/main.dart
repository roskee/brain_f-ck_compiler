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
  Widget output = const SelectableText('');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainF*cked',
      theme:
          ThemeData(primarySwatch: Colors.lightGreen, fontFamily: "Consolas"),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BrainF*cked Compiler'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
                        isDense: true, hintText: 'Write your code here...'),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.yellow),
                          onPressed: () {},
                          child: const Text('Save Code')),
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            String? result =
                                compiler.compile(controller.value.text);
                            setState(() {
                              output = result != null
                                  ? SelectableText(result)
                                  : const Text(
                                      'Error',
                                      style: TextStyle(color: Colors.red),
                                    );
                            });
                          },
                          child: const Text('Run')),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Output'),
                ),
                SizedBox(
                    height: 200,
                    child: Card(
                      child: ListView(
                        children: [
                          Padding(padding: EdgeInsets.all(8.0), child: output)
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
