

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';
import 'character_information_view.dart';

class HomeTabView extends BaseView {
  CharacterInformationView characterView;
  final WidgetTester tester;

  HomeTabView(this.tester) : super(tester) {
    characterView = CharacterInformationView(tester);
  }

  Future<void> clickOnAgeButton() async {
    await tester.tap(find.byKey(Key("ageButton")));
  }
}