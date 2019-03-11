import 'package:carambar/ui/home_tab.dart';
import 'package:carambar/ui/presenter/display_age_event.dart';
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
    var homeTabView = HomeTabView(tester);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));

    await homeTabView.clickOnAgeButton();
    await homeTabView.clickOnAgeButton();

    verify(Mocks.characterPresenter.incrementAge()).called(2);
  });

  testWidgets('home shows a list of events from the EventService',
      (WidgetTester tester) async {
    List<DisplayAgeEvent> expectedDisplayAgeEvents = [Factory.displayAgeEvent(age: "Age 0"), Factory.displayAgeEvent(age: "Age 1")];

    when(Mocks.ageEventPresenter.getDisplayAgeEvents()).thenAnswer((_) async => expectedDisplayAgeEvents);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));
    var eventListFinder = find.byType(AgeEventList);
    expect(eventListFinder, findsNothing);

    await tester.pump();

    verify(Mocks.ageEventPresenter.getDisplayAgeEvents());

    expect(eventListFinder, findsOneWidget);

    AgeEventList eventList = eventListFinder.evaluate().single.widget;
    expect(eventList.displayAgeEvents, expectedDisplayAgeEvents);
  });
}
