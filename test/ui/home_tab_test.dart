import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../factory.dart';
import '../fake_application_injector.dart';
import '../helpers/testable_widget.dart';
import '../helpers/view/home_tab_view.dart';
import '../mock_definition.dart';

void main() {
  setupTest();

  testWidgets(
      'home shows a button Age that calls the incrementAge method from characterService',
      (WidgetTester tester) async {
    var expectedCharacter = Factory.character(age: 0);
    var homeTabView = HomeTabView(tester);

    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => expectedCharacter);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));

    await homeTabView.clickOnAgeButton();
    await homeTabView.clickOnAgeButton();

    verify(Mocks.characterService.incrementAge()).called(2);
  });

  testWidgets('home shows a list of events from the EventService',
      (WidgetTester tester) async {
    List<AgeEvent> expectedAgeEvents = [Factory.ageEvent(age: 0), Factory.ageEvent(age: 1)];

    when(Mocks.ageEventService.getAgeEvents()).thenAnswer((_) async => expectedAgeEvents);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    var eventListFinder = find.byType(AgeEventList);
    expect(eventListFinder, findsNothing);

    await tester.pump();

    verify(Mocks.ageEventService.getAgeEvents());

    expect(eventListFinder, findsOneWidget);

    AgeEventList eventList = eventListFinder.evaluate().single.widget;
    expect(eventList.ageEvents, expectedAgeEvents);
  });
}
