import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class WorkTabView extends BaseView {
  WorkTabView(tester) : super(tester);

  Finder get _availableJobsFinder => find.byKey(Key("availableJobs"));
  bool get isVisible {
    try {
      tester.renderObject<RenderBox>(_availableJobsFinder);
      return true;
    } catch (_) {
      return false;
    }
  }
  JobDialogElement get jobDialog => JobDialogElement(tester);

  List<String> get availableJobs {
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
}

class JobDialogElement extends BaseView {
  Finder get _dialogFinder => find.byType(AlertDialog);
  Finder get _closeButtonFinder => find.byKey(Key('JobDialog__CloseButton'));
  Finder get _jobTitleFinder => find.byKey(Key("JobDialog__JobTitle"));
  Finder get _jobRequirementsFinder => find.byKey(Key("JobDialog__JobRequirements"));

  JobDialogElement(tester) : super(tester);

  bool get isVisible {
    try {
      tester.renderObject<RenderBox>(_dialogFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  String get title => getDataFromTextByFinder(_jobTitleFinder);
  String get requirements => getDataFromTextByFinder(_jobRequirementsFinder);

  Future<void> close() async {
    await tester.tap(_closeButtonFinder);
    await tester.pump();
  }
}
