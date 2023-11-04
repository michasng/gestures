import 'package:flutter/material.dart';
import 'package:gestures/components/screen_body.dart';
import 'package:gestures/components/text/app_title.dart';
import 'package:gestures/screens/packages/packages_screen.dart';
import 'package:go_router/go_router.dart';

class SiteNoticeScreen extends StatelessWidget {
  static const String path = '/site_notice';

  const SiteNoticeScreen({super.key});

  List<Widget> _buildSection(
    BuildContext context,
    String title,
    String sectionText,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return [
      Text(title, style: textTheme.titleMedium),
      SizedBox(height: 16),
      Text(sectionText),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: ScreenBody(
        alignment: Alignment.center,
        children: [
          Text('Impressum', style: textTheme.titleLarge),
          SizedBox(height: 32),
          ..._buildSection(
            context,
            'Angaben gemäß § 5 TMG',
            'Dominikus-Ringeisen-Werk, kirchliche Stiftung des öffentlichen Rechts\nKlosterhof 2\n86513 Ursberg',
          ),
          SizedBox(height: 16),
          ..._buildSection(
            context,
            'Vertreten durch:',
            'Geistl. Direktor Martin Riß, Vorstandsvorsitzender\nMichael Winter, Stv. Vorstandsvorsitzender',
          ),
          SizedBox(height: 16),
          ..._buildSection(
            context,
            'Kontakt',
            'E-Mail: schulleitung.franzvonsales-schule@drw.de',
          ),
          SizedBox(height: 16),
          ..._buildSection(
            context,
            'Umsatzsteuer-ID',
            'Umsatzsteuer-Identifikationsnummer gemäß § 27 a Umsatzsteuergesetz:\nDE 811974491',
          ),
          SizedBox(height: 64),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.go(PackagesScreen.path);
        },
        child: Text('Weiter zur App'),
      ),
    );
  }
}
