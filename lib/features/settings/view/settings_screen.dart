import 'package:flutter/material.dart';
import 'package:memory_notes/core/constants/constants.dart';

import '../../../core/utils/url_launcher_utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: [
          _buildSectionHeader('Cài đặt hiển thị'),
          _buildTile(
            context,
            title: 'Phông chữ trên Been Together',
            onTap: () {
              // TODO: Navigate to font settings
            },
          ),
          _buildTile(
            context,
            title: 'Màu sắc chữ',
            onTap: () {
              // TODO: Navigate to color picker
            },
          ),
          _buildTile(
            context,
            title: 'Kích thước chữ',
            onTap: () {
              // TODO: Navigate to font size settings
            },
          ),
          _buildSectionHeader('Cài đặt khoá'),
          _buildTile(
            context,
            title: 'Cài đặt mật khẩu',
            onTap: () {
              // TODO: Navigate to lock setup
            },
          ),
          _buildSectionHeader('Gửi phản hồi đến chúng tôi'),
          SwitchListTile(
            title: const Text('Cho phép khi có sự cố'),
            value: true,
            onChanged: (value) {
              // TODO: Toggle crash report consent
            },
          ),
          _buildSectionHeader('Giới thiệu app'),
          _buildTile(
            context,
            title: 'Chính sách bảo mật',
            onTap: () {
              launchUrlExternal('https://policies.google.com/privacy');
            },
          ),
          _buildTile(
            context,
            title: 'Điều khoản dịch vụ',
            onTap: () {
              launchUrlExternal('https://policies.google.com/terms');
            },
          ),
          ListTile(
            enabled: false,
            title: const Text('Phiên bản'),
            subtitle: const Text('v${AppConstants.appVersion}'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required String title, VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}