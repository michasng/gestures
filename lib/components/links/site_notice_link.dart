import 'package:flutter/material.dart';
import 'package:gestures/components/links/link_text.dart';
import 'package:gestures/screens/site_notice/site_notice_screen.dart';
import 'package:go_router/go_router.dart';

class SiteNoticeLink extends StatelessWidget {
  const SiteNoticeLink({super.key});

  @override
  Widget build(BuildContext context) {
    return LinkText(
      'Impressum',
      onTap: () {
        context.go(SiteNoticeScreen.path);
      },
    );
  }
}
