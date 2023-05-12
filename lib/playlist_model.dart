import 'package:musicplayer/song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String coverUrl;

  Playlist({required this.title, required this.songs, required this.coverUrl});

  static List<Playlist> playlists = [
    Playlist(
        title: "Vibe",
        songs: Song.songs,
        coverUrl: 'assets/images/playlistcover1.jpg'),
    Playlist(
        title: "Mood",
        songs: Song.songs,
        coverUrl: 'assets/images/playlistcover2.jpg'),
    Playlist(
        title: "Party",
        songs: Song.songs,
        coverUrl: 'assets/images/playlistcover3.jpg'),
  ];
}
