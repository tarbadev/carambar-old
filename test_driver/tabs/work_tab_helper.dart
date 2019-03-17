import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_helper.dart';

class WorkTabHelper extends BaseViewHelper {
  final _jobsTabFinder = find.byValueKey('bottomNavigationWork');
  final _availableJobsFinder = find.byValueKey('availableJobs');
  final _jobRequirementsFinder = find.byValueKey('jobRequirements');
  final _jobRequirementsCloseFinder = find.byValueKey('jobRequirementsCloseButton');

  WorkTabHelper(driver) : super(driver);

  Future<void> goTo() async {
    await driver.tap(_jobsTabFinder);
  }

  Future<bool> get isAvailableJobsVisible async => await widgetExists(_availableJobsFinder);
  Future<bool> get isJobRequirementsVisible async => await widgetExists(_jobRequirementsFinder, timeout: Duration(milliseconds: 500));

  Future<String> get jobRequirements async => await driver.getText(_jobRequirementsFinder);

  Future<List<String>> getAvailableJobs() async {
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

  Future<void> closeJobRequirementsDialog() async {
    await driver.tap(_jobRequirementsCloseFinder);
  }
}
