import 'package:gestures/models/package.dart';

class AppContent {
  final List<Package> packages;

  const AppContent({
    required this.packages,
  });

  Map<String, dynamic> toJson() {
    return {
      'packages': packages.map((package) => package.toJson()).toList(),
    };
  }

  factory AppContent.fromJson(Map<String, dynamic> json) {
    return AppContent(
      packages: (json['packages'] as List)
          .map(
            (packageJson) => Package.fromJson(
              packageJson as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
