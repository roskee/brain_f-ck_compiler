import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'The Idea behind the language',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Brainfuck is an esoteric programming language created in 1993 by Urban Müller. Notable for its extreme minimalism, the language consists of only eight simple commands, a data pointer and an instruction pointer. While it is fully Turing complete, it is not intended for practical use, but to challenge and amuse programmers. Brainfuck simply requires one to break commands into microscopic steps.',
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Wikipedia',
                              style: TextStyle(fontStyle: FontStyle.italic)))),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'It has one 30,000 bytes long one-dimentional array for you \'the programmer\' to manipulate. You can only do one of the following.\n1. Move around the array\n2. Increment or decrement the value at the current index of the array.\n3. Print the value at the current index of the array.\n4. Request input that will be inserted at the current index of the array.\n5. Loop any part of your code.\nThat is it! Look at the following table for symbols for the above operations!',
                        textAlign: TextAlign.justify),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Me ;)',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Available Symbols',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      columnWidths: const {0: FixedColumnWidth(40)},
                      border: TableBorder.all(color: Colors.grey),
                      children: const [
                        TableRow(children: [
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('>',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          )),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To move the pointer one index to the right'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('<',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To move the pointer one index to the left'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('+',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To increment the value at the current index by one'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('-',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To decrement the value at the current index by one'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Text('To print the value at the current index'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(',',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To request input and update the value at the current index'),
                          )
                        ]),
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('[]',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'To execute the commands in the bracket in a loop until the value at the current index is 0'),
                          )
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
