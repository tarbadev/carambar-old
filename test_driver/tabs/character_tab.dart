import 'package:flutter_driver/flutter_driver.dart';

class CharacterTab {
  final FlutterDriver driver;
  final characterTabFinder = find.byValueKey('bottomNavigationCharacter');
  final characterNameTextFinder = find.byValueKey('characterName');
  final characterSexTextFinder = find.byValueKey('characterSex');
  final characterAgeTextFinder = find.byValueKey('characterAge');
  final characterAgeCategoryTextFinder = find.byValueKey('characterAgeCategory');
  final characterOriginTextFinder = find.byValueKey('characterOrigin');

  CharacterTab(this.driver);

  Future<String> getCharacterName() async {
    return await driver.getText(characterNameTextFinder);
  }

  Future<String> getCharacterSex() async {
    return await driver.getText(characterSexTextFinder);
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

  Future<void> goTo() async {
    await driver.tap(characterTabFinder);
  }
}