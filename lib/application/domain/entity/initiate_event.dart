import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:equatable/equatable.dart';

class InitiateEvent extends Equatable {
  final int age;
  final String firstName;
  final String lastName;
  final String gender;
  final Nationality origin;

  InitiateEvent(this.age, this.firstName, this.lastName, this.gender, this.origin);

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
