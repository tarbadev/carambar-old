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

  testWidgets('home shows a button Display that displays "Hello!"',
      (WidgetTester tester) async {
    var expectedCharacter = Factory.character();
    var homeTabView = _HomeTabView(tester);

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => expectedCharacter);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    await tester.pump();

    expect(homeTabView.getCharacterName(),
        "${StringUtils.capitalize(expectedCharacter.firstName)} ${StringUtils.capitalize(expectedCharacter.lastName)}");
    expect(homeTabView.getCharacterSex(), "${StringUtils.capitalize(expectedCharacter.sex)}");
    expect(homeTabView.getCharacterOrigin(), "${StringUtils.capitalize(expectedCharacter.origin)}");
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

  String getDataFromTextByKey(String key) {
    var textFinder = find.byKey(Key(key));
    expect(textFinder, findsOneWidget);

    Text text = tester.widget(textFinder);
    return text.data;
  }
}

Widget buildTestableWidget(Widget widget) {
  return new MediaQuery(
      data: new MediaQueryData(), child: new MaterialApp(home: widget));
}
