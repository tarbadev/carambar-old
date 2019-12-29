import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/ui/application_actions.dart';
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
      test('calls the gameService incrementAge', () async {
        var originalCharacter = Factory.character(age: 1);
        var incrementAgeAction = IncrementAgeAction();
        var gameEvents = [GameEvent(2)];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge())
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.incrementAge());
        verifyNoMoreInteractions(Mocks.gameService);
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
        verify(Mocks.mockNext.next(incrementAgeAction));
      });

      test('adds an event when changing school - Kindergarten', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 2);
        var gameEvents = [
          GameEvent(3),
          StartSchoolEvent(3, School.Kindergarten)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => [GameEvent(3)]);
        when(Mocks.gameService.startSchool(any)).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.startSchool(School.Kindergarten));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when changing school - PrimarySchool', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 5);
        final newAge = 6;
        var gameEvents = [
          GameEvent(newAge),
          StartSchoolEvent(newAge, School.PrimarySchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => [GameEvent(newAge)]);
        when(Mocks.gameService.startSchool(any)).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.startSchool(School.PrimarySchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when changing school - MiddleSchool', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 10);
        final newAge = 11;
        var gameEvents = [
          GameEvent(newAge),
          StartSchoolEvent(newAge, School.MiddleSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => [GameEvent(newAge)]);
        when(Mocks.gameService.startSchool(any)).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.startSchool(School.MiddleSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when changing school - HighSchool', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 15);
        final newAge = 16;
        var gameEvents = [
          GameEvent(newAge),
          StartSchoolEvent(newAge, School.HighSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => [GameEvent(newAge)]);
        when(Mocks.gameService.startSchool(any)).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.startSchool(School.HighSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when finishing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 17, school: School.HighSchool);
        var gameEvents = [GameEvent(18), FinishStudiesEvent(18)];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => gameEvents);
        when(Mocks.gameService.finishStudies())
            .thenAnswer((_) async => gameEvents);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.incrementAge());
        verify(Mocks.gameService.finishStudies());
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when graduating from Middle School', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 14, school: School.MiddleSchool);
        var gameEvents = [
          GameEvent(15),
          GraduateEvent(15, School.MiddleSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => gameEvents);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.graduate(School.MiddleSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('adds an event when graduating from High School', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 17, school: School.HighSchool);
        var gameEvents = [
          GameEvent(18),
          GraduateEvent(18, School.HighSchool)
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => gameEvents);
        when(Mocks.gameService.graduate(any))
            .thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.graduate(School.HighSchool));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('calls addCash when having a job', () async {
        var incrementAgeAction = IncrementAgeAction();
        var salary = 15000.0;
        var originalCharacter = Factory.character(age: 21, currentJob: Factory.job(salary: salary));
        var gameEvents = [
          GameEvent(18),
          AddCashEvent(18, salary),
        ];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => [GameEvent(18)]);
        when(Mocks.gameService.addCash(salary)).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verify(Mocks.gameService.addCash(salary));
        verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      });

      test('does not call addCash when not having a job',
          () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalCharacter = Factory.character(age: 21);
        var gameEvents = [GameEvent(18)];

        when(Mocks.applicationState.character).thenReturn(originalCharacter);
        when(Mocks.gameService.incrementAge()).thenAnswer((_) async => gameEvents);

        await incrementAge(Mocks.store, incrementAgeAction, Mocks.next);

        verifyNever(Mocks.gameService.addCash(15000));
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
