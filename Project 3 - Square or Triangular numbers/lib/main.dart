import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  _NonePageState createState() => _NonePageState();
}

class _NonePageState extends State<NonePage> {
  bool isSquare(int? number) {
    int i = 2;
    while (i * i <= number!) {
      if (i * i == number) {
        return true;
      }
      i++;
    }
    return false;
  }

  bool isTriangular(int? number) {
    int i = 2;
    while (i * i * i <= number!) {
      if (i * i * i == number) {
        return true;
      }
      i++;
    }
    return false;
  }

  // Controller for TextField.
  final TextEditingController controllerValueInput = TextEditingController();
  String? number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Number Shapes'),
      ),
      body: Column(children: <Widget>[
        Container(
          margin: const EdgeInsetsDirectional.all(25),
          child: const Text(
            'Please Input a number to see if it is square or a triangular.',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
            margin: const EdgeInsetsDirectional.all(25),
            child: TextField(
              controller: controllerValueInput,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  number = value;
                });
              },
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int? numberEntered = int.tryParse(controllerValueInput.text);
          if (numberEntered == null) {
            controllerValueInput.clear();
          } else {
            bool square = isSquare(numberEntered);
            bool triangular = isTriangular(numberEntered);
            String text = "";

            if (square && triangular) {
              text = "The number " +
                  numberEntered.toString() +
                  " is both SQUARE and TRIANGULAR!";
            } else if (square) {
              text = "The number " + numberEntered.toString() + " is SQUARE!";
            } else if (triangular) {
              text =
                  "The number " + numberEntered.toString() + " is TRIANGULAR!";
            } else {
              text = "The number " +
                  numberEntered.toString() +
                  " is neither square nor triangular.";
            }

            showDialog(
                context: context,
                builder: (BuildContext context) => SimpleDialog(
                      title: Text(
                        numberEntered.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsetsDirectional.all(10),
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ))
                      ],
                    ));

            FocusScope.of(context).requestFocus(FocusNode());
            controllerValueInput.clear();
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
