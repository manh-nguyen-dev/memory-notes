import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_notes/core/constants/constants.dart';

class AvatarService {
  static final Box<String> _avatarBox = Hive.box<String>(
    AppConstants.avatarBox,
  );

  static String getAvatarPath() {
    return _avatarBox.get('path', defaultValue: '') ?? '';
  }

  static Future<void> setAvatarPath(String path) async {
    await _avatarBox.put('path', path);
  }

  static Future<void> clearAvatarPath() async {
    await _avatarBox.put('path', 'assets/images/default_avatar_1.png');
  }

  static bool hasAvatar() {
    final path = _avatarBox.get('path');
    return path != null && path.isNotEmpty;
  }
}
