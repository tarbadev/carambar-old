import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class WorkTabView extends BaseView {
  final WidgetTester tester;

  WorkTabView(this.tester) : super(tester);

  Finder get _availableJobsFinder => find.byKey(Key("availableJobs"));
  Finder get _jobRequirementsFinder => find.byKey(Key("jobRequirements"));
  Finder get _jobRequirementsCloseFinder => find.byKey(Key("jobRequirementsCloseButton"));

  bool get isVisible {
    try {
      tester.renderObject<RenderBox>(_availableJobsFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool get isJobRequirementsVisible {
    try {
      tester.renderObject<RenderBox>(_jobRequirementsFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  String get jobRequirements => getDataFromTextByFinder(_jobRequirementsFinder);

  List<String> getAvailableJobs() {
    var itemCount = (_availableJobsFinder.evaluate().single.widget as ListView).semanticChildCount;
    List<String> jobs = [];

    for(var i = 0; i < itemCount; i++) {
      try {
        jobs.add(getDataFromTextByKey('Jobs__$i'));
      } on StateError catch (_) {}
    }

    return jobs;
  }

  Future<void> tapOnAvailableJob(String job) async => await tester.tap(find.widgetWithText(ListTile, job));

  Future<void> tapOnCloseJobRequirementsDialog() async => await tester.tap(_jobRequirementsCloseFinder);
}
