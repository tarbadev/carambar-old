import 'package:flutter_driver/flutter_driver.dart';

class BaseTab {
  final FlutterDriver driver;
  final _availableCashFinder = find.byValueKey('availableCash');

  BaseTab(this.driver);
  
  Future<String> getAvailableCash() async {
    return await driver.getText(_availableCashFinder);
  }
}