import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:test_api/test_api.dart';

import '../../../helpers/factory.dart';

void main() {
  group("DisplayCharacter", () {
    test('fromCharacter generates DisplayCharacter', () async {
      var expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '2',
        'United States',
        'Baby',
        'None',
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 2)), expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '8',
        'United States',
        'Child',
        'None',
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 8)), expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '15',
        'United States',
        'Teen',
        'None',
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 15)), expectedDisplayCharacter);

      expectedDisplayCharacter = DisplayCharacter(
        'John Doe',
        'Male',
        '42',
        'United States',
        'Adult',
        'None',
      );

      expect(DisplayCharacter.fromCharacter(Factory.character(age: 42)), expectedDisplayCharacter);
    });
  });
}