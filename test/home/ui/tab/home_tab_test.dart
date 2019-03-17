import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/home/ui/tab/home_tab.dart';
import 'package:carambar/home/ui/widget/age_event_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/home_tab_view.dart';

void main() {
  testWidgets('Home Tab shows a button Age that dispatches incrementAge action', (WidgetTester tester) async {
    var homeTabView = HomeTabView(tester);

    await tester.pumpWidget(buildTestableWidget(HomeTab()));

    await homeTabView.clickOnAgeButton();

    verify(Mocks.store.dispatch(IncrementAgeAction()));
  });

  testWidgets('Home Tab shows a list of events from the EventService', (WidgetTester tester) async {
    List<DisplayAgeEvent> expectedDisplayAgeEvents = [
      Factory.displayAgeEvent(id: 0, age: "Age 0"),
      Factory.displayAgeEvent(id: 1, age: "Age 1")
    ];

    await tester.pumpWidget(buildTestableWidget(HomeTab(), displayAgeEvents: expectedDisplayAgeEvents));

    var eventListFinder = find.byType(AgeEventList);
    expect(eventListFinder, findsOneWidget);

    AgeEventList eventList = eventListFinder.evaluate().single.widget;
    expect(eventList.displayAgeEvents, expectedDisplayAgeEvents);
  });
}
