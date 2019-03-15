import 'package:carambar/actions.dart';
import 'package:carambar/global_state.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/entity/display_character.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<GlobalState>> createStoreMiddleware() => [
      TypedMiddleware<GlobalState, EndLifeAction>(_endLife),
      TypedMiddleware<GlobalState, InitiateStateAction>(_initiateState),
      TypedMiddleware<GlobalState, IncrementAgeAction>(_incrementAge),
    ];

Future _endLife(Store<GlobalState> store, EndLifeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  await _characterService.deleteCharacter();
  await _ageEventService.deleteAgeEvents();

  await _loadCharacter(store);
  await _loadAgeEvents(store);

  store.dispatch(SelectHomeTabAction());

  next(action);
}

Future _initiateState(Store<GlobalState> store, InitiateStateAction action, NextDispatcher next) async {
  await _loadCharacter(store);
  await _loadAgeEvents(store);

  next(action);
}

Future _loadCharacter(Store<GlobalState> store) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  var character = await _characterService.getCharacter();

  if (character == null) {
    character = await _characterService.generateCharacter();
    var displayCharacter = DisplayCharacter.fromCharacter(character);

    var newCharacterEvent = '''
      You just started your life!
      You're a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}
      '''
        .split('\n')
        .map((line) => line.trim())
        .reduce((line1, line2) => line2.isNotEmpty ? '$line1\n$line2' : line1);
    var ageEvents = await _ageEventService.addEvent(character.age, event: newCharacterEvent);
    store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));
  }

  store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character)));
}

Future _loadAgeEvents(Store<GlobalState> store) async {
  var container = kiwi.Container();
  var _ageEventService = container<AgeEventService>();
  var ageEvents = await _ageEventService.getAgeEvents();

  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));
}

Future _incrementAge(Store<GlobalState> store, IncrementAgeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  var character = await _characterService.incrementAge();
  var ageEvents = await _ageEventService.addEvent(character.age);

  store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character)));
  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));
  next(action);
}
