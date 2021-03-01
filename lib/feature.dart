import 'package:flutter_test/flutter_test.dart';

class Feature {
  final String label;
  final Function task;

  Feature(this.label, this.task) {
    group("Feature: $label", task);
  }
}
