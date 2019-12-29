import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createSettingsMiddleware() => [
  TypedMiddleware<ApplicationState, EndLifeAction>(endLife),
];

Future endLife(Store<ApplicationState> store, EndLifeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  GameService _gameService = container.resolve<GameService>();

  await _gameService.deleteGameEvents();

  store.dispatch(InitiateStateAction());
  store.dispatch(SelectHomeTabAction());

  next(action);
}