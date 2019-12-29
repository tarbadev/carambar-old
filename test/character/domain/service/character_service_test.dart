import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/mock_definition.dart';

void main() {
  group('CharacterService', () {
    CharacterService characterService;

    setUp(() {
      characterService = CharacterService(Mocks.characterClient);
      reset(Mocks.characterClient);
    });

    test('generateCharacter generates a new character and saves it', () async {
      final expectedCharacter = Factory.character(age: 0);

      when(Mocks.characterClient.generateCharacter()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.generateCharacter(), expectedCharacter);
    });

    group('getUnmetRequirements', () {
      test('returns [] when all requirements are met for HighSchool requirement', () async {
        final job = Factory.job(requirements: [Requirement.HighSchool]);
        final character = Factory.character(graduates: [School.HighSchool]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [] when all requirements are met for Supervisor3Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Supervisor3Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Supervisor', experience: 3)]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [] when all requirements are met for SubTeacher1Year requirement', () async {
        final job = Factory.job(requirements: [Requirement.SubTeacher1Year]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Substitute Teacher', experience: 1)]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [] when all requirements are met for Teacher5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Teacher5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Teacher', experience: 5)]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [] when all requirements are met for Counselor5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Counselor5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Counselor', experience: 5)]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [] when all requirements are met for AssociateDirector5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.AssociateDirector5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Associate Director', experience: 5)]);

        expect(await characterService.getUnmetRequirements(character, job), isEmpty);
      });

      test('returns [Requirement.HighSchool] when all requirements are not met for HighSchool requirement', () async {
        final job = Factory.job(requirements: [Requirement.HighSchool]);
        final character = Factory.character(graduates: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.HighSchool]);
      });

      test('returns [Requirement.Supervisor3Years] when all requirements are not met for Supervisor3Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Supervisor3Years]);
        final character = Factory.character(jobHistory: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.Supervisor3Years]);
      });

      test('returns [Requirement.SubTeacher1Year] when all requirements are not met for SubTeacher1Year requirement', () async {
        final job = Factory.job(requirements: [Requirement.SubTeacher1Year]);
        final character = Factory.character(jobHistory: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.SubTeacher1Year]);
      });

      test('returns [Requirement.Teacher5Years] when all requirements are not met for Teacher5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Teacher5Years]);
        final character = Factory.character(jobHistory: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.Teacher5Years]);
      });

      test('returns [Requirement.Counselor5Years] when all requirements are not met for Counselor5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Counselor5Years]);
        final character = Factory.character(jobHistory: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.Counselor5Years]);
      });

      test('returns [Requirement.AssociateDirector5Years] when all requirements are not met for AssociateDirector5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.AssociateDirector5Years]);
        final character = Factory.character(jobHistory: []);

        expect(await characterService.getUnmetRequirements(character, job), [Requirement.AssociateDirector5Years]);
      });
    });
  });
}
