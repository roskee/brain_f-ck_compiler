import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Card(
              child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Message from the developer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hello, There! I created this app for bored programmers to challenge thier minds with the famious \'Brain F*ck\' programming language.\nTry creating awesome patterns - I assure you it won\'t be eazy :)',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          )),
          Card(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('How to find me',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Email: brainF*ck@gmail.com'),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Support Me',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Star this project'),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.exit_to_app))
                      ],
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
