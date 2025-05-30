import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../memory/view_model/avatar_view_model.dart';

class AvatarSection extends ConsumerWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarPath = ref.watch(avatarProvider);

    return GestureDetector(
      onTap: () => _showAvatarDialog(context, ref, avatarPath),
      child: CircleAvatar(
        radius: 52,
        backgroundColor: Colors.grey[300],
        backgroundImage: AssetImage(avatarPath),
      ),
    );
  }

  void _showAvatarDialog(
    BuildContext context,
    WidgetRef ref,
    String avatarPath,
  ) {
    showDialog(
      context: context,
      builder: (_) => AvatarOptionsDialog(ref: ref, avatarPath: avatarPath),
    );
  }
}

class AvatarOptionsDialog extends StatelessWidget {
  final WidgetRef ref;
  final String avatarPath;

  const AvatarOptionsDialog({
    super.key,
    required this.ref,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      title: const Text('Tùy chọn ảnh đại diện'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Xem ảnh'),
            onTap: () {
              context.pop();
              _viewAvatar(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Thay đổi ảnh'),
            onTap: () {
              context.pop();
              _showAvatarPicker(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Xoá ảnh'),
            onTap: () async {
              await ref.read(avatarProvider.notifier).resetAvatar();
              context.pop();
            },
          ),
        ],
      ),
    );
  }

  void _viewAvatar(BuildContext context) {
    if (avatarPath.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không tìm thấy ảnh.')));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(avatarPath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => AvatarPickerSheet(ref: ref),
    );
  }
}

class AvatarPickerSheet extends StatelessWidget {
  final WidgetRef ref;

  const AvatarPickerSheet({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Chọn Avatar",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              final avatarPath =
                  'assets/images/default_avatar_${index + 1}.png';
              return GestureDetector(
                onTap: () async {
                  await ref
                      .read(avatarProvider.notifier)
                      .updateAvatar(avatarPath);
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatarPath),
                  radius: 28,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
