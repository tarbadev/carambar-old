import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/widget/age_event_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class HomeTabView extends BaseViewTester {
  final WidgetTester tester;

  HomeTabView(this.tester) : super(tester);

  bool get isVisible => widgetExists('Home__AgeButton');

  Future<void> tapOnAgeButton() async => await tapOnButtonByKey('Home__AgeButton');

  Future<List<DisplayAgeEvent>> getEventList() async {
    var ageEventListFinder = find.byType(AgeEventList);
    expect(ageEventListFinder, findsOneWidget);

    return (ageEventListFinder.evaluate().single.widget as AgeEventList).displayAgeEvents;
  }
}
