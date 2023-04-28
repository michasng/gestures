import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function(String search)? onSearch;

  const SearchBar({
    super.key,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Suche',
      ),
      onChanged: onSearch,
    );
  }
}
