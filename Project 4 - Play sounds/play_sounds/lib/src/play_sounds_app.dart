import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NonePage(),
    );
  }
}

class NonePage extends StatefulWidget {
  const NonePage({Key? key}) : super(key: key);

  @override
  NonePageState createState() => NonePageState();
}

class NonePageState extends State<NonePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
