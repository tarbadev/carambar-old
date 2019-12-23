import 'package:carambar/work/ui/widget/job_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class WorkTabView extends BaseViewTester {
  WorkTabView(tester) : super(tester);

  bool get isVisible => widgetExists('Work__AvailableJobs');
  Finder get _availableJobsFinder => find.byKey(Key('Work__AvailableJobs'));
  JobDialogElement get jobDialog => JobDialogElement(tester);

  List<String> get availableJobs {
    var itemCount = (_availableJobsFinder.evaluate().single.widget as ListView).semanticChildCount;
    List<String> jobs = [];

    for(var i = 0; i < itemCount; i++) {
      try {
        jobs.add(getTextByKey('Work__Jobs__title__$i'));
      } on StateError catch (_) {}
    }

    return jobs;
  }

  Future<void> tapOnAvailableJob(String job) async => await tapOnButtonByWidgetAndText(JobListItem, job);
}

class JobDialogElement extends BaseViewTester {
  JobDialogElement(tester) : super(tester);

  bool get isVisible => widgetExists('JobDialog');
  String get title => getTextByKey('JobDialog__JobTitle');
  String get salary => getTextByKey('JobDialog__JobSalary');
  List<String> get requirements => (tester.widget(find.byKey(Key('JobDialog__JobRequirements'))) as Column)
      .children
      .map((requirementText) => (requirementText as Text).data)
      .toList();
  List<String> get personalityTraits => (tester.widget(find.byKey(Key('JobDialog__JobPersonalityTraits'))) as Column)
      .children
      .map((personalityTraitText) => (personalityTraitText as Text).data)
      .toList();

  Future<void> close() async => await tapOnButtonByKey('JobDialog__CloseButton');
  Future<void> apply() async => await tapOnButtonByKey('JobDialog__ApplyButton');
}
