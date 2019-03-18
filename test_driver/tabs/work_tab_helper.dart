import 'base_view_driver.dart';

class WorkTabHelper extends BaseViewDriver {
  WorkTabHelper(driver) : super(driver);

  Future<void> goTo() async {
    await tapOnButtonByKey('bottomNavigationWork');
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
    await tapOnButtonByText(job);
  }
}

class JobDialogElement extends BaseViewDriver {
  JobDialogElement(driver): super(driver);

  Future<bool> get isVisible => widgetExists('JobDialog');

  Future<String> get title async => getTextByKey('JobDialog__JobTitle');
  Future<String> get requirements async => getTextByKey('JobDialog__JobRequirements');

  Future<void> close() async {
    await tapOnButtonByKey('JobDialog__CloseButton');
  }
}