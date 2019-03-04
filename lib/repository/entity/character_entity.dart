import 'package:carambar/domain/entity/character.dart';

class CharacterEntity {
  final String firstName;
  final String lastName;
  final String sex;
  final String origin;
  final int age;

  CharacterEntity(
      {this.firstName, this.lastName, this.sex, this.origin, this.age});

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "sex": sex,
        "origin": origin,
        "age": age,
      };

  CharacterEntity.fromCharacter(Character character)
      : firstName = character.firstName,
        lastName = character.lastName,
        sex = character.sex,
        origin = character.origin,
        age = character.age;
}
