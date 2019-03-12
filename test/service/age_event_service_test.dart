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
      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => existingAgeEvents);

      await ageEventService.addEvent(2);

      verify(Mocks.ageEventRepository.save([
        existingAgeEvents[0],
        existingAgeEvents[1],
        Factory.ageEvent(age: 2, events: [])
      ]));
    });

    test('addEvent adds an event to the current list with an event message', () async {
      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => null);

      var event = "Some Event";
      await ageEventService.addEvent(0, event: event);

      verify(Mocks.ageEventRepository.save([
        Factory.ageEvent(age: 0, events: [event])
      ]));
    });

    test('addEvent adds an event to the current list of events for this age',
        () async {
      var expectedEvent = "Some event";

      when(Mocks.ageEventRepository.readAgeEvents())
          .thenAnswer((_) async => existingAgeEvents);

      await ageEventService.addEvent(1, event: expectedEvent);

      verify(Mocks.ageEventRepository.save([
        Factory.ageEvent(age: 0, events: []),
        Factory.ageEvent(age: 1, events: [existingAgeEvents[1].events[0], expectedEvent]),
      ]));
    });
  });
}
