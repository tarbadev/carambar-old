import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';

void main() {
  group('DisplayJobExperience', () {
    test('fromJobExperience generates DisplayJobExperience', () {
      var jobExperience = Factory.jobExperience(name: 'Supervisor', experience: 7);
      var expectedDisplayJobExperience = DisplayJobExperience(
        name: 'Supervisor',
        experience: '7 years',
      );

      expect(DisplayJobExperience.fromJobExperience(jobExperience), expectedDisplayJobExperience);
    });
  });
}
