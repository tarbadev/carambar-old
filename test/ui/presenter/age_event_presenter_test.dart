import 'package:carambar/ui/presenter/age_event_presenter.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../factory.dart';
import '../../mock_definition.dart';

void main() {
  group("AgeEvent Presenter", () {
    test('fromAgeEvent generates DisplayAgeEvent', () async {
      var ageEventPresenter = AgeEventPresenter(Mocks.ageEventService);
      var expectedDisplayAgeEvents = [Factory.displayAgeEvent(id: 0, age: "Age 0"), Factory.displayAgeEvent(id: 1, age: "Age 1")];

      when(Mocks.ageEventService.getAgeEvents()).thenAnswer((_) async => [Factory.ageEvent(age: 0), Factory.ageEvent(age: 1)]);

      expect(await ageEventPresenter.getDisplayAgeEvents(), expectedDisplayAgeEvents);
    });
  });
}