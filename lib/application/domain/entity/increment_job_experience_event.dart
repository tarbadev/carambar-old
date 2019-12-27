import 'package:carambar/application/domain/entity/game_event.dart';

class IncrementJobExperienceEvent extends GameEvent {
  IncrementJobExperienceEvent(int age) : super(age);
}