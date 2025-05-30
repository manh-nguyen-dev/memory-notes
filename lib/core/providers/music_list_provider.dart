import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/music_track_model.dart';

final musicListProvider = StateProvider<List<MusicTrack>>(
  (ref) => [
    MusicTrack(
      title: 'Young Love',
      artist: 'Phillip Vo & Maxwell Griffin',
      path: 'assets/audio/young_love.mp3',
    ),
    MusicTrack(
      title: 'All In',
      artist: 'The Wildcardz',
      path: 'assets/audio/all_in.mp3',
    ),
  ],
);
