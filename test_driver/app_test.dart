import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tabs/character_tab_helper.dart';
import 'tabs/home_tab_helper.dart';
import 'tabs/work_tab_helper.dart';
import 'tabs/settings_tab_helper.dart';

void main() {
  FlutterDriver driver;
  HomeTabHelper homeTab;
  CharacterTabHelper characterTab;
  WorkTabHelper workTab;
  SettingsTabHelper settingsTab;

  setUp(() {
    homeTab = HomeTabHelper(driver);
    characterTab = CharacterTabHelper(driver);
    workTab = WorkTabHelper(driver);
    settingsTab = SettingsTabHelper(driver);
  });

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('All Tabs', () {
    test('should display the cash available', () async {
      await driver.waitUntilNoTransientCallbacks();

      await homeTab.goTo();
      expect(await homeTab.getAvailableCash(), '\$0.00');

      await characterTab.goTo();
      expect(await characterTab.getAvailableCash(), '\$0.00');

      await settingsTab.goTo();
      expect(await settingsTab.getAvailableCash(), '\$0.00');
    });
  });

  group('Character Tab', () {
    test('should display the generated character informations', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterName(), isNotEmpty);
      expect(await characterTab.getCharacterGender(), isNotEmpty);
      expect(await characterTab.getCharacterAge(), '0');
      expect(await characterTab.getCharacterAgeCategory(), 'Baby');
      expect(await characterTab.getCharacterOrigin(), isNotEmpty);
      expect(await characterTab.getCharacterSchool(), 'None');
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

      expect(await characterTab.getCharacterAge(), '0');

      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), '1');
    });

    test('should change the age and age category of the character when tapping on the age button', () async {
      await driver.waitUntilNoTransientCallbacks();

      expect(await characterTab.getCharacterAge(), '1');
      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), '2');
      expect(await characterTab.getCharacterAgeCategory(), 'Baby');

      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), '3');
      expect(await characterTab.getCharacterAgeCategory(), 'Child');
    });

    test('should add an event when tapping on the age button', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      expect(await homeTab.ageEvent('3').isVisible, isTrue);
      expect(await homeTab.ageEvent('3').age, 'Age 3');
    });

    test('should change school when aging and add event', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      expect(await homeTab.ageEvent('3').isVisible, isTrue);
      expect(await homeTab.ageEvent('3').events, contains('You just started Kindergarten'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterSchool(), 'Kindergarten');

      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();

      expect(await homeTab.ageEvent('6').isVisible, isTrue);
      expect(await homeTab.ageEvent('6').events, contains('You just started Primary School'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterSchool(), 'Primary School');

      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();

      expect(await homeTab.ageEvent('11').isVisible, isTrue);
      expect(await homeTab.ageEvent('11').events, contains('You just started Middle School'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterSchool(), 'Middle School');
    });

    test('should change school when aging and add event and graduate after Middle School', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();

      expect(await homeTab.ageEvent('15').isVisible, isTrue);
      expect(await homeTab.ageEvent('15').events, contains('You graduated from Middle School'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterGraduates(), ['Middle School']);
    });

    test('should change school when aging and add event and graduate after High School', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      expect(await homeTab.ageEvent('15').isVisible, isTrue);
      expect(await homeTab.ageEvent('15').events, contains('You just started High School'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterSchool(), 'High School');

      await homeTab.goTo();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();
      await homeTab.tapOnAgeButton();

      expect(await homeTab.ageEvent('18').isVisible, isTrue);
      expect(await homeTab.ageEvent('18').events, contains('You graduated from High School'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterGraduates(), ['Middle School', 'High School']);
    });

    test('should finish studies when aging to 18', () async {
      await driver.waitUntilNoTransientCallbacks();
      await homeTab.goTo();

      expect(await homeTab.ageEvent('18').isVisible, isTrue);
      expect(await homeTab.ageEvent('18').events, contains('You finished your studies'));

      await characterTab.goTo();
      expect(await characterTab.getCharacterSchool(), 'None');
    });
  });

  group('Jobs Tab', () {
    test('should display a list of tabs', () async {
      await driver.waitUntilNoTransientCallbacks();

      await workTab.goTo();

      expect(await workTab.isAvailableJobsVisible, isTrue);
      expect(await workTab.getAvailableJobs(), ['Supervisor']);
    });

    test('should display the jobs requirements on available job tap', () async {
      await driver.waitUntilNoTransientCallbacks();

      await workTab.goTo();

      expect(await workTab.isAvailableJobsVisible, isTrue);

      await workTab.tapOnAvailableJob('Supervisor');

      expect(await workTab.jobDialog.isVisible, isTrue);
      expect(await workTab.jobDialog.title, 'Supervisor');
      expect(await workTab.jobDialog.requirements, 'High School completed successfully');

      await workTab.jobDialog.close();
      expect(await workTab.jobDialog.isVisible, isFalse);
    });
  });

  group('Settings Tab', () {
    test('should display an end life button that regenerates the character', () async {
      await driver.waitUntilNoTransientCallbacks();

      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), isNot('0'));

      await settingsTab.goTo();
      await settingsTab.endLife();

      expect(await homeTab.ageEvent('18').isVisible, isFalse);
      await characterTab.goTo();

      expect(await characterTab.getCharacterAge(), '0');
    });
  });
}
