import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_helper.dart';

class CharacterTabHelper extends BaseViewHelper {
  final _characterTabFinder = find.byValueKey('bottomNavigationCharacter');
  final _characterNameTextFinder = find.byValueKey('characterName');
  final _characterGenderTextFinder = find.byValueKey('characterGender');
  final _characterAgeTextFinder = find.byValueKey('characterAge');
  final _characterAgeCategoryTextFinder = find.byValueKey('characterAgeCategory');
  final _characterOriginTextFinder = find.byValueKey('characterOrigin');
  final _characterSchoolTextFinder = find.byValueKey('characterSchool');

  CharacterTabHelper(driver) : super(driver);

  Future<String> getCharacterName() async {
    return await driver.getText(_characterNameTextFinder);
  }

  Future<String> getCharacterGender() async {
    return await driver.getText(_characterGenderTextFinder);
  }

  Future<String> getCharacterOrigin() async {
    return await driver.getText(_characterOriginTextFinder);
  }

  Future<String> getCharacterAge() async {
    return await driver.getText(_characterAgeTextFinder);
  }

  Future<String> getCharacterAgeCategory() async {
    return await driver.getText(_characterAgeCategoryTextFinder);
  }

  Future<String> getCharacterSchool() async {
    return await driver.getText(_characterSchoolTextFinder);
  }

  Future<List<String>> getCharacterGraduates() async {
    List<String> graduates = [];
    try {
      var index = 0;
      do {
        graduates.add(await driver.getText(
            find.byValueKey('Character__graduates__${index++}'),
            timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return graduates;
  }

  Future<void> goTo() async {
    await driver.tap(_characterTabFinder);
  }
}