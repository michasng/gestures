import 'package:flutter/material.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:gestures/routes/site_notice/site_notice_route.dart';
import 'package:micha_core/micha_core.dart';

class SiteNoticeLink extends StatelessWidget {
  const SiteNoticeLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Link(
      onTap: () {
        SiteNoticeRoute().go(context);
      },
      child: Text('Impressum'),
    );
  }
}
