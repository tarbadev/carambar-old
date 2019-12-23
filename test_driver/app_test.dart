import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tabs/character_tab_helper.dart';
import 'tabs/home_tab_helper.dart';
import 'tabs/settings_tab_helper.dart';
import 'tabs/work_tab_helper.dart';

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

  group('Init -', () {
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

        expect(await characterTab.name, isNotEmpty);
        expect(await characterTab.gender, isNotEmpty);
        expect(await characterTab.age, '0');
        expect(await characterTab.ageCategory, 'Baby');
        expect(await characterTab.origin, isNotEmpty);
        expect(await characterTab.school, 'None');
      });
    });

    group('Home Tab', () {
      test('should display an event with the generated character', () async {
        await driver.waitUntilNoTransientCallbacks();

        await characterTab.goTo();
        var characterName = await characterTab.name;
        var characterGender =
            await characterTab.gender == 'Male' ? 'boy' : 'girl';
        var characterOrigin = await characterTab.origin;
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
    });
  });

  group('Childhood -', () {
    group('Home Tab', () {
      test('should display an age button that changes the age of the character',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await characterTab.goTo();

        expect(await characterTab.age, '0');

        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await characterTab.goTo();

        expect(await characterTab.age, '1');
      });

      test(
          'should change the age and age category of the character when tapping on the age button',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        expect(await characterTab.age, '1');
        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await characterTab.goTo();

        expect(await characterTab.age, '2');
        expect(await characterTab.ageCategory, 'Baby');

        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await characterTab.goTo();

        expect(await characterTab.age, '3');
        expect(await characterTab.ageCategory, 'Child');
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
        expect(await homeTab.ageEvent('3').events,
            contains('You just started Kindergarten'));

        await characterTab.goTo();
        expect(await characterTab.school, 'Kindergarten');

        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        await driver.waitUntilNoTransientCallbacks();
        expect(await homeTab.ageEvent('6').isVisible, isTrue);
        expect(await homeTab.ageEvent('6').events,
            contains('You just started Primary School'));

        await characterTab.goTo();
        expect(await characterTab.school, 'Primary School');

        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        await driver.waitUntilNoTransientCallbacks();
        expect(await homeTab.ageEvent('11').isVisible, isTrue);
        expect(await homeTab.ageEvent('11').events,
            contains('You just started Middle School'));

        await characterTab.goTo();
        expect(await characterTab.school, 'Middle School');
      });

      test(
          'should change school when aging and add event and graduate after Middle School',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        expect(await homeTab.ageEvent('15').isVisible, isTrue);
        expect(await homeTab.ageEvent('15').events,
            contains('You graduated from Middle School'));

        await characterTab.goTo();
        expect(await characterTab.graduates, ['Middle School']);
      });
    });

    group('Work Tab', () {
      test('should display a list of jobs', () async {
        await driver.waitUntilNoTransientCallbacks();

        await workTab.goTo();

        expect(await workTab.isAvailableJobsVisible, isTrue);
        expect(await workTab.availableJobs, [
          'Supervisor',
          'Substitute Teacher',
          'Teacher',
          'Counselor',
          'Associate Director',
          'Director'
        ]);
      });

      test('should display the jobs requirements on available job tap',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await workTab.goTo();

        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Supervisor');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Supervisor');
        expect(await workTab.jobDialog.salary, '\$15,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 High School completed successfully']);

        await workTab.jobDialog.close();
        expect(await workTab.jobDialog.isVisible, isFalse);
      });

      test('should display an event when failed to apply for a job', () async {
        await driver.waitUntilNoTransientCallbacks();

        await workTab.goTo();

        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Supervisor');

        expect(await workTab.jobDialog.isVisible, isTrue);
        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('15').isVisible, isTrue);
        expect(
            await homeTab.ageEvent('15').events,
            contains(
                'You failed to apply for this new job because you don\'t meet all the requirements'));
      });
    });

    group('Home Tab', () {
      test(
          'should change school when aging and add event and graduate after High School',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        expect(await homeTab.ageEvent('15').isVisible, isTrue);
        expect(await homeTab.ageEvent('15').events,
            contains('You just started High School'));

        await characterTab.goTo();
        expect(await characterTab.school, 'High School');

        await homeTab.goTo();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        expect(await homeTab.ageEvent('18').isVisible, isTrue);
        expect(await homeTab.ageEvent('18').events,
            contains('You graduated from High School'));

        await characterTab.goTo();
        expect(await characterTab.graduates, ['Middle School', 'High School']);
      });

      test('should finish studies when aging to 18', () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        expect(await homeTab.ageEvent('18').isVisible, isTrue);
        expect(await homeTab.ageEvent('18').events,
            contains('You finished your studies'));

        await characterTab.goTo();
        expect(await characterTab.school, 'None');
      });
    });
  });

  group('Adult life -', () {
    group('Work Tab', () {
      test('should display an event when applying successfully for a job',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await workTab.goTo();

        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Supervisor');

        expect(await workTab.jobDialog.isVisible, isTrue);
        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('18').isVisible, isTrue);
        expect(await homeTab.ageEvent('18').events,
            contains('You\'re now a Supervisor'));
      });

      test('should not display popup when trying to apply for same job',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await workTab.goTo();

        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Supervisor');

        expect(await workTab.jobDialog.isVisible, isFalse);
      });
    });

    group('Character Tab', () {
      test('should display the current job and salary for Supervisor',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await characterTab.goTo();

        expect(await characterTab.job, 'Supervisor');
        expect(await characterTab.salary, '\$15,000/year');
      });
    });

    group('Home Tab', () {
      test('should update the balance when aging', () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();
        expect(await homeTab.getAvailableCash(), '\$15,000.00');
        expect(await homeTab.ageEvent('19').isVisible, isTrue);

        await homeTab.tapOnAgeButton();
        expect(await homeTab.getAvailableCash(), '\$30,000.00');
        expect(await homeTab.ageEvent('20').isVisible, isTrue);
      });
    });

    group('Character Tab', () {
      test('should display the job history', () async {
        await driver.waitUntilNoTransientCallbacks();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Supervisor');
        expect(await characterTab.jobHistory(0).experience, '2 years');
      });
    });

    group('Work Tab', () {
      test(
          'should display an event when applying successfully for a Substitute Teacher job',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Supervisor');
        expect(await characterTab.jobHistory(0).experience, '3 years');

        await workTab.goTo();
        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Substitute Teacher');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Substitute Teacher');
        expect(await workTab.jobDialog.salary, '\$18,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 Supervisor for 3+ years']);
        expect(await workTab.jobDialog.personalityTraits,
            ['\u2022 Patient', '\u2022 Benevolent']);

        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('21').isVisible, isTrue);
        expect(await homeTab.ageEvent('21').events,
            contains('You\'re now a Substitute Teacher'));

        await characterTab.goTo();

        expect(await characterTab.job, 'Substitute Teacher');
        expect(await characterTab.salary, '\$18,000/year');
      });

      test(
          'should display an event when applying successfully for a Teacher job',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Substitute Teacher');
        expect(await characterTab.jobHistory(0).experience, '1 years');

        await workTab.goTo();
        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Teacher');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Teacher');
        expect(await workTab.jobDialog.salary, '\$20,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 Substitute Teacher for 1+ years']);
        expect(await workTab.jobDialog.personalityTraits,
            ['\u2022 Patient', '\u2022 Benevolent']);

        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('22').isVisible, isTrue);
        expect(await homeTab.ageEvent('22').events,
            contains('You\'re now a Teacher'));

        await characterTab.goTo();

        expect(await characterTab.job, 'Teacher');
        expect(await characterTab.salary, '\$20,000/year');
      });

      test(
          'should display an event when applying successfully for a Counselor job',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Teacher');
        expect(await characterTab.jobHistory(0).experience, '5 years');

        await workTab.goTo();
        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Counselor');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Counselor');
        expect(await workTab.jobDialog.salary, '\$25,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 Teacher for 5+ years']);

        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('27').isVisible, isTrue);
        expect(await homeTab.ageEvent('27').events,
            contains('You\'re now a Counselor'));

        await characterTab.goTo();

        expect(await characterTab.job, 'Counselor');
        expect(await characterTab.salary, '\$25,000/year');
      });

      test(
          'should display an event when applying successfully for a Associate Director job',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Counselor');
        expect(await characterTab.jobHistory(0).experience, '5 years');

        await workTab.goTo();
        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Associate Director');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Associate Director');
        expect(await workTab.jobDialog.salary, '\$35,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 Counselor for 5+ years']);
        expect(
            await workTab.jobDialog.personalityTraits, ['\u2022 Charismatic']);

        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('32').isVisible, isTrue);
        expect(await homeTab.ageEvent('32').events,
            contains('You\'re now a Associate Director'));

        await characterTab.goTo();

        expect(await characterTab.job, 'Associate Director');
        expect(await characterTab.salary, '\$35,000/year');
      });

      test(
          'should display an event when applying successfully for a Director job',
          () async {
        await driver.waitUntilNoTransientCallbacks();
        await homeTab.goTo();

        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();
        await homeTab.tapOnAgeButton();

        await characterTab.goTo();

        expect(await characterTab.jobHistory(0).name, 'Associate Director');
        expect(await characterTab.jobHistory(0).experience, '5 years');

        await workTab.goTo();
        expect(await workTab.isAvailableJobsVisible, isTrue);

        await workTab.tapOnAvailableJob('Director');

        expect(await workTab.jobDialog.isVisible, isTrue);
        expect(await workTab.jobDialog.title, 'Director');
        expect(await workTab.jobDialog.salary, '\$50,000/year');
        expect(await workTab.jobDialog.requirements,
            ['\u2022 Associate Director for 5+ years']);
        expect(
            await workTab.jobDialog.personalityTraits, ['\u2022 Charismatic']);

        await workTab.jobDialog.apply();
        expect(await workTab.jobDialog.isVisible, isFalse);

        expect(await homeTab.isVisible, isTrue);
        expect(await homeTab.ageEvent('37').isVisible, isTrue);
        expect(await homeTab.ageEvent('37').events,
            contains('You\'re now a Director'));

        await characterTab.goTo();

        expect(await characterTab.job, 'Director');
        expect(await characterTab.salary, '\$50,000/year');
      });
    });
  });

  group('Death -', () {
    group('Settings Tab', () {
      test('should display an end life button that regenerates the character',
          () async {
        await driver.waitUntilNoTransientCallbacks();

        await characterTab.goTo();

        expect(await characterTab.age, isNot('0'));

        await settingsTab.goTo();
        await settingsTab.endLife();

        expect(await homeTab.ageEvent('37').isVisible, isFalse);
        await characterTab.goTo();

        expect(await characterTab.age, '0');
      });
    });

    group('All Tabs', () {
      test('should update the cash available', () async {
        await driver.waitUntilNoTransientCallbacks();

        await homeTab.goTo();
        expect(await homeTab.getAvailableCash(), '\$0.00');

        await characterTab.goTo();
        expect(await characterTab.getAvailableCash(), '\$0.00');

        await settingsTab.goTo();
        expect(await settingsTab.getAvailableCash(), '\$0.00');
      });
    });
  });
}
