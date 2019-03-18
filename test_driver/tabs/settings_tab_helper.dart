import 'base_view_driver.dart';

class SettingsTabHelper extends BaseViewDriver {
  SettingsTabHelper(driver) : super(driver);

  Future<void> endLife() async {
    await tapOnButtonByKey('Settings__EndLifeButton');
    await tapOnButtonByKey('EndLifeDialog__ConfirmButton');
  }

  Future<void> goTo() async {
    await tapOnButtonByKey('Home__BottomNavigationSettings');
  }
}