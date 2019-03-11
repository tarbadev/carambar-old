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

  AgeEventElement ageEvent(String id) => AgeEventElement(driver, id);
}

class AgeEventElement {
  final FlutterDriver driver;
  final String id;
  
  SerializableFinder get _ageEventItemFinder => find.byValueKey('AgeEventItem__$id');
  SerializableFinder get _ageFinder => find.byValueKey('AgeEventItem__${id}__age');
  SerializableFinder get _eventsFinder => find.byValueKey('AgeEventItem__${id}__events');

  Future<String> get age async => await driver.getText(_ageFinder);
  Future<String> get events async => await driver.getText(_eventsFinder);

  AgeEventElement(this.driver, this.id);

  Future<bool> get isVisible => widgetExists(driver, _ageEventItemFinder);
}

Future<bool> widgetExists(
    FlutterDriver driver,
    SerializableFinder finder, {
      Duration timeout,
    }) async {
  try {
    await driver.waitFor(finder, timeout: timeout);

    return true;
  } catch (_) {
    return false;
  }
}