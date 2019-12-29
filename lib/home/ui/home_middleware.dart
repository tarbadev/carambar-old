import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/game_event_to_age_event_mapper.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createHomeMiddleware() => [
      TypedMiddleware<ApplicationState, BuildAgeEventsAction>(
          initiateAgeEvents),
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
  GameService _gameService = container.resolve<GameService>();

  var character = store.state.character;
  School originalSchool = character.school;

  var gameEvents = await _gameService.incrementAge();
  final newSchool = _schoolForAge(gameEvents.last.age);

  if (newSchool != originalSchool) {
    if (newSchool == School.None) {
      gameEvents = await _gameService.finishStudies();
    } else {
      gameEvents = await _gameService.startSchool(newSchool);
    }

    if (originalSchool == School.HighSchool ||
        originalSchool == School.MiddleSchool) {
      gameEvents = await _gameService.graduate(originalSchool);
    }
  }

  if (character.currentJob != null) {
    gameEvents = await _gameService.addCash(character.currentJob.salary);
  }

  store.dispatch(SetGameEventsAction(gameEvents));

  next(action);
}

School _schoolForAge(int age) {
  if (age >= 18)
    return School.None;
  else if (age >= 15)
    return School.HighSchool;
  else if (age >= 11)
    return School.MiddleSchool;
  else if (age >= 6)
    return School.PrimarySchool;
  else if (age >= 3)
    return School.Kindergarten;
  else
    return School.None;
}
