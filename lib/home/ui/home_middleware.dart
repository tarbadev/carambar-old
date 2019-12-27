import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createHomeMiddleware() => [
      TypedMiddleware<ApplicationState, InitiateStateAction>(initiateAgeEvents),
      TypedMiddleware<ApplicationState, IncrementAgeAction>(incrementAge),
    ];

Future initiateAgeEvents(Store<ApplicationState> store, InitiateStateAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  var _ageEventService = container<AgeEventService>();
  var ageEvents = await _ageEventService.getAgeEvents();

  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));

  next(action);
}

Future incrementAge(Store<ApplicationState> store, IncrementAgeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();
  GameService _gameService = container.resolve<GameService>();

  School originalSchool = store.state.character.school;

  var character = await _characterService.incrementAge();
  var newDisplayCharacter = DisplayCharacter.fromCharacter(character);
  var event;

  await _gameService.incrementAge();

  if (character.school != originalSchool) {
    if (newDisplayCharacter.school == 'None') {
      await _gameService.finishStudies();
      event = 'You finished your studies';
    } else {
      await _gameService.startSchool(character.school);
      event = 'You just started ${newDisplayCharacter.school}';
    }

    if (originalSchool == School.HighSchool || originalSchool == School.MiddleSchool) {
      var graduate = originalSchool == School.HighSchool ? Graduate.HighSchool : Graduate.MiddleSchool;
      character = await _characterService.addGraduate(graduate);
      newDisplayCharacter = DisplayCharacter.fromCharacter(character);

      var displaySchool = DisplayCharacter.mapSchoolToDisplaySchool[originalSchool];
      var graduatedEvent = 'You graduated from $displaySchool';
      await _ageEventService.addEvent(character.age, event: graduatedEvent);
    }
  }

  if (character.currentJob != null) {
    character = await _characterService.incrementJobExperience();
    newDisplayCharacter = DisplayCharacter.fromCharacter(character);

    store.dispatch(AddAvailableCashAction(character.currentJob.salary));
  }

  var ageEvents = await _ageEventService.addEvent(character.age, event: event);

  store.dispatch(SetCharacterAction(character));
  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));

  next(action);
}
