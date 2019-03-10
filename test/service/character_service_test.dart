import 'package:carambar/service/character_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../factory.dart';
import '../mock_definition.dart';

void main() {
  group("CharacterService", () {
    CharacterService characterService;

    setUp(() {
      characterService = CharacterService(Mocks.characterRepository, Mocks.characterClient);
      reset(Mocks.characterRepository);
      reset(Mocks.characterClient);
    });

    test('getCharacter generates a new character and saves it', () async {
      final expectedCharacter = Factory.character(age: 0);

      when(Mocks.characterClient.generateCharacter()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.getCharacter(), expectedCharacter);

      verify(Mocks.characterRepository.save(expectedCharacter));
    });

    test('getCharacter returns the existing character', () async {
      final expectedCharacter = Factory.character(age: 34);

      when(Mocks.characterRepository.read()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.getCharacter(), expectedCharacter);

      verifyNever(Mocks.characterRepository.save(expectedCharacter));
      verifyNever(Mocks.characterClient.generateCharacter());
    });

    test('incrementAge gets the character, increments age and saves it', () async {
      final character = Factory.character(age: 0);
      character.age = 1;

      when(Mocks.characterRepository.read()).thenAnswer((_) async => character);

      await characterService.incrementAge();

      verify(Mocks.characterRepository.save(character));
    });
  });
}