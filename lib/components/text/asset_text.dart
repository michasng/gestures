import 'package:flutter/material.dart';
import 'package:gestures/components/app_future_builder.dart';

class AssetText extends StatefulWidget {
  final String path;

  const AssetText({
    super.key,
    required this.path,
  });

  @override
  State<AssetText> createState() => _AssetTextState();
}

class _AssetTextState extends State<AssetText> {
  late Future<String> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = load();
  }

  Future<String> load() {
    return DefaultAssetBundle.of(context).loadString(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<String>(
      future: _loadFuture,
      builder: (context, data) => Text(data),
    );
  }
}
