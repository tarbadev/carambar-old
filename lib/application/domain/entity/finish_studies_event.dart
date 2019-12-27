import 'package:carambar/application/domain/entity/game_event.dart';

class FinishStudiesEvent extends GameEvent {
  FinishStudiesEvent(int age) : super(age);
}