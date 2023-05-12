import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:musicplayer/song_model.dart';

Song song = Get.arguments ?? Song.songs[0];

ValueNotifier<Song> notifier = ValueNotifier(Get.arguments ?? Song.songs[0]);
