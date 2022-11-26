import 'package:flutter/material.dart';
import 'package:mp3/view/Favori.dart';
import 'package:mp3/view/List.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int secilisayfa = 0;

  void sayfadegistir(int index) {
    setState(() {
      secilisayfa = index;
    });
  }

  sayfagoster(int secilisayfa) {
    if (secilisayfa == 0) {
      return MusicList();
    } else if (secilisayfa == 1) {
      return Favoriler();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.orange.shade50,
        unselectedItemColor: Colors.orange.shade50,
        iconSize: 25,
        selectedLabelStyle: TextStyle(fontSize: 16),
        unselectedLabelStyle: TextStyle(fontSize: 16),
      currentIndex: secilisayfa,
      onTap: sayfadegistir,

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow,color: Colors.orange.shade50,), label: "Çalma Listesi"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.orange.shade50,), label: "Favoriler")
        ]),
    body: sayfagoster(secilisayfa),);
  }
}
