import 'package:flutter_driver/flutter_driver.dart';

class CharacterTab {
  final FlutterDriver driver;
  final characterTabFinder = find.byValueKey('bottomNavigationCharacter');
  final characterNameTextFinder = find.byValueKey('characterName');
  final characterGenderTextFinder = find.byValueKey('characterGender');
  final characterAgeTextFinder = find.byValueKey('characterAge');
  final characterAgeCategoryTextFinder = find.byValueKey('characterAgeCategory');
  final characterOriginTextFinder = find.byValueKey('characterOrigin');
  final characterSchoolTextFinder = find.byValueKey('characterSchool');

  CharacterTab(this.driver);

  Future<String> getCharacterName() async {
    return await driver.getText(characterNameTextFinder);
  }

  Future<String> getCharacterGender() async {
    return await driver.getText(characterGenderTextFinder);
  }

  Future<String> getCharacterOrigin() async {
    return await driver.getText(characterOriginTextFinder);
  }

  Future<String> getCharacterAge() async {
    return await driver.getText(characterAgeTextFinder);
  }

  Future<String> getCharacterAgeCategory() async {
    return await driver.getText(characterAgeCategoryTextFinder);
  }

  Future<String> getCharacterSchool() async {
    return await driver.getText(characterSchoolTextFinder);
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
    await driver.tap(characterTabFinder);
  }
}