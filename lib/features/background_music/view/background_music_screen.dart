import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/audio_player_provider.dart';
import '../../../core/providers/music_list_provider.dart';

class BackgroundMusicScreen extends ConsumerWidget {
  const BackgroundMusicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicList = ref.watch(musicListProvider);
    final audioPlayer = ref.watch(audioPlayerProvider);
    final currentTrack = ref.watch(currentTrackProvider);
    final isEnabled = ref.watch(isBackgroundMusicEnabledProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nhạc nền')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Cài đặt chung',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Phát nhạc nền',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    ref.read(isBackgroundMusicEnabledProvider.notifier).state =
                        value;

                    if (!value) {
                      audioPlayer.stop();
                      ref.read(currentTrackProvider.notifier).state = null;
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Chọn nhạc nền',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                itemCount: musicList.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final track = musicList[index];
                  final isPlaying = currentTrack == track.path;

                  return ListTile(
                    leading: Icon(
                      isPlaying ? Icons.music_note : Icons.music_video,
                      color: isPlaying ? Colors.pinkAccent : Colors.grey,
                    ),
                    title: Text(track.title),
                    subtitle: Text(track.artist),
                    trailing: isPlaying
                        ? const Icon(Icons.play_arrow, color: Colors.pinkAccent)
                        : null,
                    onTap: () async {
                      if (!ref.read(isBackgroundMusicEnabledProvider)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bạn đã tắt nhạc nền.')),
                        );
                        return;
                      }

                      try {
                        await audioPlayer.setAsset(track.path);
                        await audioPlayer.play();
                        ref.read(currentTrackProvider.notifier).state =
                            track.path;
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Không thể phát nhạc: ${track.title}',
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
