import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/song_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);
  final Song song;

//   @override
//   State<SongCard> createState() => _SongCardState();
// }

// class _SongCardState extends State<SongCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/song", arguments: song);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    opacity: 0.9,
                    image: AssetImage(song.coverUrl),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        song.title.length > 12
                            ? Text(
                                song.title.substring(0, 12),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            : Text(
                                song.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                        song.description.length > 15
                            ? Text(
                                song.description.substring(0, 15),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            : Text(
                                song.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                      ],
                    ),
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.deepPurple.withOpacity(0.7),
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
