import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../factory.dart';
import '../fake_application_injector.dart';
import '../mock_definition.dart';

void main() {
  setupTest();

  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    var expectedCharacter = Factory.character();
    var homeTabView = _HomeTabView(tester);

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => expectedCharacter);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    await tester.pump();

    expect(homeTabView.getCharacterName(),
        "${StringUtils.capitalize(expectedCharacter.firstName)} ${StringUtils.capitalize(expectedCharacter.lastName)}");
    expect(homeTabView.getCharacterSex(),
        "${StringUtils.capitalize(expectedCharacter.sex)}");
    expect(homeTabView.getCharacterOrigin(),
        "${StringUtils.capitalize(expectedCharacter.origin)}");
    expect(homeTabView.getCharacterAge(), "${expectedCharacter.age}");
  });

  testWidgets(
      'home shows a button Age that calls the incrementAge method from characterService',
      (WidgetTester tester) async {
    var expectedCharacter = Factory.character(age: 0);
    var homeTabView = _HomeTabView(tester);

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => expectedCharacter);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    await tester.pump();

    expect(homeTabView.getCharacterAge(), "0");

    await homeTabView.clickOnAgeButton();

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => Factory.character(age: 1));
    await tester.pump();
    await tester.pump();

    expect(homeTabView.getCharacterAge(), "1");

    await homeTabView.clickOnAgeButton();

    verify(Mocks.characterService.incrementAge()).called(2);
  });
}

class _HomeTabView {
  _HomeTabView(this.tester);

  final WidgetTester tester;

  String getCharacterName() {
    return getDataFromTextByKey("characterName");
  }

  String getCharacterSex() {
    return getDataFromTextByKey("characterSex");
  }

  String getCharacterOrigin() {
    return getDataFromTextByKey("characterOrigin");
  }

  String getCharacterAge() {
    return getDataFromTextByKey("characterAge");
  }

  Future<void> clickOnAgeButton() async {
    await tester.tap(find.byKey(Key("ageButton")));
  }

  String getDataFromTextByKey(String key) {
    var textFinder = find.byKey(Key(key));
    expect(textFinder, findsOneWidget);

    Text text = tester.widget(textFinder);
    return text.data;
  }
}

Widget buildTestableWidget(Widget widget) {
  return new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: widget),
  );
}
