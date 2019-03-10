import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tabs/character_tab.dart';
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
    CharacterTab characterTab;

    setUp(() {
      homeTab = HomeTab(driver);
      characterTab = CharacterTab(driver);
    });

    test('character tab displays the new character informations', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterName(), isNotEmpty);
      expect(await characterTab.getCharacterSex(), isNotEmpty);
      expect(await characterTab.getCharacterAge(), "0");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");
      expect(await characterTab.getCharacterOrigin(), isNotEmpty);
    });

    test('home displays an age button that changes the age and age category of the character', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "0");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "2");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "3");
      expect(await characterTab.getCharacterAgeCategory(), "Child");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "11");
      expect(await characterTab.getCharacterAgeCategory(), "Child");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "12");
      expect(await characterTab.getCharacterAgeCategory(), "Teen");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "17");
      expect(await characterTab.getCharacterAgeCategory(), "Teen");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "18");
      expect(await characterTab.getCharacterAgeCategory(), "Adult");
    });
  });
}
