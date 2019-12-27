import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/nationality.dart';

class InitiateEvent extends GameEvent {
  final String firstName;
  final String lastName;
  final String gender;
  final Nationality origin;

  InitiateEvent(int age, this.firstName, this.lastName, this.gender, this.origin)
      : super(age);

  factory InitiateEvent.fromCharacter(Character character) {
    return InitiateEvent(
      character.age,
      character.firstName,
      character.lastName,
      character.gender,
      character.origin,
    );
  }

  @override
  List<Object> get props => [
        age,
        firstName,
        lastName,
        gender,
        origin,
      ];
}
