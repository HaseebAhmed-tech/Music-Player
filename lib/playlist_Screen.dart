// ignore_for_file: dead_code, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musicplayer/playlist_model.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Playlist> playlists = Playlist.playlists;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Playlist",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const _PlaylistInfo(),
                const _PlayorShuffleSwitch(),
                const SizedBox(
                  height: 30,
                ),
                PlaylistSongs(playlists: playlists),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlists[0].songs.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            title: Text(
              playlists[0].songs[index].title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              playlists[0].songs[index].description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ));
      },
    );
  }
}

class _PlayorShuffleSwitch extends StatefulWidget {
  const _PlayorShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<_PlayorShuffleSwitch> createState() => _PlayorShuffleSwitchState();
}

class _PlayorShuffleSwitchState extends State<_PlayorShuffleSwitch> {
  ValueNotifier<bool> _isPlay = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        _isPlay.value = !_isPlay.value;
      },
      child: ValueListenableBuilder(
        valueListenable: _isPlay,
        builder: (context, bool isPlay, child) {
          return Container(
            height: 50,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: isPlay ? 0 : width * 0.4462,
                  child: Container(
                    height: 50,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Play",
                              style: TextStyle(
                                  color: isPlay ? Colors.white : Colors.pink,
                                  fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.play_circle,
                              color: isPlay ? Colors.white : Colors.pink)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Shuffle",
                              style: TextStyle(
                                  color: isPlay ? Colors.pink : Colors.white,
                                  fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.shuffle,
                            color: isPlay ? Colors.pink : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlaylistInfo extends StatelessWidget {
  const _PlaylistInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            "assets/images/playlistcover1.jpg",
            width: MediaQuery.of(context).size.height * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          Playlist.playlists[0].title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
