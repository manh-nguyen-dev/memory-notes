import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'premium_viewmodel.g.dart';

@riverpod
class PremiumViewModel extends _$PremiumViewModel {
  @override
  void build() {}

  List<Map<String, String>> get premiumBenefits => [
    {'icon': '🚫', 'text': 'Không quảng cáo, trải nghiệm liền mạch'},
    {'icon': '🔓', 'text': 'Mở khoá toàn bộ tính năng của ứng dụng'},
    {
      'icon': '🎨',
      'text': 'Thay đổi avatar không giới hạn\n(Hiện tại: chỉ 1 lần/tuần)',
    },
    {
      'icon': '💡',
      'text': 'Góp ý và đề xuất tính năng mới\n(Có thể áp dụng riêng cho bạn)',
    },
  ];

  void handlePurchasePremium() {}
}
