import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:carambar/work/ui/work_middleware.dart';
import 'package:redux/redux.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'application_actions.dart';

List<Middleware<ApplicationState>> createApplicationMiddleware() {
  List<Middleware<ApplicationState>> applicationMiddleware = [
    TypedMiddleware<ApplicationState, InitiateStateAction>(
        initiateAvailableCash),
    TypedMiddleware<ApplicationState, InitiateStateAction>(initiateGameEvents),
    TypedMiddleware<ApplicationState, SetGameEventsAction>(
        onSetGameEventsAction),
  ];

  applicationMiddleware.addAll(createHomeMiddleware());
  applicationMiddleware.addAll(createCharacterMiddleware());
  applicationMiddleware.addAll(createSettingsMiddleware());
  applicationMiddleware.addAll(createWorkMiddleware());

  return applicationMiddleware;
}

Future initiateAvailableCash(Store<ApplicationState> store,
    InitiateStateAction action, NextDispatcher next) async {
  store.dispatch(SetAvailableCashAction(0));

  next(action);
}

Future initiateGameEvents(
  Store<ApplicationState> store,
  InitiateStateAction action,
  NextDispatcher next,
) async {
  final container = kiwi.Container();
  final _gameService = container<GameService>();
  final gameEvents = await _gameService.getEvents();

  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}

Future onSetGameEventsAction(
  Store<ApplicationState> store,
  SetGameEventsAction action,
  NextDispatcher next,
) async {
  store.dispatch(BuildAgeEventsAction(action.gameEvents));

  next(action);
}
