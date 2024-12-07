class EnumValues<T> {
  Map<String, T> _map;
  Map<T, String>? _reverseMap;

  EnumValues(this._map);

  Map<T, String>? get reverse {
    _reverseMap ??= _map.map((k, v) => MapEntry(v, k));
    return _reverseMap;
  }
}
