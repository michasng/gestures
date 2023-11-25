import 'package:flutter/material.dart';
import 'package:gestures/components/screen_body.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/routes/packages/packages_route.dart';
import 'package:gestures/routes/root_route.dart';
import 'package:go_router/go_router.dart';
import 'package:micha_core/micha_core.dart';

class SiteNoticeRoute extends GoRouteData {
  const SiteNoticeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        leading: IconButton(
          onPressed: () => PackagesRoute().go(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ScreenBody(
        alignment: Alignment.center,
        children: [
          ThemedText.titleLarge('Impressum'),
          Gap() * 2,
          ...[
            ThemedText.titleMedium('Angaben gemäß § 5 TMG'),
            Text(
              'Dominikus-Ringeisen-Werk, kirchliche Stiftung des öffentlichen Rechts\nKlosterhof 2\n86513 Ursberg',
            ),
            ThemedText.titleMedium('Vertreten durch:'),
            Text(
              'Geistl. Direktor Martin Riß, Vorstandsvorsitzender\nMichael Winter, Stv. Vorstandsvorsitzender',
            ),
            ThemedText.titleMedium('Kontakt'),
            Text('E-Mail: schulleitung.franzvonsales-schule@drw.de'),
            ThemedText.titleMedium('Umsatzsteuer-ID'),
            Text(
              'Umsatzsteuer-Identifikationsnummer gemäß § 27 a Umsatzsteuergesetz:\nDE 811974491',
            ),
          ].separated(Gap()),
          Gap() * 4,
        ],
      ),
      floatingActionButton: FilledButton(
        onPressed: () => PackagesRoute().go(context),
        child: Text('Weiter zur App'),
      ),
    );
  }
}
