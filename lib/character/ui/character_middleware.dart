import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createCharacterMiddleware() => [
      TypedMiddleware<ApplicationState, InitiateStateAction>(initiateCharacter),
      TypedMiddleware<ApplicationState, SetCharacterJobAction>(setCharacterJob),
    ];

Future initiateCharacter(Store<ApplicationState> store, InitiateStateAction action, NextDispatcher next) async {
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

  next(action);
}

Future setCharacterJob(Store<ApplicationState> store, SetCharacterJobAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  var character;
  var event;
  if (await _characterService.areRequirementsMet(action.job)) {
    character = await _characterService.setJob(action.job);
    var displayCharacter = DisplayCharacter.fromCharacter(character);
    event = 'You\'re now a ${displayCharacter.currentJob.name}';

    store.dispatch(SetCharacterAction(displayCharacter));
  } else {
    character = await _characterService.getCharacter();
    event = 'You failed to apply for this new job because you don\'t meet all the requirements';
  }

  var ageEvents = await _ageEventService.addEvent(character.age, event: event);
  store.dispatch(SetAgeEventsAction(ageEvents.map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent)).toList()));

  next(action);
}