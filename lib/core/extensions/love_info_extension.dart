import '../../data/models/love_info_model.dart';

extension LoveInfoExtension on LoveInfo {
  int get daysTogether {
    final now = DateTime.now();
    final nowOnly = DateTime(now.year, now.month, now.day);
    final startOnly = DateTime(startDate.year, startDate.month, startDate.day);
    return nowOnly.difference(startOnly).inDays + 1;
  }
}
