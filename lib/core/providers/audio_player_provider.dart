import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
});

final currentTrackProvider = StateProvider<String?>((ref) => null);

final isBackgroundMusicEnabledProvider = StateProvider<bool>((ref) => true);
