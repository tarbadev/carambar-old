import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/home/ui/entity/display_age_event.dart';

class ApplicationState {
  final int currentTab;
  final DisplayCharacter character;
  final List<DisplayAgeEvent> ageEvents;
  final bool isEndLifeDialogVisible;
  final double availableCash;

  ApplicationState(this.currentTab, this.character, this.ageEvents, this.isEndLifeDialogVisible, this.availableCash);

  factory ApplicationState.initial() => ApplicationState(0, null, [], false, 0);
}