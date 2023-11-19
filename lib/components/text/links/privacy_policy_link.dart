import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micha_core/micha_core.dart';
import 'package:universal_html/html.dart' as html;

class PrivacyPolicyLink extends StatelessWidget {
  const PrivacyPolicyLink({super.key});

  static Future<void> showPrivacyPolicy() async {
    var bytes = await rootBundle.load('assets/DRW-DSE-gebaerden-web-app.pdf');

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Link(
      onTap: showPrivacyPolicy,
      child: Text('Datenschutzerklärung'),
    );
  }
}
