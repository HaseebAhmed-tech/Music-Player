import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/song.dart';
import 'package:musicplayer/song_model.dart';

class PlayerButtons extends StatefulWidget {
  const PlayerButtons(
      {Key? key, required this.audioPlayer, required this.arrangedSongs})
      : super(key: key);

  final AudioPlayer audioPlayer;
  final List<Song> arrangedSongs;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: () {
                widget.audioPlayer.hasPrevious
                    ? widget.audioPlayer.seekToPrevious()
                    : null;
                if (widget.audioPlayer.currentIndex! - 1 >= 0) {
                  song = widget
                      .arrangedSongs[widget.audioPlayer.currentIndex! - 1];
                  notifier.value = widget
                      .arrangedSongs[widget.audioPlayer.currentIndex! - 1];

                  // Get.offAndToNamed("/song");
                }
              },
              iconSize: 45,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: widget.audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = (playerState!).processingState;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64,
                  height: 64,
                  margin: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 75,
                  ),
                );
              } else if (!widget.audioPlayer.playing) {
                return IconButton(
                  onPressed: widget.audioPlayer.play,
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: widget.audioPlayer.pause,
                  icon: const Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else {
                return IconButton(
                  onPressed: () => widget.audioPlayer.seek(Duration.zero,
                      index: widget.audioPlayer.effectiveIndices!.first),
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: () {
                widget.audioPlayer.hasNext
                    ? widget.audioPlayer.seekToNext()
                    : null;
                if (widget.audioPlayer.currentIndex! + 1 <
                    widget.arrangedSongs.length) {
                  song = widget
                      .arrangedSongs[widget.audioPlayer.currentIndex! + 1];
                  notifier.value = widget
                      .arrangedSongs[widget.audioPlayer.currentIndex! + 1];
                }
              },
              iconSize: 45,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}
