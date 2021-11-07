import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

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

// variable: [type][name][=][value]
// function: [return type][name][parameters]
class _NonePageState extends State<NonePage> {
  final TextEditingController controllerValueInput = TextEditingController();
  final double exchangeRateEuroToRon = 4.94; // as of 07.11.2021
  String? errorText;
  double? doubleValue;
  String convertedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Currency convertor",
        ),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
              'assets/euro_image.png',
              height: 225
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(25.0),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: controllerValueInput,
              decoration: InputDecoration(
                hintText: 'Enter the amount in EUR.',
                labelText: 'Amount to convert to RON.',
                errorText: errorText,
                suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controllerValueInput.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        errorText = null;
                      });
                    }
                ),
              ),
              onChanged: (String value) {
                final double? auxDoubleValue = double.tryParse(value);
                if (auxDoubleValue == null) {
                  setState(() {
                    errorText = 'Please enter a correct value.';
                  });
                }
                else {
                  setState(() {
                    doubleValue = auxDoubleValue;
                    errorText = null;
                  });
                }
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  if (errorText == null) {
                    convertedValue = (doubleValue! * exchangeRateEuroToRon).toStringAsFixed(2);
                  } else {
                    convertedValue = "";
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                padding: MaterialStateProperty.all(const EdgeInsetsDirectional.all(15)),
              ),
              child: const Text(
                  "CONVERT !",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16.0,
                  ),
              )
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(5),
            child: Text(
                convertedValue,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                ),
            ),
          )
        ],
      ),
    );
  }
}
