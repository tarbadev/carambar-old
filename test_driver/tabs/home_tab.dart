import 'package:flutter_driver/flutter_driver.dart';

class HomeTab {
  final FlutterDriver driver;
  final ageButtonFinder = find.byValueKey('ageButton');
  final homeTabFinder = find.byValueKey('bottomNavigationHome');

  HomeTab(this.driver);

  Future<void> clickOnAgeButton() async {
    await driver.tap(ageButtonFinder);
  }

  Future<void> goTo() async {
    await driver.tap(homeTabFinder);
  }
}