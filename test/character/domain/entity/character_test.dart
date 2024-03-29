import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
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

    test('fromInitiateEvent', () {
      final initiateEvent = InitiateEvent(
        0,
        'firstName',
        'lastName',
        'gender',
        Nationality.france,
      );
      final character = Character(
        age: 0,
        firstName: 'firstName',
        lastName: 'lastName',
        gender: 'gender',
        origin: Nationality.france,
        graduates: [],
        jobHistory: [],
      );

      expect(Character.fromInitiateEvent(initiateEvent), character);
    });
  });
}
