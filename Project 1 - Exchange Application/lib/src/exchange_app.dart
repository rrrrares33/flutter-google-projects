import 'package:flutter/material.dart';

class ExchangeApp extends StatelessWidget {
  const ExchangeApp({Key? key}) : super(key: key);

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
  // Controller for TextField.
  final TextEditingController controllerValueInput = TextEditingController();
  final double exchangeRateEuroToRon = 4.94; // as of 07.11.2021
  // Text error if it meant to be displayed
  String? errorText;
  // The value (as double) extracted from the input.
  double? doubleValue;
  // The result of conversion. If there is no result, no conversion has been made.
  String convertedValue = "";
  // The dropdown option selected. By default, it is 0 (EUR to RON).
  int dropDownOptionSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The blue bar at the top of the screen.
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Currency convertor",
        ),
      ),
      // The rest of the screen.
      body: Column(
        children: <Widget>[
          // The image with euros in it.
          Image.asset('assets/euro_image.png', height: 200),
          // Text field for input.
          Container(
            margin: const EdgeInsetsDirectional.all(16.4),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: controllerValueInput,
              decoration: InputDecoration(
                hintText: 'Enter the amount to convert.',
                labelText: 'Amount to convert.',
                errorText: errorText,
                suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // When you press on "X", the keyboard will be hidden.
                      controllerValueInput.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        convertedValue = "";
                        errorText = null;
                      });
                    }),
              ),
              onChanged: (String value) {
                final double? auxDoubleValue = double.tryParse(value);
                // I try to parse the input.
                // If it succeeds, I save it.
                // If not, I print error message.
                if (auxDoubleValue == null) {
                  setState(() {
                    errorText = 'Please enter a correct value.';
                  });
                } else {
                  setState(() {
                    doubleValue = auxDoubleValue;
                    errorText = null;
                  });
                }
              },
            ),
          ),
          DropdownButton<int>(
            // I use a dropdown list in order to select which type of conversion
            // the user wants to use. (RON -> EUR, EUR -> RON)
            items: const <DropdownMenuItem<int>>[
              DropdownMenuItem<int>(
                value: 0,
                child: Text("EUR to RON"),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: Text("RON to EUR"),
              ),
            ],
            value: dropDownOptionSelected,
            onChanged: (int? value) {
              setState(() {
                dropDownOptionSelected = value!;
              });
            },
          ),
          ElevatedButton(
              // When this button is pressed, it takes the value from doubleValue
              // (if there is no error)
              // And converts it according to the Dropdown selection.
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  if (controllerValueInput.text.isEmpty || errorText != null) {
                    convertedValue = "";
                    errorText = "Please enter a valid number.";
                  } else {
                    if (dropDownOptionSelected == 0) {
                      convertedValue = (doubleValue! * exchangeRateEuroToRon)
                          .toStringAsFixed(2);
                    } else {
                      convertedValue = (doubleValue! / exchangeRateEuroToRon)
                          .toStringAsFixed(2);
                    }
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                padding: MaterialStateProperty.all(
                    const EdgeInsetsDirectional.all(15)),
              ),
              child: const Text(
                "CONVERT !",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16.0,
                ),
              )),
          Container(
            // The widget which displays the result of the conversion.
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
