import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:equatable/equatable.dart';

class SetCharacterAction extends Equatable {
  final DisplayCharacter displayCharacter;

  SetCharacterAction(this.displayCharacter): super([displayCharacter]);
}