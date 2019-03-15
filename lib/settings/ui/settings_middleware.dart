import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/domain/service/character_service.dart';
import 'package:carambar/home/domain/service/age_event_service.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createSettingsMiddleware() => [
  TypedMiddleware<ApplicationState, EndLifeAction>(endLife),
];

Future endLife(Store<ApplicationState> store, EndLifeAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  CharacterService _characterService = container.resolve<CharacterService>();
  AgeEventService _ageEventService = container.resolve<AgeEventService>();

  await _characterService.deleteCharacter();
  await _ageEventService.deleteAgeEvents();

  store.dispatch(InitiateStateAction());
  store.dispatch(SelectHomeTabAction());

  next(action);
}