class SavedLocale {
  String? localeName;
  String? savedDate;

  SavedLocale({
    this.localeName,
    this.savedDate,
  }) {
    if (localeName == null) {
      localeName = 'en_UK';
    }
    if (savedDate == null) {
      savedDate = DateTime.now().toIso8601String();
    }
  }

  factory SavedLocale.fromJson(Map<String, dynamic> json) => SavedLocale(
        localeName: json["localeName"],
        savedDate: json["savedDate"] ?? DateTime.now().toIso8601String(),
      );

  Map<String, dynamic> toJson() => {
        "localeName": localeName,
        "savedDate": savedDate,
      };
}
