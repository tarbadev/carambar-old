import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_driver.dart';

class WorkTabHelper extends BaseViewDriver {
  final _jobsTabFinder = find.byValueKey('bottomNavigationWork');

  WorkTabHelper(driver) : super(driver);

  Future<void> goTo() async {
    await driver.tap(_jobsTabFinder);
  }

  Future<bool> get isAvailableJobsVisible async => await widgetExists('availableJobs');
  JobDialogElement get jobDialog => JobDialogElement(driver);

  Future<List<String>> get availableJobs async {
    List<String> jobs = [];
    try {
      var index = 0;
      do {
        jobs.add(await getTextByKey('Jobs__${index++}', timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return jobs;
  }

  Future<void> tapOnAvailableJob(String job) async {
    await driver.tap(find.text(job));
  }
}

class JobDialogElement extends BaseViewDriver {
  SerializableFinder get _closeButtonFinder => find.byValueKey('JobDialog__CloseButton');

  JobDialogElement(driver): super(driver);

  Future<bool> get isVisible => widgetExists('JobDialog');

  Future<String> get title async => getTextByKey('JobDialog__JobTitle');
  Future<String> get requirements async => getTextByKey('JobDialog__JobRequirements');

  Future<void> close() async {
    await driver.tap(_closeButtonFinder);
  }
}