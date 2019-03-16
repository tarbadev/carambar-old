import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group("Home Middleware", () {
    setUp(() {
      reset(Mocks.characterService);
      reset(Mocks.ageEventService);

      Mocks.setupMockStore();
    });

    group('incrementAge', () {
      test('calls the characterService and saves the new character in state and calls next action', () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);

        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => []);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.mockStore.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character))));
        verify(Mocks.mockNext.next(incrementAgeAction));
      });

      test('calls the ageEventService and saves the new events in state and calls next action', () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);
        var ageEvents = [Factory.ageEvent(age: 18, events: [])];

        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(18, event: null));
        verify(Mocks.mockStore.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
        verify(Mocks.mockNext.next(incrementAgeAction));
      });

      test('adds an event when changing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '2');
        var character = Factory.character(age: 3);
        var ageEvents = [
          Factory.ageEvent(age: 3, events: ['You just started Kindergarten'])
        ];

        when(Mocks.mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(3, event: 'You just started Kindergarten'));
      });

      test('adds a different event when finishing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '17', school: 'High School');
        var character = Factory.character(age: 18);
        var ageEvents = [
          Factory.ageEvent(age: 18, events: ['You finished your studies'])
        ];

        when(Mocks.mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any)).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(18, event: 'You finished your studies'));
      });

      test('calls characterService to add the graduate', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '17', school: 'High School');
        var character = Factory.character(age: 18, graduates: []);
        var characterWithGraduates = Factory.character(age: 18, graduates: [Graduate.HighSchool]);

        var expectedEvent = 'You graduated from High School';
        var ageEvents = [Factory.ageEvent(age: 18, events: [expectedEvent])];

        when(Mocks.mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any)).thenAnswer((_) async => characterWithGraduates);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.characterService.addGraduate(Graduate.HighSchool));
      });

      test('adds an event when graduating from Middle School', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '14', school: 'Middle School');
        var character = Factory.character(age: 15);

        var expectedEvent = 'You graduated from Middle School';
        var ageEvents = [Factory.ageEvent(age: 15, events: [expectedEvent])];

        when(Mocks.mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any)).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(15, event: expectedEvent));
      });

      test('adds an event when graduating from High School', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '17', school: 'High School');
        var character = Factory.character(age: 18);

        var expectedEvent = 'You graduated from High School';
        var ageEvents = [Factory.ageEvent(age: 18, events: [expectedEvent])];

        when(Mocks.mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any)).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(Mocks.mockStore, incrementAgeAction, Mocks.next);

        verify(Mocks.ageEventService.addEvent(18, event: expectedEvent));
      });
    });

    test('initiateAgeEvents retrieves the ageEvents and stores them in the state', () async {
      var initiateStateAction = InitiateStateAction();
      var ageEvents = [Factory.ageEvent(age: 18, events: [])];

      when(Mocks.ageEventService.getAgeEvents()).thenAnswer((_) async => ageEvents);

      await initiateAgeEvents(Mocks.mockStore, initiateStateAction, Mocks.next);

      verify(Mocks.mockStore.dispatch(SetAgeEventsAction(Factory.ageEventsToDisplayAgeEvents(ageEvents))));
      verify(Mocks.mockNext.next(initiateStateAction));
    });
  });
}
