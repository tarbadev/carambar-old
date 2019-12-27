import 'dart:convert';

import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:json_annotation/json_annotation.dart';

part 'initiate_event_entity.g.dart';

@JsonSerializable(nullable: true)
class InitiateEventEntity {
  final int age;
  final String firstName;
  final String lastName;
  final String gender;
  final String origin;

  InitiateEventEntity(
    this.age,
    this.firstName,
    this.lastName,
    this.gender,
    this.origin,
  );

  factory InitiateEventEntity.fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return _$InitiateEventEntityFromJson(jsonData);
  }

  Map<String, dynamic> toJson() => _$InitiateEventEntityToJson(this);

  InitiateEventEntity.fromInitiateEvent(InitiateEvent character)
      : firstName = character.firstName,
        lastName = character.lastName,
        gender = character.gender,
        origin = character.origin.toString(),
        age = character.age;

  InitiateEvent toInitiateEvent() {
    return InitiateEvent(
      age,
      firstName,
      lastName,
      gender,
      Nationality.values.firstWhere((e) => e.toString() == origin),
    );
  }
}
