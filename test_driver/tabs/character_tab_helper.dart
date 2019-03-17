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

  Future<String> get name async => await driver.getText(_characterNameTextFinder);
  Future<String> get gender async => await driver.getText(_characterGenderTextFinder);
  Future<String> get origin async => await driver.getText(_characterOriginTextFinder);
  Future<String> get age async => await driver.getText(_characterAgeTextFinder);
  Future<String> get ageCategory async => await driver.getText(_characterAgeCategoryTextFinder);
  Future<String> get school async => await driver.getText(_characterSchoolTextFinder);
  Future<List<String>> get graduates async {
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