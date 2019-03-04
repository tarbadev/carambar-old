import 'package:flutter_driver/flutter_driver.dart';

class HomeTab {
  final FlutterDriver driver;
  final characterNameTextFinder = find.byValueKey('characterName');
  final characterSexTextFinder = find.byValueKey('characterSex');
  final characterOriginTextFinder = find.byValueKey('characterOrigin');

  HomeTab(this.driver);

  Future<String> getCharacterName() async {
    return await driver.getText(characterNameTextFinder);
  }

  Future<String> getCharacterSex() async {
    return await driver.getText(characterSexTextFinder);
  }

  Future<String> getCharacterOrigin() async {
    return await driver.getText(characterOriginTextFinder);
  }
}