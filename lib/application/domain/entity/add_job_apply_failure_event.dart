import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/work/domain/entity/job.dart';

class AddJobApplyFailureEvent extends GameEvent {
  final int jobId;
  final List<Requirement> unmetRequirements;

  AddJobApplyFailureEvent(int age, this.jobId, this.unmetRequirements) : super(age);

  @override
  List<Object> get props => [age, jobId, unmetRequirements];
}