import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_middleware.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('ApplicationMiddleware', () {
    test('initiateGameEvents', () async {
      var initiateStateAction = InitiateStateAction();
      var gameEvents = [GameEvent(18)];

      when(Mocks.gameService.getEvents()).thenAnswer((_) async => gameEvents);

      await initiateGameEvents(Mocks.store, initiateStateAction, Mocks.next);

      verify(Mocks.store.dispatch(SetGameEventsAction(gameEvents)));
      verify(Mocks.mockNext.next(initiateStateAction));
    });

    test('initiateGameEvents when no events present dispatches a InitiateCharacterAction', () async {
      var initiateStateAction = InitiateStateAction();

      when(Mocks.gameService.getEvents()).thenAnswer((_) async => []);

      await initiateGameEvents(Mocks.store, initiateStateAction, Mocks.next);

      verify(Mocks.store.dispatch(InitiateCharacterAction()));
      verifyNoMoreInteractions(Mocks.store);
      verify(Mocks.mockNext.next(initiateStateAction));
    });

    test('onSetGameEventsAction calls build AgeEvents, Character and availableCash', () async {
      var gameEvents = [GameEvent(18), AddCashEvent(18, 10000.0), AddCashEvent(18, 1000.0)];
      var action = SetGameEventsAction(gameEvents);

      await onSetGameEventsAction(Mocks.store, action, Mocks.next);

      verify(Mocks.store.dispatch(BuildAgeEventsAction(gameEvents)));
      verify(Mocks.store.dispatch(BuildCharacterAction(gameEvents)));
      verify(Mocks.store.dispatch(SetAvailableCashAction(11000.0)));
      verify(Mocks.mockNext.next(action));
    });

    test('onSetGameEventsAction calls sets availableCash to 0 if no cash events', () async {
      var gameEvents = [GameEvent(18)];
      var action = SetGameEventsAction(gameEvents);

      await onSetGameEventsAction(Mocks.store, action, Mocks.next);

      verify(Mocks.store.dispatch(BuildAgeEventsAction(gameEvents)));
      verify(Mocks.store.dispatch(BuildCharacterAction(gameEvents)));
      verify(Mocks.store.dispatch(SetAvailableCashAction(0.0)));
      verify(Mocks.mockNext.next(action));
    });
  });
}