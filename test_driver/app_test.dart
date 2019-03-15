import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tabs/character_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/settings_tab.dart';

void main() {
  FlutterDriver driver;
  HomeTab homeTab;
  CharacterTab characterTab;
  SettingsTab settingsTab;

  setUp(() {
    homeTab = HomeTab(driver);
    characterTab = CharacterTab(driver);
    settingsTab = SettingsTab(driver);
  });

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Character Tab', () {
    test('should display the generated character informations', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterName(), isNotEmpty);
      expect(await characterTab.getCharacterGender(), isNotEmpty);
      expect(await characterTab.getCharacterAge(), "0");
      expect(await characterTab.getCharacterAgeCategory(), "Baby");
      expect(await characterTab.getCharacterOrigin(), isNotEmpty);
    });
  });

  group('Home Tab', () {
    test('should display an event with the generated character', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();
      var characterName = await characterTab.getCharacterName();
      var characterGender = await characterTab.getCharacterGender() == 'Male' ? 'boy' : 'girl';
      var characterOrigin = await characterTab.getCharacterOrigin();
      var expectedEvents = [
        'You just started your life!',
        'You\'re a baby $characterGender named $characterName from $characterOrigin'
      ];

      await homeTab.goTo();

      var ageEventView = homeTab.ageEvent('0');
      expect(await ageEventView.isVisible, isTrue);
      expect(await ageEventView.age, 'Age 0');
      expect(await ageEventView.events, expectedEvents);
    });

    test('should display an age button that changes the age of the character', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "0");

      await homeTab.goTo();
      await homeTab.clickOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "1");
    });

    test('should change the age and age category of the character when tapping on the age button', () async {
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

  group('Settings Tab', () {
    test('should display an end life button that regenerates the character', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "3");

      await settingsTab.goTo();
      await settingsTab.endLife();

      expect(await homeTab.isVisible, isTrue);
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), "0");
    });
  });
}
