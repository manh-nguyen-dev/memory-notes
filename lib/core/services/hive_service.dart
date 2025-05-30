import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_notes/core/constants/constants.dart';

import '../../data/models/love_info_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(LoveInfoAdapter());

    await Hive.openBox<LoveInfo>(AppConstants.loveBox);
    await Hive.openBox<String>(AppConstants.avatarBox);

    final loveBox = Hive.box<LoveInfo>(AppConstants.loveBox);
    if (loveBox.get('info') == null) {
      loveBox.put(
        'info',
        LoveInfo(
          title: 'Our Love',
          subtitle: 'Đã quen nhau',
          startDate: DateTime(2025, 02, 22),
        ),
      );
    }

    final avatarBox = Hive.box<String>(AppConstants.avatarBox);
    if (!avatarBox.containsKey('path')) {
      avatarBox.put('path', 'assets/images/default_avatar_1.png');
    }
  }

  static Box<LoveInfo> get loveBox => Hive.box<LoveInfo>(AppConstants.loveBox);
  static Box<String> get avatarBox => Hive.box<String>(AppConstants.avatarBox);
}
