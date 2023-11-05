import 'package:flutter/material.dart';
import 'package:gestures/components/async/async_builder.dart';

class AsyncView<T> extends StatefulWidget {
  final Future<T> Function() createFuture;
  final AppFutureBuilderCallback<T> builder;

  const AsyncView({
    super.key,
    required this.createFuture,
    required this.builder,
  });

  @override
  State<AsyncView<T>> createState() => _AsyncViewState<T>();
}

class _AsyncViewState<T> extends State<AsyncView<T>> {
  late Future<T> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.createFuture();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<T>(
      future: _loadFuture,
      builder: widget.builder,
    );
  }
}
