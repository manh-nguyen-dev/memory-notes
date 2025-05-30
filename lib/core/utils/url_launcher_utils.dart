import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlExternal(String urlString) async {
  final url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Không thể mở liên kết: $urlString';
  }
}