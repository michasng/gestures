import 'package:flutter/material.dart';
import 'package:gestures/components/app_future_builder.dart';

class Preface extends StatefulWidget {
  const Preface({super.key});

  @override
  State<Preface> createState() => _PrefaceState();
}

class _PrefaceState extends State<Preface> {
  late Future<String> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = load();
  }

  Future<String> load() {
    return DefaultAssetBundle.of(context).loadString('assets/preface.txt');
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<String>(
      future: _loadFuture,
      builder: (context, data) => SelectableText(data),
    );
  }
}
