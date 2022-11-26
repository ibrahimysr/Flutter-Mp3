
import 'package:flutter/material.dart';
import 'package:mp3/view/Homepage.dart';
import 'package:mp3/view/MusicPlayer.dart';
import 'package:mp3/view/List.dart';




void main() async {
 
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mp3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.orange,
        ),
        home: const Homepage()
    );
  }
}
