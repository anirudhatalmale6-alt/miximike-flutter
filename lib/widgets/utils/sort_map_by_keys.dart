Map<String, dynamic> sortMapByKeys(Map<String, dynamic> map) {
  return Map<String, dynamic>.from(
      Map.fromEntries(
          map.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key))
      )
  );
}
