import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../factory.dart';
import '../../mock_definition.dart';

void main() {
  group("Character Presenter", () {
    var characterPresenter;

    setUp(() {
      characterPresenter =
          CharacterPresenter(Mocks.characterService, Mocks.ageEventService);
    });

    test('getDisplayCharacter returns the DisplayCharacter from the character',
        () async {
      var expectedDisplayCharacter = Factory.displayCharacter();

      when(Mocks.characterService.getCharacter())
          .thenAnswer((_) async => Factory.character());

      expect(await characterPresenter.getDisplayCharacter(),
          expectedDisplayCharacter);
    });

    test(
        'getDisplayCharacter generates a new character if none exist and returns the DisplayCharacter',
        () async {
      var expectedDisplayCharacter =
          Factory.displayCharacter(age: "0", ageCategory: 'Baby');

      when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
      when(Mocks.characterService.generateCharacter())
          .thenAnswer((_) async => Factory.character(age: 0));

      expect(await characterPresenter.getDisplayCharacter(),
          expectedDisplayCharacter);
    });

    test('getDisplayCharacter generates a new character and adds a new event',
        () async {
      var character = Factory.character(age: 0);
      var expectedDisplayCharacter =
          Factory.displayCharacter(age: "0", ageCategory: 'Baby');
      var expectedEvent = """
        You just started your life!
        You're a baby boy named John Doe from United States
      """
          .trim();

      when(Mocks.characterService.getCharacter()).thenAnswer((_) async => null);
      when(Mocks.characterService.generateCharacter())
          .thenAnswer((_) async => character);

      expect(await characterPresenter.getDisplayCharacter(),
          expectedDisplayCharacter);

      verify(
          Mocks.ageEventService.addEvent(character.age, event: expectedEvent));
    });

    test('incrementAge calls CharacterService', () async {
      await characterPresenter.incrementAge();

      verify(Mocks.characterService.incrementAge());
    });
  });
}
