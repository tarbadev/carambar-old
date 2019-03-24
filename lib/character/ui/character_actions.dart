import 'package:carambar/character/ui/entity/display_character.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

class SetCharacterAction extends Equatable {
  final DisplayCharacter displayCharacter;

  SetCharacterAction(this.displayCharacter): super([displayCharacter]);
}

class SetCharacterJobAction extends Equatable {
  final Job job;

  SetCharacterJobAction(this.job): super([job]);
}