import 'package:brain_fuck_compiler/about.dart';
import 'package:brain_fuck_compiler/compiler.dart';
import 'package:brain_fuck_compiler/help.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

// TODO: save code
// TODO: open code from file
// BUG:- disable autofocus on editor
// TODO: input proccessor
// TODO: infinite loop detector
// TODO: keyboard hits should work

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
  ItemScrollController keyboardScrollController = ItemScrollController();
  FocusNode focusNode = FocusNode(canRequestFocus: false);
  int lines = 1, characters = 0;
  List<String> output = [];
  String separate(String string) =>
      separateBytes ? string.characters.join(' ') : string;
  bool outputError = false;
  bool byteOutput = false;
  bool separateBytes = false;
  bool running = false;
  keyboardScrollTo(int index) {
    keyboardScrollController.scrollTo(
        index: index, duration: Duration(milliseconds: 500), alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              const Text(
                'untitled.bf',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          focusNode.requestFocus();
                        },
                        child: Card(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Column(
                                            children: List.generate(
                                          lines,
                                          (index) => Text(
                                            '${index + 1}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(height: 1.2),
                                          ),
                                        )),
                                      ),
                                      const VerticalDivider(),
                                      Expanded(
                                        child: TextField(
                                          scrollPhysics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: controller,
                                          keyboardType: TextInputType.multiline,
                                          onEditingComplete: () {},
                                          maxLines: null,
                                          focusNode: focusNode,
                                          minLines: null,
                                          autofocus: false,
                                          expands: true,
                                          onChanged: (value) {
                                            setState(() {
                                              lines = value.characters
                                                      .where((p0) => p0 == '\n')
                                                      .length +
                                                  1;
                                              characters =
                                                  value.characters.length;
                                            });
                                          },
                                          enableInteractiveSelection: true,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  height: 1.2,
                                                  letterSpacing: 1.5),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              hintText:
                                                  'Write your code here...'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Card(
                        child: ScrollablePositionedList.builder(
                            scrollDirection: Axis.horizontal,
                            itemScrollController: keyboardScrollController,
                            itemCount: 8,
                            itemBuilder: (context, index) => [
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(0);
                                      },
                                      child: const Text('+')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(1);
                                      },
                                      child: const Text('-')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(2);
                                      },
                                      child: const Text('>')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(3);
                                      },
                                      child: const Text('<')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(4);
                                      },
                                      child: const Text('.')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(5);
                                      },
                                      child: const Text(',')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(6);
                                      },
                                      child: const Text('[')),
                                  TextButton(
                                      onPressed: () {
                                        keyboardScrollTo(7);
                                      },
                                      child: const Text(']'))
                                ][index]),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Lines: $lines , Characters: $characters'),
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
                          autofocus: true,
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: running
                              ? null
                              : () {
                                  compiler
                                      .compile(controller.value.text)
                                      .then((value) {
                                    setState(() {
                                      running = false;
                                      output = value ?? [];
                                      outputError = value == null;
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
                    ButtonBar(
                      buttonPadding: const EdgeInsets.all(0),
                      children: [
                        PopupMenuButton(
                            // icon: Icon(Icons.list),
                            enableFeedback: false,
                            onSelected: (value) {
                              if (value == 'separate') {
                                setState(() {
                                  separateBytes = !separateBytes;
                                });
                              } else if (value == 'byte') {
                                setState(() {
                                  byteOutput = !byteOutput;
                                });
                              }
                            },
                            child: const Text(
                              'Options',
                              style: TextStyle(color: Colors.green),
                            ), //TextButton(child: const Text('Options'),onPressed: (){},),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 'separate',
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Separate bytes'),
                                          separateBytes
                                              ? const Icon(
                                                  Icons.check_box,
                                                  color: Colors.lightGreen,
                                                )
                                              : const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.lightGreen,
                                                )
                                        ],
                                      )),
                                  PopupMenuItem(
                                      value: 'byte',
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Show byte output'),
                                          byteOutput
                                              ? const Icon(
                                                  Icons.check_box,
                                                  color: Colors.lightGreen,
                                                )
                                              : const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.lightGreen,
                                                )
                                        ],
                                      ))
                                ]),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                output = [];
                              });
                            },
                            child: const Text(
                              'Clear',
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: OpenContainer(
                  transitionDuration: const Duration(milliseconds: 500),
                  closedBuilder: (context, action) => ListView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: outputError
                              ? const SelectableText(
                                  'Syntax Error',
                                  style: TextStyle(color: Colors.red),
                                )
                              : Text(
                                  byteOutput
                                      ? output
                                          .join()
                                          .codeUnits
                                          .join(separateBytes ? ' ' : '')
                                      : output.join(separateBytes ? ' ' : ''),
                                  // onTap: null,
                                  // enableInteractiveSelection: false,
                                )),
                    ],
                  ),
                  openBuilder: (context, action) => Scaffold(
                    body: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: outputError
                                ? const SelectableText(
                                    'Syntax Error',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Text(
                                    byteOutput
                                        ? output
                                            .join()
                                            .codeUnits
                                            .join(separateBytes ? ' ' : '')
                                        : output.join(separateBytes ? ' ' : ''),
                                    // onTap: null,
                                    // enableInteractiveSelection: false,
                                  )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
