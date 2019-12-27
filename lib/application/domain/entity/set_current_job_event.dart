import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/work/domain/entity/job.dart';

class SetCurrentJobEvent extends GameEvent {
  final int jobId;

  SetCurrentJobEvent(int age, this.jobId) : super(age);

  @override
  List<Object> get props => [age, jobId];
}