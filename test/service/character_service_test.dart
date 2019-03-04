import 'package:carambar/service/character_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../factory.dart';
import '../mock_definition.dart';

void main() {
  group("CharacterService", () {
    CharacterService characterService;

    setUp(() {
      characterService = CharacterService(Mocks.internalFileRepository, Mocks.characterClient);
    });

    test('getCharacter generates a new character and saves it', () async {
      final expectedCharacter = Factory.character(age: 0);

      when(Mocks.characterClient.generateCharacter()).thenAnswer((_) async => expectedCharacter);

      expect(await characterService.getCharacter(), expectedCharacter);

      verify(Mocks.internalFileRepository.save(expectedCharacter));
    });
  });
}
