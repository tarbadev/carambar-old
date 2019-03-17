import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_helper.dart';

class WorkTabHelper extends BaseViewHelper {
  final _jobsTabFinder = find.byValueKey('bottomNavigationWork');
  final _availableJobsFinder = find.byValueKey('availableJobs');

  WorkTabHelper(driver) : super(driver);

  Future<void> goTo() async {
    await driver.tap(_jobsTabFinder);
  }

  Future<bool> get isAvailableJobsVisible async => await widgetExists(_availableJobsFinder);
  JobDialogElement get jobDialog => JobDialogElement(driver);

  Future<List<String>> get availableJobs async {
    List<String> jobs = [];
    try {
      var index = 0;
      do {
        jobs.add(await driver.getText(find.byValueKey('Jobs__${index++}'), timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return jobs;
  }

  Future<void> tapOnAvailableJob(String job) async {
    await driver.tap(find.text(job));
  }
}

class JobDialogElement extends BaseViewHelper {
  SerializableFinder get _dialogFinder => find.byType('AlertDialog');
  SerializableFinder get _closeButtonFinder => find.byValueKey('JobDialog__CloseButton');
  SerializableFinder get _jobTitleFinder => find.byValueKey("JobDialog__JobTitle");
  SerializableFinder get _jobRequirementsFinder => find.byValueKey("JobDialog__JobRequirements");

  JobDialogElement(driver): super(driver);

  Future<bool> get isVisible => widgetExists(_dialogFinder, timeout: Duration(milliseconds: 500));

  Future<String> get title async => await driver.getText(_jobTitleFinder);
  Future<String> get requirements async => await driver.getText(_jobRequirementsFinder);

  Future<void> close() async {
    await driver.tap(_closeButtonFinder);
  }
}