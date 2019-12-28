import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createCharacterMiddleware() => [
      TypedMiddleware<ApplicationState, InitiateStateAction>(initiateCharacter),
      TypedMiddleware<ApplicationState, SetCharacterJobAction>(setCharacterJob),
    ];

Future initiateCharacter(Store<ApplicationState> store,
    InitiateStateAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  GameService _gameService = container.resolve<GameService>();

  var character = await _characterService.getCharacter();

  if (character == null) {
    character = await _characterService.generateCharacter();

    final gameEvents = await _gameService.initiate(character);

    store.dispatch(SetGameEventsAction(gameEvents));
  }

  store.dispatch(SetCharacterAction(character));

  next(action);
}

Future setCharacterJob(Store<ApplicationState> store,
    SetCharacterJobAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  GameService _gameService = container.resolve<GameService>();

  var gameEvents;
  var unmetRequirements =
      await _characterService.getUnmetRequirements(action.job);
  if (unmetRequirements.isEmpty) {
    gameEvents = await _gameService.setCurrentJob(action.job);

    var character = await _characterService.setJob(action.job);

    store.dispatch(SetCharacterAction(character));
  } else {
    gameEvents = await _gameService.addJobApplyFailure(action.job, unmetRequirements);
  }

  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}