import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/faq_tips_data.dart';

final faqTipsViewModelProvider = Provider<FaqTipsViewModel>((ref) {
  return FaqTipsViewModel();
});

class FaqTipsViewModel {
  List<Map<String, String>> getFaqItems() {
    return faqItems;
  }
}
