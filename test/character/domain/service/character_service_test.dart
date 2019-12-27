import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/mock_definition.dart';

void main() {
  group('CharacterService', () {
    CharacterService characterService;

    setUp(() {
      characterService = CharacterService(Mocks.characterRepository, Mocks.characterClient);
      reset(Mocks.characterRepository);
      reset(Mocks.characterClient);
    });

    test('generateCharacter generates a new character and saves it', () async {
      final expectedCharacter = Factory.character(age: 0);

      when(Mocks.characterClient.generateCharacter()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.generateCharacter(), expectedCharacter);

      verify(Mocks.characterRepository.save(expectedCharacter));
    });

    test('getCharacter returns the existing character', () async {
      final expectedCharacter = Factory.character(age: 34);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.getCharacter(), expectedCharacter);
    });

    test('incrementAge gets the character, increments age and saves it', () async {
      final character = Factory.character(age: 0);
      final expectedCharacter = Factory.character(age: 1);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      expect(await characterService.incrementAge(), expectedCharacter);

      verify(Mocks.characterRepository.save(expectedCharacter));
    });

    test('deleteCharacter calls the repository to delete the character', () async {
      await characterService.deleteCharacter();

      verify(Mocks.characterRepository.delete());
    });

    test('addGraduate calls the repository with the character updated with the graduates', () async {
      final character = Factory.character(age: 18, graduates: [Graduate.MiddleSchool]);
      final expectedCharacter = Factory.character(age: 18, graduates: [Graduate.MiddleSchool, Graduate.HighSchool]);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      expect(await characterService.addGraduate(Graduate.HighSchool), expectedCharacter);
      verify(Mocks.characterRepository.save(expectedCharacter));
    });

    test('setJob calls the repository with the character updated with the job and new jobHistory', () async {
      final job = Factory.job();
      final currentJob = Factory.currentJob();
      final character = Factory.character(currentJob: null, jobHistory: []);
      final expectedCharacter = Factory.character(currentJob: currentJob, jobHistory: [Factory.jobExperience(experience: 0)]);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      expect(await characterService.setJob(job), expectedCharacter);

      verify(Mocks.characterRepository.save(expectedCharacter));
    });

    group('getUnmetRequirements', () {
      test('returns [] when all requirements are met for HighSchool requirement', () async {
        final job = Factory.job(requirements: [Requirement.HighSchool]);
        final character = Factory.character(graduates: [Graduate.HighSchool]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [] when all requirements are met for Supervisor3Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Supervisor3Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Supervisor', experience: 3)]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [] when all requirements are met for SubTeacher1Year requirement', () async {
        final job = Factory.job(requirements: [Requirement.SubTeacher1Year]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Substitute Teacher', experience: 1)]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [] when all requirements are met for Teacher5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Teacher5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Teacher', experience: 5)]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [] when all requirements are met for Counselor5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Counselor5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Counselor', experience: 5)]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [] when all requirements are met for AssociateDirector5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.AssociateDirector5Years]);
        final character = Factory.character(jobHistory: [Factory.jobExperience(name: 'Associate Director', experience: 5)]);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), isEmpty);
      });

      test('returns [Requirement.HighSchool] when all requirements are not met for HighSchool requirement', () async {
        final job = Factory.job(requirements: [Requirement.HighSchool]);
        final character = Factory.character(graduates: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.HighSchool]);
      });

      test('returns [Requirement.Supervisor3Years] when all requirements are not met for Supervisor3Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Supervisor3Years]);
        final character = Factory.character(jobHistory: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.Supervisor3Years]);
      });

      test('returns [Requirement.SubTeacher1Year] when all requirements are not met for SubTeacher1Year requirement', () async {
        final job = Factory.job(requirements: [Requirement.SubTeacher1Year]);
        final character = Factory.character(jobHistory: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.SubTeacher1Year]);
      });

      test('returns [Requirement.Teacher5Years] when all requirements are not met for Teacher5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Teacher5Years]);
        final character = Factory.character(jobHistory: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.Teacher5Years]);
      });

      test('returns [Requirement.Counselor5Years] when all requirements are not met for Counselor5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.Counselor5Years]);
        final character = Factory.character(jobHistory: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.Counselor5Years]);
      });

      test('returns [Requirement.AssociateDirector5Years] when all requirements are not met for AssociateDirector5Years requirement', () async {
        final job = Factory.job(requirements: [Requirement.AssociateDirector5Years]);
        final character = Factory.character(jobHistory: []);

        when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

        expect(await characterService.getUnmetRequirements(job), [Requirement.AssociateDirector5Years]);
      });
    });

    test('incrementJobExperience returns false when all requirements are not met', () async {
      final character = Factory.character(jobHistory: [Factory.jobExperience(experience: 4)]);
      final expectedCharacter = Factory.character(jobHistory: [Factory.jobExperience(experience: 5)]);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      expect(await characterService.incrementJobExperience(), expectedCharacter);
    });
  });
}
