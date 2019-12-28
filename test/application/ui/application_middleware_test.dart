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

    test('onSetGameEventsAction', () async {
      var gameEvents = [GameEvent(18)];
      var action = SetGameEventsAction(gameEvents);

      await onSetGameEventsAction(Mocks.store, action, Mocks.next);

      verify(Mocks.store.dispatch(BuildAgeEventsAction(gameEvents)));
      verify(Mocks.mockNext.next(action));
    });
  });
}