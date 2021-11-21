import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
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
  List<String> audioNames = <String>[
    'Cand_vii',
    'Cand_vii(Japan)',
    'Ce_mai_faci',
    'Ce_mai_faci(Japan)',
    'Ma_numesc',
    'Ma_numesc(Japan)',
    'Salut',
    'Salut(Japan)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: const Text('Basic Phrases'),
        ),
        body: GridView.builder(
            padding: const EdgeInsetsDirectional.all(7),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                  child: InkWell(
                      onTap: () {
                        final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
                        final String path = 'assets/sounds/${audioNames[index]}.mp3';
                        audioPlayer.open(Audio(path));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: const Alignment(0.7, 0.0),
                                colors: <Color>[Colors.blue.shade50, Colors.blue.shade600]),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.blueAccent,
                          ),
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsetsDirectional.all(15),
                          margin: const EdgeInsetsDirectional.all(7),
                          child: Text(
                            audioNames[index].replaceAll('_', ' '),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                          ))));
            }));
  }
}
