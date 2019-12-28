import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/game_event_to_age_event_mapper.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createHomeMiddleware() => [
      TypedMiddleware<ApplicationState, BuildAgeEventsAction>(initiateAgeEvents),
      TypedMiddleware<ApplicationState, IncrementAgeAction>(incrementAge),
    ];

Future initiateAgeEvents(
  Store<ApplicationState> store,
  BuildAgeEventsAction action,
  NextDispatcher next,
) async {
  var ageEvents = GameEventToAgeEventMapper.execute(action.gameEvents);

  store.dispatch(SetAgeEventsAction(ageEvents
      .map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent))
      .toList()));

  next(action);
}

Future incrementAge(Store<ApplicationState> store, IncrementAgeAction action,
    NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  GameService _gameService = container.resolve<GameService>();

  School originalSchool = store.state.character.school;

  var character = await _characterService.incrementAge();
  var gameEvents = await _gameService.incrementAge();

  if (character.school != originalSchool) {
    if (character.school == School.None) {
      gameEvents = await _gameService.finishStudies();
    } else {
      gameEvents = await _gameService.startSchool(character.school);
    }

    if (originalSchool == School.HighSchool ||
        originalSchool == School.MiddleSchool) {
      gameEvents = await _gameService.graduate(originalSchool);
      var graduate = originalSchool == School.HighSchool
          ? Graduate.HighSchool
          : Graduate.MiddleSchool;
      character = await _characterService.addGraduate(graduate);
    }
  }

  if (character.currentJob != null) {
    await _gameService.incrementJobExperience();
    character = await _characterService.incrementJobExperience();

    await _gameService.addCash(character.currentJob.salary);
    store.dispatch(AddAvailableCashAction(character.currentJob.salary));
  }

  store.dispatch(SetCharacterAction(character));
  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}
