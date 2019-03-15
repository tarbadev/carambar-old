import 'package:carambar/character/domain/entity/character.dart';
import 'package:test_core/test_core.dart';

import '../../../helpers/factory.dart';

void main() {
  group('Character', () {
    test('ageCategory changes depending on the age', () {
      expect(Factory.character(age: 0).ageCategory, AgeCategory.baby);
      expect(Factory.character(age: 2).ageCategory, AgeCategory.baby);

      expect(Factory.character(age: 3).ageCategory, AgeCategory.child);
      expect(Factory.character(age: 11).ageCategory, AgeCategory.child);

      expect(Factory.character(age: 12).ageCategory, AgeCategory.teen);
      expect(Factory.character(age: 17).ageCategory, AgeCategory.teen);

      expect(Factory.character(age: 18).ageCategory, AgeCategory.adult);
    });
  });
}