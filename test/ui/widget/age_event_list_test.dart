import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../factory.dart';
import '../../fake_application_injector.dart';
import '../../helpers/testable_widget.dart';
import '../../helpers/view/age_event_view.dart';

void main() {
  setupWidgetTest();

  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    var displayAgeEvents = [Factory.displayAgeEvent()];

    await tester.pumpWidget(buildTestableWidget(AgeEventList(
      displayAgeEvents: displayAgeEvents,
    )));

    var ageEventView = AgeEventView(displayAgeEvents[0].id, tester);

    expect(ageEventView.events, displayAgeEvents[0].events);
  });
}
