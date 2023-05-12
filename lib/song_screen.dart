import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/player_buttons.dart';
import 'package:musicplayer/song.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/seekbar.dart';
import 'package:musicplayer/song_model.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  int index = 0;
  List<AudioSource> audioSources = [];
  List<Song> arrangedSongs = [];

  @override
  initState() {
    super.initState();
    Song song = Get.arguments ?? Song.songs[0];
    notifier = ValueNotifier(Get.arguments ?? Song.songs[0]);
    audioSources.add(
      AudioSource.uri(
        Uri.parse('asset:///${song.url}'),
      ),
    );
    arrangedSongs.add(song);
    for (Song s in Song.songs) {
      if (song != s) {
        audioSources.add(
          AudioSource.uri(
            Uri.parse('asset:///${s.url}'),
          ),
        );
        arrangedSongs.add(s);
      }

      audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: audioSources),
      );
    }
  }

  @override
  dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (
          Duration position,
          Duration? duration,
        ) {
          return SeekBarData(position, duration ?? Duration.zero);
        },
      );
  Widget backGround() {
    return Image.asset(
      song.coverUrl,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (BuildContext context, Song song, Widget? child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              backGround(),
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.0),
                      ],
                      stops: const [
                        0.0,
                        0.4,
                        0.65
                      ]).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepPurple.shade200,
                          Colors.deepPurple.shade600,
                        ]),
                  ),
                ),
              ),
              _MusicPlayer(
                seekBarDataStream: _seekBarDataStream,
                audioPlayer: audioPlayer,
                song: song,
                arrangedSongs: arrangedSongs,
              )
            ],
          );
        },
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer(
      {Key? key,
      required this.song,
      required Stream<SeekBarData> seekBarDataStream,
      required this.audioPlayer,
      required this.arrangedSongs})
      : _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final Song song;
  final List<Song> arrangedSongs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            song.description,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          StreamBuilder<SeekBarData>(
              stream: _seekBarDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangeEnd: audioPlayer.seek,
                );
              }),
          PlayerButtons(audioPlayer: audioPlayer, arrangedSongs: arrangedSongs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
                iconSize: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
