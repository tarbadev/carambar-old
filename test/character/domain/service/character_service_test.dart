import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

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

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      character.age = 1;

      expect(await characterService.incrementAge(), character);
      verify(Mocks.characterRepository.save(character));
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

    test('setJob calls the repository with the character updated with the job', () async {
      final job = Factory.job();
      final character = Factory.character(job: null);
      final expectedCharacter = Factory.character(job: job);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      expect(await characterService.setJob(job), expectedCharacter);

      verify(Mocks.characterRepository.save(expectedCharacter));
    });
  });
}
