import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/faq_tips_viewmodel.dart';

class FaqTipsScreen extends ConsumerWidget {
  const FaqTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(faqTipsViewModelProvider);
    final faqList = viewModel.getFaqItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ & Tips'),
      ),
      body: ListView.separated(
        itemCount: faqList.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = faqList[index];
          return ExpansionTile(
            title: Text(
              item['question']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  item['answer']!,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}