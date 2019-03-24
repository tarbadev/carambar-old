import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:test_api/test_api.dart';

import '../../../helpers/factory.dart';

void main() {
  group('DisplayCharacter', () {
    test('fromCharacter generates DisplayCharacter', () {
      var job = Factory.job();
      var displayJob = DisplayJob.fromJob(job);
      var displayJobHistory = [
        DisplayJobExperience.fromJobExperience(Factory.jobExperience(name: 'Supervisor')),
        DisplayJobExperience.fromJobExperience(Factory.jobExperience(name: 'Teacher')),
      ];
      var expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '2',
        'United States',
        'Baby',
        'None',
        [],
        displayJob,
        displayJobHistory,
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
              age: 2,
              graduates: [],
              job: job,
              jobHistory: [Factory.jobExperience(name: 'Teacher'), Factory.jobExperience(name: 'Supervisor')])),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '4',
        'United States',
        'Child',
        'Kindergarten',
        [],
        displayJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(age: 4, graduates: [], job: job)), expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '8',
        'United States',
        'Child',
        'Primary School',
        [],
        displayJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(age: 8, graduates: [], job: job)), expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '12',
        'United States',
        'Teen',
        'Middle School',
        [],
        displayJob,
        [],
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 12, graduates: [], job: job)),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '15',
        'United States',
        'Teen',
        'High School',
        ['Middle School'],
        displayJob,
        [],
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 15, graduates: [Graduate.MiddleSchool], job: job)),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '42',
        'United States',
        'Adult',
        'None',
        [],
        displayJob,
        [],
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 42, graduates: [], job: job)),
          expectedDisplayCharacter);
    });
  });
}
