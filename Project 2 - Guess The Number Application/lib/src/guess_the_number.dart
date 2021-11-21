import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
  // Controller for TextField.
  final TextEditingController controllerValueInput = TextEditingController();

  // The text that appears on the button.
  // First time it will be "Guess", later it may change to "Try again".
  String buttonText = 'Guess';

  // The number which needs to be guessed by the user. (random between 1 and 100)
  int? numberToBeGuessed = Random().nextInt(99) + 1;

  // The input received from the user.
  int? numberAttempted;

  // The error message in case the user does not insert a correct number in the
  // text field.
  String? inputErrorMessage;

  // The text which remembers the user his last guess and if the number is
  // bigger or smaller.
  String usersLastGuess = '';

  // The text field is empty (no error but still unable to press anything)
  bool textFieldIsEmpty = true;

  // Number of guesses made before winning.
  int numberOfGuesses = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The blue bar at the top of the screen.
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Guess my number'),
      ),
      // Everything that is under the blue bar.
      body: Column(
        children: <Widget>[
          // Simple text widget.
          Container(
            margin: const EdgeInsetsDirectional.all(12),
            transformAlignment: AlignmentDirectional.center,
            child: const Text(
              "I'm thinking of a number between\n1 and 100. ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
              ),
            ),
          ),
          // Simple text widget.
          Container(
              margin: const EdgeInsetsDirectional.all(5),
              child: const Text(
                "It's your turn to guess my number!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
          // This container is displayed only when there is
          // at least one guess from the player.
          // In order to check that, it does
          // child: usersLastGuess != "" ? Text()
          Container(
            margin: const EdgeInsetsDirectional.all(5),
            // This way, the padding between the above and bellow children
            // Will not be displayed until the text is displayed.
            child: usersLastGuess != ''
                ? Text(
                    usersLastGuess,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: Colors.blueGrey),
                  )
                : Container(),
          ),
          // This is the main portion of the program, which looks like a card
          // In front of the screen.
          Card(
            margin: const EdgeInsetsDirectional.all(15),
            elevation: 7.5,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsetsDirectional.all(5),
                  transformAlignment: AlignmentDirectional.center,
                  child: const Text(
                    ' Try a number! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // It tells us how many guesses we have already made.
                // Also, the next is changeable, depending on whether the
                // nrOfGuesses is smaller then 1 or bigger then 1.
                Container(
                  margin: const EdgeInsetsDirectional.all(5),
                  transformAlignment: AlignmentDirectional.center,
                  child: Text(
                    (numberOfGuesses == 1)
                        ? '--- $numberOfGuesses guess made---'
                        : '--- $numberOfGuesses guesses made---',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
                // This is the input for the guess.
                // The filed can not be used if the text of the
                //                button underneath it is "Reset"
                // The hintText only appears when the button is "Guess"
                // It prompts error if the number is not in [1,99] interval
                //                or it is not convertible to an int.
                Container(
                    margin: const EdgeInsetsDirectional.all(20),
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: controllerValueInput,
                      readOnly: buttonText == 'Reset',
                      decoration: InputDecoration(
                        hintText: (buttonText == 'Guess') ? 'Enter your guess here...' : '',
                        errorText: inputErrorMessage,
                      ),
                      onChanged: (String? value) {
                        if (controllerValueInput.text == '') {
                          inputErrorMessage = null;
                          textFieldIsEmpty = true;
                        } else {
                          final int? inputInField = int.tryParse(controllerValueInput.text);
                          setState(() {
                            if (inputInField != null) {
                              if (inputInField >= 100) {
                                inputErrorMessage = 'The guess must be smaller then 100.';
                              } else if (inputInField <= 0) {
                                inputErrorMessage = 'The guess must be bigger then 0.';
                              } else {
                                textFieldIsEmpty = false;
                                numberAttempted = inputInField;
                                inputErrorMessage = null;
                              }
                            } else {
                              inputErrorMessage = 'Input is not convertible to int.';
                            }
                          });
                        }
                      },
                    )),
                // When pressed, if the number in the text field is valid
                //    it checks how it compares with numberToBeGuessed.
                // If the guess is right, it generates an AlertDialog.
                // If not, it gives the player another turn,
                //    incrementing the nrOfAttempts
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
                    ),
                    onPressed: () {
                      if (buttonText != 'Reset') {
                        setState(() {
                          if (textFieldIsEmpty || inputErrorMessage != null) {
                          } else {
                            if (numberAttempted! < numberToBeGuessed!) {
                              usersLastGuess = 'You tried $numberAttempted ! \n Try higher!';
                              numberOfGuesses++;
                            } else if (numberAttempted! > numberToBeGuessed!) {
                              usersLastGuess = 'You tried $numberAttempted ! \n Try smaller!';
                              numberOfGuesses++;
                            } else {
                              numberOfGuesses++;
                              // numberToBeGuessed gets changed before it is displayed so
                              // I decided to save it into a new variable, in order to display it.
                              final int? auxOfGuessedNumber = numberToBeGuessed;
                              final int auxOfNumberOfGuesses = numberOfGuesses;
                              showDialog<int>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                        title: const Text(
                                          '!! Congratulations !!',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                        content: Text(
                                          'You picked the correct number: ${auxOfGuessedNumber!}\nIt took you exactly $auxOfNumberOfGuesses attempts.\nDo you want to play again?',
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context, 'Cancel');
                                                // Here I change the button text to 'Reset'
                                                // If the player wants to continue, he needs
                                                // to press on it before playing again.
                                                buttonText = 'Reset';
                                              });
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context, 'Reset');
                                              });
                                            },
                                            child: const Text(
                                              'Reset',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ));
                              usersLastGuess = '';
                              numberToBeGuessed = Random().nextInt(99) + 1;
                              numberAttempted = null;
                              numberOfGuesses = 0;
                            }
                            controllerValueInput.clear();
                            textFieldIsEmpty = true;
                          }
                        });
                      } else {
                        setState(() {
                          numberOfGuesses = 0;
                          usersLastGuess = '';
                          numberToBeGuessed = Random().nextInt(99) + 1;
                          buttonText = 'Guess';
                          numberAttempted = null;
                          controllerValueInput.clear();
                          textFieldIsEmpty = true;
                        });
                      }
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
