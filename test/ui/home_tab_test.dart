import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../factory.dart';
import '../fake_application_injector.dart';
import '../mock_definition.dart';
import 'testable_widget.dart';
import 'view/home_tab_view.dart';

void main() {
  setupTest();

  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => Factory.character());

    await tester.pumpWidget(buildTestableWidget(HomeTab()));

    expect(find.byType(CharacterInformation), findsNothing);

    await tester.pump();

    expect(find.byType(CharacterInformation), findsOneWidget);
  });

  testWidgets(
      'home shows a button Age that calls the incrementAge method from characterService',
      (WidgetTester tester) async {
    var expectedCharacter = Factory.character(age: 0);
    var homeTabView = HomeTabView(tester);

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => expectedCharacter);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    await tester.pump();

    expect(homeTabView.characterView.getCharacterAge(), "0");

    await homeTabView.clickOnAgeButton();

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => Factory.character(age: 1));
    await tester.pump();
    await tester.pump();

    expect(homeTabView.characterView.getCharacterAge(), "1");

    await homeTabView.clickOnAgeButton();

    verify(Mocks.characterService.incrementAge()).called(2);
  });
}


