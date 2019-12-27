import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/work/domain/entity/job.dart';
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
  AgeEventService _ageEventService = container.resolve<AgeEventService>();
  GameService _gameService = container.resolve<GameService>();

  var character = await _characterService.getCharacter();

  if (character == null) {
    character = await _characterService.generateCharacter();
    var displayCharacter = DisplayCharacter.fromCharacter(character);
    var initiateEvent = InitiateEvent.fromCharacter(character);

    await _gameService.addEvent(initiateEvent);

    var newCharacterEvent = '''
      You just started your life!
      You're a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}
      '''
        .split('\n')
        .map((line) => line.trim())
        .reduce((line1, line2) => line2.isNotEmpty ? '$line1\n$line2' : line1);
    var ageEvents = await _ageEventService.addEvent(character.age,
        event: newCharacterEvent);
    store.dispatch(SetAgeEventsAction(ageEvents
        .map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent))
        .toList()));
  }

  store.dispatch(SetCharacterAction(DisplayCharacter.fromCharacter(character)));

  next(action);
}

Future setCharacterJob(Store<ApplicationState> store,
    SetCharacterJobAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  var character;
  List<String> events = new List();
  var unmetRequirements =
      await _characterService.getUnmetRequirements(action.job);
  if (unmetRequirements.isEmpty) {
    character = await _characterService.setJob(action.job);
    var displayCharacter = DisplayCharacter.fromCharacter(character);
    events.add('You\'re now a ${displayCharacter.currentJob.name}');

    store.dispatch(SetCharacterAction(displayCharacter));
  } else {
    character = await _characterService.getCharacter();
    events.add(
        'You failed to apply for this new job because you don\'t meet all the requirements:');
    events.addAll(unmetRequirements.map((unmetRequirement) =>
        _requirementToDisplayUnmetRequirement[unmetRequirement]));
  }

  var ageEvents = await _ageEventService.addEvents(character.age, events);
  store.dispatch(SetAgeEventsAction(ageEvents
      .map((ageEvent) => DisplayAgeEvent.fromAgeEvent(ageEvent))
      .toList()));

  next(action);
}

Map<Requirement, String> _requirementToDisplayUnmetRequirement = {
  Requirement.HighSchool: '\u2022 Did not graduate from High School',
  Requirement.Supervisor3Years: '\u2022 Does not have at least 3 years of experience as a Supervisor',
  Requirement.SubTeacher1Year: '\u2022 Does not have at least 1 year of experience as a Substitute Teacher',
  Requirement.Teacher5Years: '\u2022 Does not have at least 5 years of experience as a Teacher',
  Requirement.Counselor5Years: '\u2022 Does not have at least 5 years of experience as a Counselor',
  Requirement.AssociateDirector5Years: '\u2022 Does not have at least 5 years of experience as a Associate Director',
};
