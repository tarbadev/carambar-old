import 'package:flutter_driver/flutter_driver.dart';

class BaseViewDriver {
  final FlutterDriver driver;
  final _availableCashFinder = find.byValueKey('availableCash');

  BaseViewDriver(this.driver);

  Future<String> getAvailableCash() async {
    return await driver.getText(_availableCashFinder);
  }

  Future<bool> widgetExists(String key) async {
    try {
      await driver.waitFor(find.byValueKey(key), timeout: const Duration(milliseconds: 500));

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String> getTextByKey(String key, {Duration timeout}) async {
    return driver.getText(find.byValueKey(key), timeout: timeout);
  }

  Future<void> tapOnButtonByKey(String key) async {
    return driver.tap(find.byValueKey(key));
  }

  Future<void> tapOnButtonByText(String text) async {
    return driver.tap(find.text(text));
  }
}
