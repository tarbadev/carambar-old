import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/entity/display_character.dart';

class GlobalState {
  final int currentTab;
  final DisplayCharacter character;
  final List<DisplayAgeEvent> ageEvents;

  GlobalState(this.currentTab, this.character, this.ageEvents);

  factory GlobalState.initial() => GlobalState(0, null, []);
}