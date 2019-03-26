import 'package:carambar/character/ui/entity/display_current_job.dart';
import 'package:intl/intl.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('DisplayCurrentJob', () {
    test('fromJob returns null if job is null', () {
      var expectedDisplayCurrentJob = DisplayCurrentJob(
        0,
        'Not employed',
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(0)}/year',
      );

      expect(DisplayCurrentJob.fromCurrentJob(null), expectedDisplayCurrentJob);
    });
  });
}
