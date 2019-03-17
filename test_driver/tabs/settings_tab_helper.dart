import 'package:flutter_driver/flutter_driver.dart';

import 'base_tab_helper.dart';

class SettingsTab extends BaseTab {
  final _settingsTabFinder = find.byValueKey('bottomNavigationSettings');
  final _endLifeButton = find.byValueKey('endLifeButton');
  final _endLifeConfirmButton = find.byValueKey('endLifeConfirmButton');

  SettingsTab(driver) : super(driver);

  Future<void> endLife() async {
    await driver.tap(_endLifeButton);
    await driver.tap(_endLifeConfirmButton);
  }

  Future<void> goTo() async {
    await driver.tap(_settingsTabFinder);
  }
}