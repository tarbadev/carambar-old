import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:redux/redux.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

List<Middleware<ApplicationState>> createHomeMiddleware() => [
  TypedMiddleware<ApplicationState, InitiateStateAction>(_initiateAgeEvents),
  TypedMiddleware<ApplicationState, IncrementAgeAction>(_incrementAge),
];

Future _initiateAgeEvents(Store<ApplicationState> store, InitiateStateAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  var _ageEventService = container<AgeEventService>();
  var ageEvents = await _ageEventService.getAgeEvents();

  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));

  next(action);
}

Future _incrementAge(Store<ApplicationState> store, IncrementAgeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  var character = await _characterService.incrementAge();
  var ageEvents = await _ageEventService.addEvent(character.age);

  store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character)));
  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));

  next(action);
}