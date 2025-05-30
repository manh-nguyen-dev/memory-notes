import 'package:hive/hive.dart';

part 'love_info_model.g.dart';

@HiveType(typeId: 0)
class LoveInfo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String subtitle;

  @HiveField(2)
  DateTime startDate;

  LoveInfo({
    required this.title,
    required this.subtitle,
    required this.startDate,
  });

  LoveInfo copyWith({
    String? title,
    String? subtitle,
    DateTime? startDate,
  }) {
    return LoveInfo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      startDate: startDate ?? this.startDate,
    );
  }
}
