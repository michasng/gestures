import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';

class Package {
  static const _iconMapping = {
    'Arbeitssicherheit': Icons.health_and_safety_outlined,
    'Berufe': Icons.handyman_outlined,
    'Bürowesen - Papierverarbeitung': Icons.work_outline_rounded,
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
}
