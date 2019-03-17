import 'package:flutter_driver/flutter_driver.dart';

import 'base_view_driver.dart';

class HomeTabHelper extends BaseViewDriver {
  final _ageButtonFinder = find.byValueKey('ageButton');
  final _homeTabFinder = find.byValueKey('bottomNavigationHome');

  HomeTabHelper(driver): super(driver);

  Future<bool> get isVisible => widgetExists('ageButton');

  Future<void> tapOnAgeButton() async {
    await driver.tap(_ageButtonFinder);
  }

  Future<void> goTo() async {
    await driver.tap(_homeTabFinder);
  }

  AgeEventElement ageEvent(String id) => AgeEventElement(driver, id);
}

class AgeEventElement extends BaseViewDriver {
  final String id;

  AgeEventElement(driver, this.id): super(driver);

  Future<bool> get isVisible => widgetExists('AgeEventItem__$id');
  Future<String> get age async => await getTextByKey('AgeEventItem__${id}__age');
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
}
