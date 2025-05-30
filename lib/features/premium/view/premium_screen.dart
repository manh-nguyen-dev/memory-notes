import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../view_model/premium_viewmodel.dart';

class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(premiumViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _Header(),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      ...vm.premiumBenefits.map(
                        (benefit) => _BenefitItem(benefit),
                      ),
                      const SizedBox(height: 12),
                      const _InfoBox(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
            _BottomActionBar(vm: vm),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Mua gói Premium",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "PRO",
              style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final Map<String, String> benefit;

  const _BenefitItem(this.benefit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(benefit['icon'] ?? '', style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                benefit['text'] ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox();

  @override
  Widget build(BuildContext context) {
    const infoItems = [
      "• Bạn có thể huỷ gói Premium bất kỳ lúc nào. Chúng tôi sẽ xem xét và hoàn tiền nếu còn trong kỳ hạn.",
      "• Bạn có thể sử dụng Premium trên nhiều thiết bị.",
      "• Nếu có bất kỳ thắc mắc hay sai sót nào, vui lòng liên hệ với chúng tôi.",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông tin:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          ...[
            for (final text in infoItems)
              Padding(padding: EdgeInsets.only(bottom: 4), child: Text(text)),
          ],
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final PremiumViewModel vm;

  const _BottomActionBar({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.pink.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "404.000đ/ Năm (Trải nghiệm 7 ngày Free)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: vm.handlePurchasePremium,
              child: const Text(
                "Tiếp tục & Mở khoá Premium",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegalLink(
                  title: 'Chính sách bảo mật',
                  url: 'https://policies.google.com/privacy',
                  vm: vm,
                ),
                const Text(' & ', style: TextStyle(color: Colors.black)),
                _LegalLink(
                  title: 'Điều khoản dịch vụ',
                  url: 'https://policies.google.com/terms',
                  vm: vm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  final String title;
  final String url;
  final PremiumViewModel vm;

  const _LegalLink({required this.title, required this.url, required this.vm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrlExternal(url),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.black87,
        ),
      ),
    );
  }
}
