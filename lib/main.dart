import 'package:brain_fuck_compiler/about.dart';
import 'package:brain_fuck_compiler/compiler.dart';
import 'package:brain_fuck_compiler/help.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BrainFucked());
}

class BrainFucked extends StatelessWidget {
  const BrainFucked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'BrainF*cked',
        theme:
            ThemeData(primarySwatch: Colors.lightGreen, fontFamily: "Consolas"),
        home: const BrainFuckedApp(),
      );
}

class BrainFuckedApp extends StatefulWidget {
  const BrainFuckedApp({Key? key}) : super(key: key);

  @override
  State<BrainFuckedApp> createState() => _BrainFuckedAppState();
}

class _BrainFuckedAppState extends State<BrainFuckedApp> {
  Compiler compiler = Compiler();
  TextEditingController controller = TextEditingController();
  int lines = 1, characters = 0;
  Widget output = const SelectableText('');
  bool running = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BrainF*cked Compiler'),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                if (value == 'about') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                } else if (value == 'help') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HelpPage()));
                }
              },
              itemBuilder: (context) => const [
                    PopupMenuItem(
                      child: Text('About App'),
                      value: 'about',
                    ),
                    PopupMenuItem(child: Text('Help'), value: 'help')
                  ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Text('untitled.bf'),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      onEditingComplete: () {},
                      onChanged: (value) {
                        setState(() {
                          lines = value.characters
                                  .where((p0) => p0 == '\n')
                                  .length +
                              1;
                          characters = value.characters.length;
                        });
                      },
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                          counter:
                              Text('Lines: $lines , Characters: $characters'),
                          isDense: true,
                          hintText: 'Write your code here...'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 5,
                  child: running ? const LinearProgressIndicator() : null),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: SizedBox(
                  height: 50,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: const EdgeInsets.all(0),
                    children: [
                      ButtonBar(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow),
                              onPressed: () {},
                              child: const Text('Save Code')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              onPressed: () {},
                              child: const Text('Open'))
                        ],
                      ),
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            compiler
                                .compile(controller.value.text)
                                .then((value) {
                              setState(() {
                                running = false;
                                output = value != null
                                    ? SelectableText(value)
                                    : const Text(
                                        'Syntax Error',
                                        style: TextStyle(color: Colors.red),
                                      );
                              });
                            });
                            setState(() {
                              running = true;
                            });
                          },
                          child: const Text('Run')),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Output'),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            output = const SelectableText('');
                          });
                        },
                        child: const Text('Clear'))
                  ],
                ),
              ),
              SizedBox(
                  height: 150,
                  child: Card(
                    child: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0), child: output)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
