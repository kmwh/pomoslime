import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class WhiteNoiseProvider with ChangeNotifier {
  final UserDataModel _userData;

  late AudioPlayer whiteNoisePlayer;

  int get whiteNoiseIndex => _userData.whiteNoiseIndex;

  WhiteNoiseProvider(this._userData) {
    whiteNoisePlayer = AudioPlayer();
    whiteNoisePlayer.setReleaseMode(ReleaseMode.loop);
  }

  void setWhiteNoise(int index) {
    _userData.whiteNoiseIndex = index;
    _userData.save();

    notifyListeners();
  }

  void playWhiteNoise() async {
    if (whiteNoiseIndex != 0) {
      await whiteNoisePlayer
          .play(AssetSource("sounds/white_noise/sound_$whiteNoiseIndex.mp3"));
    }
  }

  void pauseWhiteNoise() async {
    if (whiteNoiseIndex != 0) {
      await whiteNoisePlayer.pause();
    }
  }
}
