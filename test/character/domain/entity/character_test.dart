import 'package:carambar/application/domain/entity/character.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('grow() adds 1 year to the current Character', () {
      expect(Factory.character(age: 0).grow(), Factory.character(age: 1));
      expect(Factory.character(age: 8).grow(), Factory.character(age: 9));
    });
  });
}