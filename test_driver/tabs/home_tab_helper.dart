import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_helper.dart';

class HomeTabHelper extends BaseViewHelper {
  final _ageButtonFinder = find.byValueKey('ageButton');
  final _homeTabFinder = find.byValueKey('bottomNavigationHome');

  HomeTabHelper(driver) : super(driver);

  Future<void> tapOnAgeButton() async {
    await driver.tap(_ageButtonFinder);
  }

  Future<void> goTo() async {
    await driver.tap(_homeTabFinder);
  }

  AgeEventElement ageEvent(String id) => AgeEventElement(driver, id);

  Future<bool> get isVisible => widgetExists(_ageButtonFinder);
}

class AgeEventElement extends BaseViewHelper {
  final String id;

  SerializableFinder get _ageEventItemFinder =>
      find.byValueKey('AgeEventItem__$id');

  SerializableFinder get _ageFinder =>
      find.byValueKey('AgeEventItem__${id}__age');

  Future<String> get age async => await driver.getText(_ageFinder);

  Future<List<String>> get events async {
    List<String> events = [];
    try {
      var index = 0;
      do {
        events.add(await driver.getText(
            find.byValueKey('AgeEventItem__${id}__events__${index++}'),
            timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return events;
  }

  AgeEventElement(driver, this.id): super(driver);

  Future<bool> get isVisible => widgetExists(_ageEventItemFinder, timeout: Duration(milliseconds: 500));
}
