import 'dart:convert';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/domain/entity/nationality.dart';

class CharacterEntity {
  final String firstName;
  final String lastName;
  final String gender;
  final String origin;
  final int age;

  CharacterEntity(
      {this.firstName, this.lastName, this.gender, this.origin, this.age});

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'origin': origin,
        'age': age,
      };

  CharacterEntity.fromCharacter(Character character)
      : firstName = character.firstName,
        lastName = character.lastName,
        gender = character.gender,
        origin = character.origin.toString(),
        age = character.age;

  static fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return CharacterEntity(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      gender: jsonData['gender'],
      origin: jsonData['origin'],
      age: jsonData['age'],
    );
  }

  Character toCharacter() {
    return Character(
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      origin: Nationality.values.firstWhere((e) => e.toString() == origin),
    );
  }
}
