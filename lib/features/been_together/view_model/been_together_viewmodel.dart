import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/hive_service.dart';
import '../../../data/models/love_info_model.dart';

part 'been_together_viewmodel.g.dart';

@riverpod
class BeenTogetherViewModel extends _$BeenTogetherViewModel {
  @override
  Stream<LoveInfo?> build() async* {
    yield HiveService.loveBox.get('info');

    yield* HiveService.loveBox
        .watch(key: 'info')
        .map((event) => HiveService.loveBox.get('info'));
  }

  Future<void> updateLoveInfo(LoveInfo newInfo) async {
    final current = HiveService.loveBox.get('info');
    if (current != null) {
      await HiveService.loveBox.put('info', newInfo);
    }
  }

  Future<void> updateTitle(String newTitle) async {
    final current = HiveService.loveBox.get('info');
    if (current != null) {
      await HiveService.loveBox.put('info', current.copyWith(title: newTitle));
    }
  }

  Future<void> updateSubtitle(String newSubtitle) async {
    final current = HiveService.loveBox.get('info');
    if (current != null) {
      await HiveService.loveBox.put(
        'info',
        current.copyWith(subtitle: newSubtitle),
      );
    }
  }

  Future<void> updateStartDate(DateTime newStartDate) async {
    final current = HiveService.loveBox.get('info');
    if (current != null) {
      await HiveService.loveBox.put(
        'info',
        current.copyWith(startDate: newStartDate),
      );
    }
  }
}
