import 'package:carambar/domain/entity/age_event.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../factory.dart';
import '../mock_definition.dart';

void main() {
  group("AgeEventService", () {
    List<AgeEvent> existingAgeEvents;
    AgeEventService ageEventService;

    setUp(() {
      reset(Mocks.ageEventRepository);
      ageEventService = AgeEventService(Mocks.ageEventRepository);

      existingAgeEvents = [
        Factory.ageEvent(age: 0, events: []),
        Factory.ageEvent(age: 1, events: ["An existing event"])
      ];
    });

    test('getAgeEvent returns the events from the repository', () async {
      final List<AgeEvent> expectedAgeEvents = existingAgeEvents;

      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => expectedAgeEvents);

      expect(await ageEventService.getAgeEvents(), expectedAgeEvents);
    });

    test('getAgeEvent returns an empty list when the repository returns null',
        () async {
      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => null);

      expect(await ageEventService.getAgeEvents(), []);
    });

    test('addEvent adds an event to the current list', () async {
      var ageEvents = [
        existingAgeEvents[0],
        existingAgeEvents[1],
        Factory.ageEvent(age: 2, events: [])
      ];

      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => existingAgeEvents);

      expect(await ageEventService.addEvent(2), ageEvents);

      verify(Mocks.ageEventRepository.save(ageEvents));
    });

    test('addEvent adds an event to the current list with an event message', () async {
      var event = "Some Event";
      var ageEvents = [
        Factory.ageEvent(age: 0, events: [event])
      ];

      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => null);

      expect(await ageEventService.addEvent(0, event: event), ageEvents);

      verify(Mocks.ageEventRepository.save(ageEvents));
    });

    test('addEvent adds an event to the current list of events for this age',
        () async {
      var expectedEvent = "Some event";
      var ageEvents = [
        Factory.ageEvent(age: 0, events: []),
        Factory.ageEvent(age: 1, events: [existingAgeEvents[1].events[0], expectedEvent]),
      ];

      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => existingAgeEvents);

      expect(await ageEventService.addEvent(1, event: expectedEvent), ageEvents);

      verify(Mocks.ageEventRepository.save(ageEvents));
    });

    test('deleteAgeEvents calls the repository to delete the ageEvents', () async {
      await ageEventService.deleteAgeEvents();

      verify(Mocks.ageEventRepository.delete());
    });
  });
}
