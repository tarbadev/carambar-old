import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/src/widget_tester.dart';

import 'base_view_tester.dart';

class CarambarAppView extends BaseViewTester {
  CarambarAppView(WidgetTester tester) : super(tester);

  Finder get _homeTabFinder => find.byKey(Key('Home__BottomNavigationHome'));
  Finder get _characterTabFinder => find.byKey(Key('Home__BottomNavigationCharacter'));
  Finder get _workTabFinder => find.byKey(Key('Home__BottomNavigationWork'));
  Finder get _settingsTabFinder => find.byKey(Key('Home__BottomNavigationSettings'));

  Future<void> tapOnHomeTab() async => await tester.tap(_homeTabFinder);
  Future<void> tapOnCharacterTab() async => await tester.tap(_characterTabFinder);
  Future<void> tapOnWorkTab() async => await tester.tap(_workTabFinder);
  Future<void> tapOnSettingsTab() async => await tester.tap(_settingsTabFinder);

  String getAvailableCash() {
    return getTextByKey('availableCash');
  }
}