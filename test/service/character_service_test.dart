import 'package:carambar/service/character_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../factory.dart';
import '../mock_definition.dart';

void main() {
  group("CharacterService", () {
    CharacterService characterService;

    setUp(() {
      characterService = CharacterService(Mocks.characterRepository, Mocks.characterClient, Mocks.ageEventService);
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

      await characterService.incrementAge();

      character.age = 1;
      verify(Mocks.characterRepository.save(character));
    });

    test('incrementAge adds an event', () async {
      final character = Factory.character(age: 1);

      when(Mocks.characterRepository.readCharacter()).thenAnswer((_) async => character);

      await characterService.incrementAge();

      verify(Mocks.ageEventService.addEvent(2));
    });

    test('deleteCharacter calls the repository to delete the character', () async {
      await characterService.deleteCharacter();

      verify(Mocks.characterRepository.delete());
    });
  });
}
