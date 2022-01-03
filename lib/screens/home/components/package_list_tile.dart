import 'package:flutter/material.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/package/package_screen.dart';

class PackageListTile extends StatelessWidget {
  final Package package;

  const PackageListTile({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(package.title),
      subtitle: Text('${package.gestures.length} Videoclips'),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PackageScreen(package: package),
        ),
      ),
    );
  }
}
