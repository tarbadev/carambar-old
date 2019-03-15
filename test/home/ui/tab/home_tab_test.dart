import 'package:carambar/home/domain/entity/age_event.dart';
import 'package:carambar/home/ui/tab/home_tab.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/widget/age_event_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/fake_application_injector.dart';
import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/home_tab_view.dart';

void main() {
  setupDependencyInjectorForTest();

  testWidgets('home shows a button Age that calls the incrementAge method from characterService',
      (WidgetTester tester) async {
    var homeTabView = HomeTabView(tester);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));

    when(Mocks.characterService.incrementAge()).thenAnswer((_) async => Factory.character(age: 19));
    when(Mocks.ageEventService.addEvent(19)).thenAnswer((_) async => [Factory.ageEvent(age: 19)]);
    await homeTabView.clickOnAgeButton();

    when(Mocks.characterService.incrementAge()).thenAnswer((_) async => Factory.character(age: 20));
    when(Mocks.ageEventService.addEvent(20))
        .thenAnswer((_) async => [Factory.ageEvent(age: 19), Factory.ageEvent(age: 20)]);
    await homeTabView.clickOnAgeButton();
  });

  testWidgets('home shows a list of events from the EventService', (WidgetTester tester) async {
    List<AgeEvent> ageEvents = [Factory.ageEvent(age: 0), Factory.ageEvent(age: 1)];
    List<DisplayAgeEvent> expectedDisplayAgeEvents = [
      Factory.displayAgeEvent(id: 0, age: "Age 0"),
      Factory.displayAgeEvent(id: 1, age: "Age 1")
    ];

    await tester.pumpWidget(buildTestableWidget(HomeTab(), ageEvents: ageEvents));

    var eventListFinder = find.byType(AgeEventList);
    expect(eventListFinder, findsNothing);

    await tester.pump();

    verify(Mocks.ageEventService.getAgeEvents());

    expect(eventListFinder, findsOneWidget);

    AgeEventList eventList = eventListFinder.evaluate().single.widget;
    expect(eventList.displayAgeEvents, expectedDisplayAgeEvents);
  });
}
