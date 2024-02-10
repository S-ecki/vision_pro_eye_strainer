import 'package:audioplayers/audioplayers.dart';

class ChickenSoundShort {
  ChickenSoundShort() : player = AudioPlayer() {
    player.setPlayerMode(PlayerMode.lowLatency);
  }
  final AudioPlayer player;

  void play() {
    player.play(AssetSource('sound-short.mp3'));
  }
}

class ChickenSoundLong {
  factory ChickenSoundLong() => _instance;
  ChickenSoundLong._() : player = AudioPlayer() {
    player.setReleaseMode(ReleaseMode.loop);
  }
  static final _instance = ChickenSoundLong._();

  final AudioPlayer player;

  void play() {
    player
      ..stop()
      ..play(AssetSource('sound-long.mp3'), volume: 0.05);
  }
}
