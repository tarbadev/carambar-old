import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../factory.dart';
import '../mock_definition.dart';

void main() {
  group("AgeEventService", () {
    AgeEventService ageEventService;

    setUp(() {
      ageEventService = AgeEventService(Mocks.ageEventRepository);
      reset(Mocks.ageEventRepository);
    });

    test('getAgeEvent returns the events from the repository', () async {
      final List<AgeEvent> expectedAgeEvents = [Factory.ageEvent(age: 0), Factory.ageEvent(age: 1)];

      when(Mocks.ageEventRepository.readAgeEvents()).thenAnswer((_) async => expectedAgeEvents);

      expect(await ageEventService.getAgeEvents(), expectedAgeEvents);
    });

    test('getAgeEvent returns an empty list when the repository returns null', () async {
      when(Mocks.ageEventRepository.readAgeEvents()).thenAnswer((_) async => null);

      expect(await ageEventService.getAgeEvents(), []);
    });

    test('addEvent adds an event to the current list', () async {
      when(Mocks.ageEventRepository.readAgeEvents()).thenAnswer((_) async => [Factory.ageEvent(age: 0), Factory.ageEvent(age: 1)]);

      await ageEventService.addEvent(2);

      verify(Mocks.ageEventRepository.save([Factory.ageEvent(age: 0), Factory.ageEvent(age: 1), Factory.ageEvent(age: 2, events: [])]));
    });
  });
}
