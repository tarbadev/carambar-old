import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:test_api/test_api.dart';

import '../../factory.dart';

void main() {
  group("CharacterPresenter", () {
    test('fromCharacter generates CharacterPresenter', () async {
      var expectedCharacterPresenter = CharacterPresenter(
        'John Doe',
        'Male',
        '2',
        'United States',
        'Baby',
      );

      expect(CharacterPresenter.fromCharacter(Factory.character(age: 2)), expectedCharacterPresenter);

      expectedCharacterPresenter = CharacterPresenter(
        'John Doe',
        'Male',
        '8',
        'United States',
        'Child',
      );

      expect(CharacterPresenter.fromCharacter(Factory.character(age: 8)), expectedCharacterPresenter);

      expectedCharacterPresenter = CharacterPresenter(
        'John Doe',
        'Male',
        '15',
        'United States',
        'Teen',
      );

      expect(CharacterPresenter.fromCharacter(Factory.character(age: 15)), expectedCharacterPresenter);

      expectedCharacterPresenter = CharacterPresenter(
        'John Doe',
        'Male',
        '42',
        'United States',
        'Adult',
      );

      expect(CharacterPresenter.fromCharacter(Factory.character(age: 42)), expectedCharacterPresenter);
    });
  });
}