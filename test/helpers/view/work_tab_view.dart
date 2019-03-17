import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class WorkTabView extends BaseView {
  final WidgetTester tester;

  WorkTabView(this.tester) : super(tester);

  Finder get _availableJobsFinder => find.byKey(Key("availableJobs"));

  bool get isVisible {
    try {
      tester.renderObject<RenderBox>(_availableJobsFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  List<String> getAvailableJobs() {
    var itemCount = (_availableJobsFinder.evaluate().single.widget as ListView).semanticChildCount;
    List<String> jobs = [];

    for(var i = 0; i < itemCount; i++) {
      try {
        jobs.add((find.byKey(Key('Jobs__$i')).evaluate().single.widget as Text).data);
      } on StateError catch (_) {}
    }

    return jobs;
  }
}
