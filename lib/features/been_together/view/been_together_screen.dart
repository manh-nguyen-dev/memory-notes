import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import 'package:memory_notes/core/extensions/love_info_extension.dart';

import '../../../app/routers.dart';
import '../view_model/been_together_viewmodel.dart';
import '../widgets/avatar_section.dart';
import '../widgets/edit_love_info_bottom_sheet.dart';
import '../widgets/milestone_bottom_sheet.dart';

class BeenTogetherScreen extends ConsumerWidget {
  const BeenTogetherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loveInfoAsync = ref.watch(beenTogetherViewModelProvider);

    return loveInfoAsync.when(
      data: (loveInfo) {
        if (loveInfo == null) {
          return const Scaffold(
            body: Center(child: Text('No love info found')),
          );
        }

        return Scaffold(
          drawer: _buildDrawer(context),
          appBar: _buildAppBar(context, loveInfo.startDate),
          extendBodyBehindAppBar: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/love_background.png',
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withAlpha(80)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        loveInfo.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${loveInfo.daysTogether} ngày',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        loveInfo.subtitle,
                        style: const TextStyle(
                          fontSize: 21,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Lỗi: $error'))),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.pink.shade100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/app_icon.png',
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Memory Notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 52),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.date_range_outlined),
                      title: const Text('Ngày kỉ niệm'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.timeline_outlined),
                      title: const Text('Dòng thời gian'),
                      onTap: () {
                        context.push(Routes.comingSoon);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.calculate_outlined),
                      title: const Text('Tính ngày'),
                      onTap: () {
                        context.push(Routes.comingSoon);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.sync),
                      title: const Text('Đồng bộ với thiết bị khác'),
                      onTap: () {
                        context.push(Routes.comingSoon);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.tips_and_updates),
                      title: const Text('FAQ & Tips'),
                      onTap: () {
                        context.push(Routes.faqTipsScreen);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Cài đặt'),
                      onTap: () {
                        context.push(Routes.settings);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.tips_and_updates),
                      title: const Text('Premium'),
                      onTap: () {
                        context.push(Routes.premiumScreen);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 8,
            top: 170,
            child: AvatarSection(),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, DateTime startDate) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        _buildCircleButton(
          icon: Icons.music_note,
          onPressed: () {
            context.push(Routes.backgroundMusic);
          },
        ),
        _buildCircleButton(
          icon: Icons.share,
          onPressed: () {
            context.push(Routes.comingSoon);
          },
        ),
        _buildCircleButton(
          icon: Icons.more_horiz,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              context: context,
              builder: (context) => MilestoneBottomSheet(
                onEditPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => const EditLoveInfoBottomSheet(),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .4),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onPressed,
          tooltip: icon.toString(),
        ),
      ),
    );
  }
}
