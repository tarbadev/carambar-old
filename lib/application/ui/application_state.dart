import 'package:carambar/home/ui/entity/display_age_event.dart';
import 'package:carambar/character/ui/entity/display_character.dart';

class ApplicationState {
  final int currentTab;
  final DisplayCharacter character;
  final List<DisplayAgeEvent> ageEvents;
  final bool isEndLifeDialogVisible;

  ApplicationState(this.currentTab, this.character, this.ageEvents, this.isEndLifeDialogVisible);

  factory ApplicationState.initial() => ApplicationState(0, null, [], false);
}