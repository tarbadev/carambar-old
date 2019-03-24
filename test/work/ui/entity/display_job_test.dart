import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:intl/intl.dart';
import 'package:test_api/test_api.dart';

import '../../../helpers/factory.dart';

void main() {
  group('Displayjob', () {
    test('fromJob generates DisplayJob with HighSchool requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 High School completed successfully'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.HighSchool])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Supervisor3Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Supervisor for 3+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Supervisor3Years])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Teacher5Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Teacher for 5+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Teacher5Years])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Counselor5Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Counselor for 5+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Counselor5Years])), expectedDisplayJob);
    });

    test('fromJob returns null if job is null', () {
      var expectedDisplayJob = DisplayJob(
        0,
        'Not employed',
        [''],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(0)}/year',
      );

      expect(DisplayJob.fromJob(null), expectedDisplayJob);
    });
  });
}
