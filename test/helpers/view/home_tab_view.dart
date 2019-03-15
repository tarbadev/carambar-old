import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class HomeTabView extends BaseView {
  final WidgetTester tester;

  HomeTabView(this.tester) : super(tester);

  Finder get _ageButtonFinder => find.byKey(Key("ageButton"));

  bool get isVisible {
    try {
      tester.renderObject<RenderBox>(_ageButtonFinder);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> clickOnAgeButton() async => await tester.tap(_ageButtonFinder);

  Future<List<DisplayAgeEvent>> getEventList() async {
    var ageEventListFinder = find.byType(AgeEventList);
    expect(ageEventListFinder, findsOneWidget);

    return (ageEventListFinder.evaluate().single.widget as AgeEventList).displayAgeEvents;
  }
}
