import 'package:flutter/material.dart';
import 'package:mp3/service/musicler.dart';
import 'package:mp3/service/musiclerdao.dart';
import 'package:mp3/view/MusicPlayer.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  bool AramaYapiliyormu = false;
  String Aranankelime = "";
  Future<List<musicler>> MusicleriGoster() async {
    var Musiclist = await musiclerdao().Tumkategoriler();

    return Musiclist;
  }

  Future<List<musicler>> MusicAra(String ArananKelime) async {
    var Musiclist = await musiclerdao().Musicara(ArananKelime);
    return Musiclist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: AramaYapiliyormu
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "Aramak için bir şey yazınız",
                ),
                onChanged: (aramaSonucu) {
                  print("aramasonucu:$aramaSonucu");

                  Aranankelime = aramaSonucu;
                },
              )
            : const Text(
                "Müzik Listesi",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          AramaYapiliyormu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      AramaYapiliyormu = false;
                      Aranankelime = "";
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      AramaYapiliyormu = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      backgroundColor: Colors.orange.shade50,
      body: FutureBuilder<List<musicler>>(
        future: AramaYapiliyormu ? MusicAra(Aranankelime) : MusicleriGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var Musiclist = snapshot.data;
            return ListView.builder(
              itemCount: Musiclist!.length,
              itemBuilder: (context, indeks) {
                var music = Musiclist[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MusicPlayer(music)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.orange,
                              backgroundImage:
                                  AssetImage("assets/${music.music_resim}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35, right: 35, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${music.music_ad} ",
                                    style: const  TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Text(
                                      music.music_sanatci,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
