import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:equatable/equatable.dart';

class SetCharacterAction extends Equatable {
  final Character character;

  SetCharacterAction(this.character);

  @override
  List<Object> get props => [character];

  @override
  String toString() {
    return 'SetCharacterAction{character: $character}';
  }
}

class SetCharacterJobAction extends Equatable {
  final Job job;

  SetCharacterJobAction(this.job);

  @override
  List<Object> get props => [job];

  @override
  String toString() {
    return 'SetCharacterJobAction{job: $job}';
  }
}