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

  group('Character Tab', () {
    CharacterTab characterTab;

    setUp(() {
      characterTab = CharacterTab(driver);
    });

    test('should display the generated character informations', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterName(), isNotEmpty);
      expect(await characterTab.getCharacterSex(), isNotEmpty);
      expect(await characterTab.getCharacterAge(), "0");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");
      expect(await characterTab.getCharacterOrigin(), isNotEmpty);
    });
  });

  group('Home Tab', () {
    HomeTab homeTab;
    CharacterTab characterTab;

    setUp(() {
      homeTab = HomeTab(driver);
      characterTab = CharacterTab(driver);
    });

    test('should display an age button that changes the age of the character',
        () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "0");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "1");
    });

    test(
        'should change the age and age category of the character when tapping on the age button',
        () async {
      await driver.waitUntilNoTransientCallbacks();

      expect(await characterTab.getCharacterAge(), "1");
      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "2");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "3");
      expect(await characterTab.getCharacterAgeCategory(), "Child");
    });

    test('should add an event when tapping on the age button', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      expect(await homeTab.ageEvent('3').isVisible, isTrue);
      expect(await homeTab.ageEvent('3').age, 'Age 3');
    });
  });
}
