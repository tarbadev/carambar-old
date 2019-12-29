import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_middleware.dart';
import 'package:carambar/home/ui/home_middleware.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:carambar/work/ui/work_middleware.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

import 'application_actions.dart';

List<Middleware<ApplicationState>> createApplicationMiddleware() {
  List<Middleware<ApplicationState>> applicationMiddleware = [
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

Future initiateGameEvents(
  Store<ApplicationState> store,
  InitiateStateAction action,
  NextDispatcher next,
) async {
  final container = kiwi.Container();
  final _gameService = container<GameService>();
  final gameEvents = await _gameService.getEvents();

  if (gameEvents.isEmpty) {
    store.dispatch(InitiateCharacterAction());
  } else {
    store.dispatch(SetGameEventsAction(gameEvents));
  }

  next(action);
}

Future onSetGameEventsAction(
  Store<ApplicationState> store,
  SetGameEventsAction action,
  NextDispatcher next,
) async {
  double availableCash = 0.0;
  action.gameEvents
      .where((event) => event.runtimeType == AddCashEvent)
      .forEach((event) => availableCash += (event as AddCashEvent).amount);

  store.dispatch(BuildAgeEventsAction(action.gameEvents));
  store.dispatch(BuildCharacterAction(action.gameEvents));
  store.dispatch(SetAvailableCashAction(availableCash));

  next(action);
}
