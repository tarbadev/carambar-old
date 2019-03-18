import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class WorkTabView extends BaseViewTester {
  WorkTabView(tester) : super(tester);

  bool get isVisible => widgetExists('availableJobs');
  Finder get _availableJobsFinder => find.byKey(Key('availableJobs'));
  JobDialogElement get jobDialog => JobDialogElement(tester);

  List<String> get availableJobs {
    var itemCount = (_availableJobsFinder.evaluate().single.widget as ListView).semanticChildCount;
    List<String> jobs = [];

    for(var i = 0; i < itemCount; i++) {
      try {
        jobs.add(getTextByKey('Jobs__$i'));
      } on StateError catch (_) {}
    }

    return jobs;
  }

  Future<void> tapOnAvailableJob(String job) async => await tester.tap(find.widgetWithText(ListTile, job));
}

class JobDialogElement extends BaseViewTester {
  JobDialogElement(tester) : super(tester);

  bool get isVisible => widgetExists('JobDialog');
  String get title => getTextByKey('JobDialog__JobTitle');
  String get requirements => getTextByKey('JobDialog__JobRequirements');

  Future<void> close() async => await tapOnButtonByKey('JobDialog__CloseButton');
}
