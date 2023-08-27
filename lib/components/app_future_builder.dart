import 'package:flutter/material.dart';
import 'package:gestures/components/spinner.dart';

typedef AppFutureBuilderCallback<T> = Widget Function(
  BuildContext context,
  T data,
);

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final AppFutureBuilderCallback<T> builder;

  const AppFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return const Spinner();

        if (snapshot.error != null) return Text(snapshot.error.toString());

        final T? data = snapshot.data;
        if (data == null) return Text('Fehler: Keine Daten.');
        return builder(context, data);
      },
    );
  }
}
