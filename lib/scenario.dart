import 'package:flutter_test/flutter_test.dart';

typedef ScenarioAction(Scenario);

class Scenario {
  bool _hasGiven = false;
  bool _hasWhen = false;
  bool _done = false;
  List<_Task> _actions = [];
  final String title;

  Scenario(String title, ScenarioAction action) : this.title = "Scenario: " + (title ?? "") {
    action?.call(this);
  }

  _queueAction(_Task action) {
    _actions.add(action);
  }


  Future<void> given(String label, Function() action) async {
    _hasGiven = true;
    _queueAction(_Task("Given $label", action));
    return;
  }

  Future<void> when(String label, Function() action) async {
    if (_done) return this;
    if (_hasGiven == false) throw Exception("A 'given' must be provided before a 'when'.");
    _hasWhen = true;
    _queueAction(_Task("When $label", action));
    return;
  }

  Future<void> and(String label, Function() action) async {
    if (_done) return this;
    if (_hasGiven == false || _hasWhen == false) throw Exception("A 'given' and 'when' must be provided before any 'and'.");
    _queueAction(_Task("And $label", action));
    return;
  }

  Future<void> then(String label, Function() action) async {
    if (_done) return this;
    if (_hasGiven == false || _hasWhen == false) throw Exception("A given and when must be provided before a 'then.");
    _done = true;
    _queueAction(_Task("Then $label", action));
    _run();
    return;
  }

  _run() {
    group(title, () {
      final label = _actions.map((task) => task.label);
      test(label, () async {
        for(int i = 0; i < _actions.length; i++) {
          await _actions[i].action();
        }
      });
    });
  }

  _runAction(_Task task) async {
    await test(task.label, () async {
      await task.action();
    });
  }
}

class _Task {
  final String label;
  final Function action;

  _Task(this.label, this.action);
}