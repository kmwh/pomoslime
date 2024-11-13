import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class NotificationProvider with ChangeNotifier {
  final UserDataModel _userData;

  late AudioPlayer notificationPlayer;

  NotificationProvider(this._userData) {
    notificationPlayer = AudioPlayer();
  }

  int get notificationIndex => _userData.notificationIndex;

  void setNotification(int index) {
    _userData.notificationIndex = index;
    _userData.save();

    notifyListeners();

    if (notificationIndex != 0) {
      playNotification(index);
    }
  }

  void playNotification(int index) async {
    await notificationPlayer.setVolume(1);
    await notificationPlayer
        .play(AssetSource("sounds/notification/sound_$index.mp3"));
  }
}
