import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';

class Package {
  static const _iconMapping = {
    'Arbeitssicherheit': Icons.health_and_safety_outlined,
    'Ausbildung': Icons.menu_book,
    'Bankwesen': Icons.account_balance_outlined,
    'Bauwesen': Icons.carpenter,
    'Beruf - Arbeitsbereich': Icons.handyman_outlined,
    'Berufe': Icons.work_outline_rounded,
    'Bürowesen - Papierverarbeitung': Icons.receipt_long,
    'Computer': Icons.computer,
    'Einheiten - Geld - Geometrie - Mathematik': Icons.calculate_outlined,
    'Elektrowesen': Icons.electric_bolt,
    'Essen': Icons.restaurant,
    'Fahrzeuge und Verkehr': Icons.traffic,
    'Familie': Icons.family_restroom,
    'Farben': Icons.color_lens_outlined,
    'Feste (Advent - Nikolaus - Weihnachten)': Icons.church,
    'Feste (Allerheiligen)': Icons.church,
    'Feste (Fasching)': Icons.church,
    'Feste (Ostern - Pfingsten)': Icons.church,
    'Feste (Silvester)': Icons.church,
    'Feste (St. Martin)': Icons.church,
    'Feste': Icons.church,
    'Feuerwehr': Icons.fire_truck,
    'Fingeralphabet (GMS)': Icons.abc,
    'Freizeit - Urlaub': Icons.beach_access_outlined,
    'Gebäude': Icons.house_outlined,
    'Gefühle': Icons.mood,
    'Geografie - Länder': Icons.flag,
    'Gewürze': Icons.eco_outlined,
    'Hauswirtschaft': Icons.dry_cleaning_outlined,
    'Hygiene - Kosmetik': Icons.wash_outlined,
    'Hygiene': Icons.shower_outlined,
    'Jahreszeiten': Icons.sunny,
    'Justiz': Icons.gavel,
    'Kleidung': Icons.iron_outlined,
    'Kleine Wörter (Fragewörter)': Icons.text_decrease,
    'Kleine Wörter (Hilfsverben)': Icons.text_decrease,
    'Kleine Wörter (Ortsangaben)': Icons.text_decrease,
    'Kleine Wörter': Icons.text_decrease,
    'Krankheit - Medizin': Icons.medical_services_outlined,
    'Kräuter': Icons.eco,
    'Kunsthandwerk - Textil': Icons.brush_outlined,
    'Körper': Icons.accessibility_new_outlined,
    'Küche - Geschirr': Icons.kitchen_outlined,
    'Lagerwesen': Icons.warehouse_outlined,
    'Landschafts- und Gartenbau': Icons.yard_outlined,
    'Lautzeichen (PMS)': Icons.abc,
    'Maschinen - Material': Icons.precision_manufacturing_outlined,
    'Materialien': Icons.texture,
    'Metallwesen': Icons.diamond_outlined,
    'Monate': Icons.calendar_month_outlined,
    'Musik': Icons.music_note_outlined,
    'Möbel - Einrichtung': Icons.weekend_outlined,
    'Müll': Icons.delete_outline,
    'Nüsse': Icons.park_outlined,
    'Obst - Gemüse': Icons.apple,
    'Pflanzen - Natur': Icons.forest_outlined,
    'Politik': Icons.newspaper,
    'Redewendungen': Icons.notes,
    'Religion': Icons.church,
    'Schreinerei - Holzbearbeitung': Icons.cabin,
    'Schule': Icons.school_outlined,
    'Sexualität - Pubertät - Verhütung - Fortpflanzung': Icons.transgender,
    'Sonstige Wörter': Icons.more_horiz,
    'Spielplatz': Icons.child_care,
    'Sport': Icons.sports_basketball,
    'Tiere': Icons.pets,
    'Trinken': Icons.local_drink_outlined,
    'Verben': Icons.run_circle_outlined,
    'Wetter': Icons.cloudy_snowing,
    'Wochentage': Icons.date_range_outlined,
    'Wäscherei': Icons.local_laundry_service_outlined,
    'Zahlen': Icons.numbers,
    'Zeit': Icons.schedule,
    'industrielle Fertigung': Icons.factory,
    'Übergreifendes': Icons.select_all,
  };

  final String title;
  final List<Gesture> gestures;

  const Package({
    required this.title,
    required this.gestures,
  });

  IconData? get icon {
    return _iconMapping[title];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'gestures': gestures.map((gesture) => gesture.toJson()).toList(),
    };
  }

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      title: json['title'],
      gestures: (json['gestures'] as List)
          .map(
            (gestureJson) => Gesture.fromJson(
              gestureJson,
              packageId: json['title'],
            ),
          )
          .toList(),
    );
  }
}
