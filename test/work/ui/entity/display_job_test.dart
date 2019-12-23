import 'package:carambar/work/domain/entity/job.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:intl/intl.dart';
import 'package:flutter_test/flutter_test.dart';

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
        ['\u2022 Charismatic'],
      );

      expect(
          DisplayJob.fromJob(
              Factory.job(requirements: [Requirement.HighSchool], personalityTraits: [PersonalityTrait.Charismatic])),
          expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Supervisor3Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Supervisor for 3+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        ['\u2022 Patient'],
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Supervisor3Years], personalityTraits: [PersonalityTrait.Patient])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with SubTeacher1Year requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Substitute Teacher for 1+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        ['\u2022 Benevolent'],
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.SubTeacher1Year], personalityTraits: [PersonalityTrait.Benevolent])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Teacher5Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Teacher for 5+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        ['\u2022 Benevolent'],
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Teacher5Years], personalityTraits: [PersonalityTrait.Benevolent])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with Counselor5Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Counselor for 5+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        ['\u2022 Charismatic'],
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.Counselor5Years])), expectedDisplayJob);
    });

    test('fromJob generates DisplayJob with AssociateDirector5Years requirement', () {
      var job = Factory.job();
      var expectedDisplayJob = DisplayJob(
        job.id,
        job.name,
        ['\u2022 Associate Director for 5+ years'],
        '${NumberFormat.simpleCurrency(decimalDigits: 0).format(job.salary)}/year',
        ['\u2022 Charismatic'],
      );

      expect(DisplayJob.fromJob(Factory.job(requirements: [Requirement.AssociateDirector5Years])), expectedDisplayJob);
    });
  });
}
