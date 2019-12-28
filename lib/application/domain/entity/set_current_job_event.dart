import 'package:carambar/application/domain/entity/game_event.dart';

class SetCurrentJobEvent extends GameEvent {
  final int jobId;

  SetCurrentJobEvent(int age, this.jobId) : super(age);

  @override
  List<Object> get props => [age, jobId];
}