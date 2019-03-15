import 'package:flutter_driver/flutter_driver.dart';

class SettingsTab {
  final FlutterDriver _driver;
  final _settingsTabFinder = find.byValueKey('bottomNavigationSettings');
  final _endLifeButton = find.byValueKey('endLifeButton');
  final _endLifeConfirmButton = find.byValueKey('endLifeConfirmButton');

  SettingsTab(this._driver);

  Future<void> endLife() async {
    await _driver.tap(_endLifeButton);
    await _driver.tap(_endLifeConfirmButton);
  }

  Future<void> goTo() async {
    await _driver.tap(_settingsTabFinder);
  }
}