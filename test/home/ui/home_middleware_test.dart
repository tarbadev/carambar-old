import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

class MockStore extends Mock implements Store<ApplicationState> {}

typedef void NextDispatcher(dynamic action);

abstract class MockFunction {
  next(dynamic action);
}

class MockNext extends Mock implements MockFunction {}

class MockApplicationState extends Mock implements ApplicationState {}

void main() {
  setupWidgetTest();

  group("Home Middleware", () {
    Store<ApplicationState> mockStore = MockStore();
    MockNext mockNext = MockNext();
    ApplicationState mockApplicationState = MockApplicationState();
    var next = (dynamic action) => mockNext.next(action);
    var originalDisplayCharacter = Factory.displayCharacter(age: '17');

    setUp(() {
      reset(mockStore);
      reset(mockApplicationState);
      reset(mockNext);

      when(mockStore.state).thenReturn(mockApplicationState);
      when(mockApplicationState.character).thenReturn(originalDisplayCharacter);
    });

    group('incrementAge', () {
      test('calls the characterService and saves the new character in state and calls next action', () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);

        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => []);

        await incrementAge(mockStore, incrementAgeAction, next);

        verify(mockStore.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character))));
        verify(mockNext.next(incrementAgeAction));
      });

      test('calls the ageEventService and saves the new events in state and calls next action', () async {
        var incrementAgeAction = IncrementAgeAction();
        var character = Factory.character(age: 18);
        var ageEvents = [Factory.ageEvent(age: 18, events: [])];

        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(mockStore, incrementAgeAction, next);

        verify(Mocks.ageEventService.addEvent(18, event: null));
        verify(mockStore.dispatch(
            SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList())));
        verify(mockNext.next(incrementAgeAction));
      });

      test('adds an event when changing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '2');
        var character = Factory.character(age: 3);
        var ageEvents = [Factory.ageEvent(age: 3, events: ['You just started Kindergarten'])];

        when(mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(mockStore, incrementAgeAction, next);

        verify(Mocks.ageEventService.addEvent(3, event: 'You just started Kindergarten'));
      });

      test('adds a different event when finishing school', () async {
        var incrementAgeAction = IncrementAgeAction();
        var originalDisplayCharacter = Factory.displayCharacter(age: '17', school: 'High School');
        var character = Factory.character(age: 18);
        var ageEvents = [Factory.ageEvent(age: 18, events: ['You finished your studies'])];

        when(mockApplicationState.character).thenReturn(originalDisplayCharacter);
        when(Mocks.characterService.incrementAge()).thenAnswer((_) async => character);
        when(Mocks.ageEventService.addEvent(any, event: anyNamed('event'))).thenAnswer((_) async => ageEvents);

        await incrementAge(mockStore, incrementAgeAction, next);

        verify(Mocks.ageEventService.addEvent(18, event: 'You finished your studies'));
      });
    });
  });
}
