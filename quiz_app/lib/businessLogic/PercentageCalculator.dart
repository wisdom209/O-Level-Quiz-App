import 'package:flutter/cupertino.dart';

class PercentageCalculator {
  const PercentageCalculator({@required this.receivedValue});
  final double receivedValue;
  double getPercent() {
    String result = ((receivedValue / 50) * 100).toStringAsFixed(1);
    return double.parse(result);
  }
}

