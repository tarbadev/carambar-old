import 'package:flutter_driver/flutter_driver.dart';

class BaseTabHelper {
  final FlutterDriver driver;
  final _availableCashFinder = find.byValueKey('availableCash');

  BaseTabHelper(this.driver);
  
  Future<String> getAvailableCash() async {
    return await driver.getText(_availableCashFinder);
  }
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