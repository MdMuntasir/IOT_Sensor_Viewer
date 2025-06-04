class ShowDataEntity {
  final String? name;
  final double? value;
  final double? alertValue;
  final String? alertCondition; // (G,>),(GE,>=),(L,<),(LE,<=),(E,==),(NE,!=)
  final bool? isDigital;


  const ShowDataEntity({
    this.name,
    this.value,
    this.alertValue,
    this.alertCondition,
    this.isDigital,
  });
}
