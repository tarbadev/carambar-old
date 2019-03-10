import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tabs/home_tab.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Home Tab', () {
    HomeTab homeTab;

    setUp(() {
      homeTab = HomeTab(driver);
    });

    test('home displays the new character informations', () async {
      await driver.waitUntilNoTransientCallbacks();

      expect(await homeTab.getCharacterName(), isNotEmpty);
      expect(await homeTab.getCharacterSex(), isNotEmpty);
      expect(await homeTab.getCharacterAge(), "0");
      expect(await homeTab.getCharacterAgeCategory(), "Baby");
      expect(await homeTab.getCharacterOrigin(), isNotEmpty);
    });

    test('home displays an age button that changes the age and age category of the character', () async {
      await driver.waitUntilNoTransientCallbacks();

      expect(await homeTab.getCharacterAge(), "0");
      expect(await homeTab.getCharacterAgeCategory(), "Baby");

      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "2");
      expect(await homeTab.getCharacterAgeCategory(), "Baby");

      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "3");
      expect(await homeTab.getCharacterAgeCategory(), "Child");

      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "11");
      expect(await homeTab.getCharacterAgeCategory(), "Child");

      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "12");
      expect(await homeTab.getCharacterAgeCategory(), "Teen");

      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "17");
      expect(await homeTab.getCharacterAgeCategory(), "Teen");

      await homeTab.clickOnAgeButton();

      expect(await homeTab.getCharacterAge(), "18");
      expect(await homeTab.getCharacterAgeCategory(), "Adult");
    });
  });
}
