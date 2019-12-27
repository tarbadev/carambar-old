import 'package:flutter_driver/flutter_driver.dart';

class BaseViewDriver {
  final FlutterDriver driver;
  final _availableCashKey = 'availableCash';

  BaseViewDriver(this.driver);

  Future<String> getAvailableCash() async {
    return await getTextByKey(_availableCashKey);
  }

  Future<bool> widgetExists(String key) async {
    try {
      await driver.waitFor(find.byValueKey(key), timeout: Duration(seconds: 2));

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String> getTextByKey(String key) async {
    return driver.getText(find.byValueKey(key), timeout: Duration(seconds: 2));
  }

  Future<void> tapOnButtonByKey(String key) async {
    return driver.tap(find.byValueKey(key), timeout: Duration(seconds: 2));
  }

  Future<void> tapOnButtonByText(String text) async {
    return driver.tap(find.text(text), timeout: Duration(seconds: 2));
  }
}
