import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('Home Middleware', () {
    setUp(() {
      reset(Mocks.characterService);
      reset(Mocks.gameService);

      Mocks.setupMockStore();
    });

    group('incrementAge', () {
      test(
          'calls the characterService and saves the new character in state and calls next action',
          () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);

        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.store.dispatch(SetCharacterAction(character)));
        verify(Mocks.mockNext.next(incrementAgeAction));
      });

      test('calls the gameService incrementAge', () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);
        var gameEvents = [GameEvent(18)];

        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.gameService.incrementAge())
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.incrementAge());
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.mockNext.next(incrementAgeAction));
      });

      test('adds an event when changing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 2);
        var character = Factory.character(age: 3);
        var gameEvents = [
          GameEvent(18),
          StartSchoolEvent(18, School.MiddleSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.gameService.startSchool(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.startSchool(School.Kindergarten));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when finishing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 17);
        var character = Factory.character(age: 18);
        var gameEvents = [GameEvent(18), FinishStudiesEvent(18)];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any))
            .thenAnswer((_) async => character);
        when(Mocks.gameService.finishStudies())
            .thenAnswer((_) async => gameEvents);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.incrementAge());
        verify(Mocks.gameService.finishStudies());
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('calls characterService to add the graduate', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 17);
        var character = Factory.character(age: 18, graduates: []);
        var characterWithGraduates =
            Factory.character(age: 18, graduates: [Graduate.HighSchool]);
        var gameEvents = [
          GameEvent(18),
          GraduateEvent(18, School.HighSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any))
            .thenAnswer((_) async => characterWithGraduates);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.graduate(School.HighSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.characterService.addGraduate(Graduate.HighSchool));
      });

      test('adds an event when graduating from High School', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 17);
        var character = Factory.character(age: 18);
        var gameEvents = [
          GameEvent(18),
          GraduateEvent(18, School.HighSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any))
            .thenAnswer((_) async => character);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.graduate(School.HighSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.characterService.addGraduate(Graduate.HighSchool));
      });

      test('dispatches a AddAvailableCashAction when having a job', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 21);
        var character =
            Factory.character(age: 21, currentJob: Factory.currentJob());

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any))
            .thenAnswer((_) async => character);
        when(Mocks.characterService.incrementJobExperience())
            .thenAnswer((_) async => character);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.addCash(15000));
        verify(Mocks.store.dispatch(AddAvailableCashAction(15000)));
      });

      test('does not dispatch a AddAvailableCashAction when not having a job',
          () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 21);
        var character = Factory.character(age: 21, currentJob: null);

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.addGraduate(any))
            .thenAnswer((_) async => character);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verifyNever(Mocks.store.dispatch(AddAvailableCashAction(15000)));
      });

      test(
          'calls the service to increment the job experience and dispatches a SetCharacterAction',
          () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(
          currentJob: Factory.currentJob(),
          jobHistory: [Factory.jobExperience()],
        );

        when(Mocks.characterService.incrementAge())
            .thenAnswer((_) async => character);
        when(Mocks.characterService.incrementJobExperience())
            .thenAnswer((_) async => character);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.incrementJobExperience());
        verify(Mocks.characterService.incrementJobExperience());
        verify(Mocks.store.dispatch(SetCharacterAction(character)));
      });
    });

    group('initiateAgeEvents', () {
      test('retrieves the game events and stores them in the state', () async {
        var gameEvents = [GameEvent(18)];
        var action = BuildAgeEventsAction(gameEvents);
        var ageEvents = [Factory.ageEvent(age: 18, events: [])];

        await initiateAgeEvents(Mocks.store, action, Mocks.next);

        verify(Mocks.store.dispatch(SetAgeEventsAction(
            Factory.ageEventsToDisplayAgeEvents(ageEvents))));
        verifyNoMoreInteractions(Mocks.store);
        verify(Mocks.mockNext.next(action));
      });
    });
  });
}
