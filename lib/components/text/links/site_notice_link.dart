import 'package:flutter/material.dart';
import 'package:gestures/components/text/links/link_text.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/routes/site_notice/site_notice_route.dart';

class SiteNoticeLink extends StatelessWidget {
  const SiteNoticeLink({super.key});

  @override
  Widget build(BuildContext context) {
    return LinkText(
      'Impressum',
      onTap: () {
        SiteNoticeRoute().go(context);
      },
    );
  }
}
