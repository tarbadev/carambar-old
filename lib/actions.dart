import 'package:carambar/ui/entity/display_age_event.dart';
import 'package:carambar/ui/entity/display_character.dart';

class SelectTabAction {
  final int index;

  SelectTabAction(this.index);
}

class EndLifeAction {}

class SelectHomeTabAction extends SelectTabAction {
  SelectHomeTabAction() : super(0);
}

class SetCharacterAction {
  final DisplayCharacter displayCharacter;

  SetCharacterAction(this.displayCharacter);
}

class SetAgeEventsAction {
  final List<DisplayAgeEvent> displayAgeEvents;

  SetAgeEventsAction(this.displayAgeEvents);
}

class InitiateStateAction {}

class IncrementAgeAction {}