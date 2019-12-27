import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/game_event.dart';

class StartSchoolEvent extends GameEvent {
  final School school;

  StartSchoolEvent(int age, this.school) : super(age);

  @override
  List<Object> get props => [age, school];
}