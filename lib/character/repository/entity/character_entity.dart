import 'dart:convert';

import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/entity/nationality.dart';

class CharacterEntity {
  final String firstName;
  final String lastName;
  final String gender;
  final String origin;
  final int age;
  final List<String> graduates;

  CharacterEntity({this.firstName, this.lastName, this.gender, this.origin, this.age, this.graduates});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'origin': origin,
        'age': age,
        'graduates': graduates,
      };

  CharacterEntity.fromCharacter(Character character)
      : firstName = character.firstName,
        lastName = character.lastName,
        gender = character.gender,
        origin = character.origin.toString(),
        age = character.age,
        graduates = character.graduates.map((graduate) => graduate.toString()).toList();

  static fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return CharacterEntity(
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      gender: jsonData['gender'],
      origin: jsonData['origin'],
      age: jsonData['age'],
      graduates: List.from(jsonData['graduates']),
    );
  }

  Character toCharacter() {
    return Character(
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      origin: Nationality.values.firstWhere((e) => e.toString() == origin),
      graduates: graduates.map((graduate) => Graduate.values.firstWhere((e) => e.toString() == graduate)).toList(),
    );
  }
}