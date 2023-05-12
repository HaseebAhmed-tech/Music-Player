import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/home_screen.dart';
import 'package:musicplayer/playlist_Screen.dart';
import 'package:musicplayer/song_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/song", page: () => const SongScreen()),
        GetPage(name: "/playlist", page: () => const PlaylistScreen()),
      ],
    );
  }
}
