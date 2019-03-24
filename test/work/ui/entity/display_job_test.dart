import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:intl/intl.dart';
import 'package:test_api/test_api.dart';

import '../../../helpers/factory.dart';

void main() {
  group('Displayjob', () {
    test('fromJob generates DisplayJob', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        '\u2022 ${job.requirements}',
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
      );

      expect(DisplayJob.fromJob(Factory.job()), expectedDisplayJob);
    });

    test('fromJob returns null if job is null', () {
      expect(DisplayJob.fromJob(null), isNull);
    });
  });
}
