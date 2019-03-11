import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../factory.dart';
import '../../mock_definition.dart';

void main() {
  group("Character Presenter", () {
    var characterPresenter;

    setUp(() {
      characterPresenter = CharacterPresenter(Mocks.characterService);
    });

    test('getDisplayCharacter returns the DisplayCharacter from the character', () async {
      var expectedDisplayCharacter = Factory.displayCharacter();

      when(Mocks.characterService.getCharacter()).thenAnswer((_) async => Factory.character());

      expect(await characterPresenter.getDisplayCharacter(), expectedDisplayCharacter);
    });

    test('incrementAge calls CharacterService', () async {
      await characterPresenter.incrementAge();

      verify(Mocks.characterService.incrementAge());
    });
  });
}