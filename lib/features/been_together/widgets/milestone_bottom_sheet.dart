import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:memory_notes/core/extensions/extensions.dart';
import 'package:memory_notes/core/constants/constants.dart';
import '../view_model/been_together_viewmodel.dart';

class MilestoneBottomSheet extends ConsumerWidget {
  final VoidCallback? onEditPressed;

  const MilestoneBottomSheet({super.key, this.onEditPressed});

  List<Map<String, String>> _getUpcomingMilestones(int days, DateTime start) {
    final milestones = <Map<String, String>>[];

    final int daysInYear = 365; // Nếu bạn chưa có sẵn
    final List<int> dayMilestones;

    if (days < 100) {
      dayMilestones = [100, 200, daysInYear];
    } else if (days < daysInYear) {
      dayMilestones = [200, daysInYear, 2 * daysInYear];
    } else if (days < 5 * daysInYear) {
      dayMilestones = [5 * daysInYear, 10 * daysInYear, 15 * daysInYear];
    } else {
      return [];
    }

    for (var milestone in dayMilestones) {
      if (milestone > days) {
        DateTime milestoneDate;

        if (milestone % daysInYear == 0) {
          final yearsToAdd = (milestone / daysInYear).round();
          milestoneDate = DateTime(start.year + yearsToAdd, start.month, start.day);
        } else {
          milestoneDate = start.add(Duration(days: milestone)).subtract(Duration(days: 1));
        }

        milestones.add({
          'label': _formatMilestoneLabel(milestone),
          'date': DateFormat('dd/MM/yyyy').format(milestoneDate),
        });
      }
    }

    return milestones;
  }

  String _formatMilestoneLabel(int days) {
    if (days % AppConstants.daysInYear == 0) {
      return '${days ~/ AppConstants.daysInYear} năm';
    }
    return '$days ngày';
  }

  Color _getMilestoneColor(int days) {
    if (days % AppConstants.daysInYear == 0) return Colors.deepPurple;
    return Colors.pink;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loveInfoAsync = ref.watch(beenTogetherViewModelProvider);

    return loveInfoAsync.when(
      data: (loveInfo) {
        final startDate = loveInfo?.startDate;
        if (startDate == null) {
          return const Center(child: Text('Chưa có ngày bắt đầu'));
        }

        final milestones = _getUpcomingMilestones(
          loveInfo?.daysTogether ?? 0,
          startDate,
        );

        return SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      loveInfo?.title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${loveInfo?.subtitle} được:',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${loveInfo?.daysTogether} ngày',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (milestones.isNotEmpty) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Các cột mốc sắp tới:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: milestones.map((milestone) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.favorite,
                                color: _getMilestoneColor(
                                  int.parse(
                                    milestone['label']!.replaceAll(
                                      RegExp(r'[^0-9]'),
                                      '',
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(milestone['label']!),
                              subtitle: Text(milestone['date']!),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    const Divider(height: 2, thickness: 2),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: onEditPressed,
                            icon: const Icon(Icons.favorite_border),
                            label: const Text('Chỉnh sửa ngày kỷ niệm'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.pink,
                              backgroundColor: Colors.pink.shade50,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton.icon(
                        //     onPressed: onEditPressed,
                        //     icon: const Icon(Icons.tune),
                        //     label: const Text('Chỉnh sửa hiển thị'),
                        //     style: ElevatedButton.styleFrom(
                        //       foregroundColor: Colors.blue,
                        //       backgroundColor: Colors.blue.shade50,
                        //       elevation: 0,
                        //       padding: const EdgeInsets.symmetric(vertical: 16),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Lỗi: $error')),
    );
  }
}
