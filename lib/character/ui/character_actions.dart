import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

class SetCharacterAction extends Equatable {
  final Character character;

  SetCharacterAction(this.character);

  @override
  List<Object> get props => [character];
}

class SetCharacterJobAction extends Equatable {
  final Job job;

  SetCharacterJobAction(this.job);

  @override
  List<Object> get props => [job];
}