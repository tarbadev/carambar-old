import 'base_view_driver.dart';

class HomeTabHelper extends BaseViewDriver {
  HomeTabHelper(driver) : super(driver);

  Future<bool> get isVisible => widgetExists('Home__AgeButton');

  Future<void> tapOnAgeButton() async {
    await tapOnButtonByKey('Home__AgeButton');
  }

  Future<void> goTo() async {
    await tapOnButtonByKey('Home__BottomNavigationHome');
  }

  AgeEventElement ageEvent(String id) => AgeEventElement(driver, id);
}

class AgeEventElement extends BaseViewDriver {
  final String id;

  AgeEventElement(driver, this.id) : super(driver);

  Future<bool> get isVisible => widgetExists('AgeEventItem__$id');

  Future<String> get age async => await getTextByKey('AgeEventItem__${id}__age');

  Future<List<String>> get events async {
    List<String> events = [];
    try {
      var index = 0;
      do {
        events.add(await getTextByKey('AgeEventItem__${id}__events__${index++}'));
      } while (true);
    } catch (_) {}

    return events;
  }
}
