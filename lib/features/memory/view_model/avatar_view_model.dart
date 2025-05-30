import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/avatar_service.dart';

final avatarProvider = NotifierProvider<AvatarViewModel, String>(
  AvatarViewModel.new,
);

class AvatarViewModel extends Notifier<String> {
  @override
  String build() {
    return AvatarService.getAvatarPath();
  }

  Future<void> updateAvatar(String newPath) async {
    await AvatarService.setAvatarPath(newPath);
    state = newPath;
  }

  Future<void> resetAvatar() async {
    await AvatarService.clearAvatarPath();
    state = AvatarService.getAvatarPath();
  }
}
