import 'base_view_driver.dart';

class WorkTabHelper extends BaseViewDriver {
  WorkTabHelper(driver) : super(driver);

  Future<void> goTo() async {
    await tapOnButtonByKey('Home__BottomNavigationWork');
  }

  Future<bool> get isAvailableJobsVisible async => await widgetExists('Work__AvailableJobs');
  JobDialogElement get jobDialog => JobDialogElement(driver);

  Future<List<String>> get availableJobs async {
    List<String> jobs = [];
    try {
      var index = 0;
      do {
        jobs.add(await getTextByKey('Work__Jobs__title__${index++}', timeout: Duration(milliseconds: 500)));
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
  Future<String> get salary async => getTextByKey('JobDialog__JobSalary');
  Future<List<String>> get requirements async {
    List<String> requirements = [];
    try {
      var index = 0;
      do {
        requirements.add(await getTextByKey('JobDialog__JobRequirements__${index++}', timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return requirements;
  }
  Future<List<String>> get personalityTraits async {
    List<String> personalityTraits = [];
    try {
      var index = 0;
      do {
        personalityTraits.add(await getTextByKey('JobDialog__JobPersonalityTraits__${index++}', timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return personalityTraits;
  }

  Future<void> close() async {
    await tapOnButtonByKey('JobDialog__CloseButton');
  }

  Future<void> apply() async {
    await tapOnButtonByKey('JobDialog__ApplyButton');
  }
}