import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/character/ui/entity/display_current_job.dart';
import 'package:carambar/character/ui/entity/display_job_experience.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';

void main() {
  group('DisplayCharacter', () {
    test('fromCharacter generates DisplayCharacter', () {
      var currentJob = Factory.job();
      var displayCurrentJob = DisplayCurrentJob.fromJob(currentJob);
      var displayJobHistory = [
        DisplayJobExperience.fromJobExperience(
            Factory.jobExperience(name: 'Supervisor')),
        DisplayJobExperience.fromJobExperience(
            Factory.jobExperience(name: 'Teacher')),
      ];
      var expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '2',
        'United States',
        'Baby',
        'None',
        [],
        displayCurrentJob,
        displayJobHistory,
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
            age: 2,
            graduates: [],
            currentJob: currentJob,
            jobHistory: [
              Factory.jobExperience(name: 'Teacher'),
              Factory.jobExperience(name: 'Supervisor')
            ],
            school: School.None,
          )),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '4',
        'United States',
        'Child',
        'Kindergarten',
        [],
        displayCurrentJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
              age: 4,
              graduates: [],
              currentJob: currentJob,
              school: School.Kindergarten)),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '8',
        'United States',
        'Child',
        'Primary School',
        [],
        displayCurrentJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
            age: 8,
            graduates: [],
            currentJob: currentJob,
            school: School.PrimarySchool,
          )),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '12',
        'United States',
        'Teen',
        'Middle School',
        [],
        displayCurrentJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
            age: 12,
            graduates: [],
            currentJob: currentJob,
            school: School.MiddleSchool,
          )),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '15',
        'United States',
        'Teen',
        'High School',
        ['Middle School'],
        displayCurrentJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
            age: 15,
            graduates: [School.MiddleSchool],
            currentJob: currentJob,
            school: School.HighSchool,
          )),
          expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '42',
        'United States',
        'Adult',
        'None',
        [],
        displayCurrentJob,
        [],
      );

      expect(
          DisplayCharacter.fromCharacter(Factory.character(
              age: 42, graduates: [], currentJob: currentJob)),
          expectedDisplayCharacter);
    });
  });
}
