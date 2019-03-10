import 'dart:convert';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/domain/entity/nationality.dart';

class CharacterEntity {
  final String firstName;
  final String lastName;
  final String sex;
  final String origin;
  final int age;

  CharacterEntity(
      {this.firstName, this.lastName, this.sex, this.origin, this.age});

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'sex': sex,
        'origin': origin,
        'age': age,
      };

  CharacterEntity.fromCharacter(Character character)
      : firstName = character.firstName,
        lastName = character.lastName,
        sex = character.sex,
        origin = character.origin.toString(),
        age = character.age;

  static fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return CharacterEntity(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      sex: jsonData['sex'],
      origin: jsonData['origin'],
      age: jsonData['age'],
    );
  }

  Character toCharacter() {
    return Character(
      firstName: firstName,
      lastName: lastName,
      age: age,
      sex: sex,
      origin: Nationality.values.firstWhere((e) => e.toString() == origin),
    );
  }
}
