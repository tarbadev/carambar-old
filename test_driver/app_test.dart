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
      expect(await homeTab.getCharacterName(), isNotEmpty);
      expect(await homeTab.getCharacterSex(), isNotEmpty);
      expect(await homeTab.getCharacterOrigin(), isNotEmpty);
    });
  });
}
