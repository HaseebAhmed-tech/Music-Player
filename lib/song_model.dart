class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song(
      {required this.title,
      required this.description,
      required this.url,
      required this.coverUrl});

  static List<Song> songs = [
    Song(
        title: "DropTop",
        description: "AP Dhillon||Gurinder||Gill Gminxr",
        url: 'assets/music/droptop.mp3',
        coverUrl: 'assets/images/droptop.jpg'),
    Song(
        title: "Fuck'em All",
        description: "Sidhu Moosewala",
        url: 'assets/music/fuckemall.mp3',
        coverUrl: 'assets/images/fuckemall.jpg'),
    Song(
        title: "Biba",
        description: "Toshi||Farasat Anees",
        url: 'assets/music/biba.mp3',
        coverUrl: 'assets/images/biba.jpeg'),
  ];
}
