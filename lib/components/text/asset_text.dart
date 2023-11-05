import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_view.dart';

class AssetText extends StatelessWidget {
  final String path;

  const AssetText({
    super.key,
    required this.path,
  });

  Future<String> _load(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncView<String>(
      createFuture: () => _load(context),
      builder: (context, data) => Text(data),
    );
  }
}
