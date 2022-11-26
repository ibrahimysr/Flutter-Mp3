import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:mp3/service/musicler.dart';

class MusicPlayer extends StatefulWidget {
  late final musicler music;

  MusicPlayer(this.music);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final auidoPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String FormatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }

  @override
  void initState() {
    super.initState();

    setAudio();

    auidoPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == AudioPlayerState.PLAYING;
      });
    });

    auidoPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    auidoPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    auidoPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: "assets/");
    final url = await player.load("${widget.music.music_ad}.mp3");
    auidoPlayer.setUrl(url.path, isLocal: true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Müzik Listem",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/${widget.music.music_resim}'),
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.music.music_ad,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.music.music_sanatci,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Icon(Icons.favorite_border)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await auidoPlayer.seek(position);

                          //pause
                          await auidoPlayer.resume();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(FormatTime(position)),
                          Text(FormatTime(duration - position))
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.orange, shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.skip_previous,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (isPlaying) {
                            await auidoPlayer.pause();
                          } else {
                            await auidoPlayer.resume();
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: isPlaying
                                ? const Icon(
                                    Icons.pause,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.skip_next,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
