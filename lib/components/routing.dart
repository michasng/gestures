String createQueryString(Map<String, dynamic> queryParams) {
  final nonNullQueryParams =
      queryParams.keys.where((key) => queryParams[key] != null);
  if (nonNullQueryParams.isEmpty) return '';

  return '?${nonNullQueryParams.map((key) => '$key=${queryParams[key]}').join('&')}';
}
