class AlertConditionModel {
  final double value;
  final double alertValue;
  final String condition;

  const AlertConditionModel(this.alertValue, this.condition, this.value);

  bool evaluateCondition() {
    final operations = <String, bool Function(double, double)>{
      'E':  (a, b) => a == b,
      'NE': (a, b) => a != b,
      'G':  (a, b) => a > b,
      'L':  (a, b) => a < b,
      'GE': (a, b) => a >= b,
      'LE': (a, b) => a <= b,
    };

    final operation = operations[condition.toUpperCase()];

    if (operation == null) {
      throw ArgumentError('Invalid condition: $condition');
    }

    return operation(alertValue, value);
  }
}
