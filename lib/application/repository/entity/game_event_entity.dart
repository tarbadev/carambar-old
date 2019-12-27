import 'dart:convert';

import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_event_entity.g.dart';

@JsonSerializable(nullable: true)
class GameEventEntity {
  final int age;
  final Map<String, dynamic> event;

  GameEventEntity(
    this.age,
    this.event,
  );

  factory GameEventEntity.fromJson(String characterEntityJson) {
    final jsonData = json.decode(characterEntityJson);
    return _$GameEventEntityFromJson(jsonData);
  }

  Map<String, dynamic> toJson() => _$GameEventEntityToJson(this);

  GameEventEntity.fromInitiateEvent(InitiateEvent initiateEvent)
      : age = initiateEvent.age,
        event = <String, dynamic>{
          'firstName': initiateEvent.firstName,
          'lastName': initiateEvent.lastName,
          'gender': initiateEvent.gender,
          'origin': initiateEvent.origin.toString()
        };

  InitiateEvent toInitiateEvent() {
    return InitiateEvent(
      age,
      event['firstName'] as String,
      event['lastName'] as String,
      event['gender'] as String,
      Nationality.values.firstWhere((e) => e.toString() == event['origin'] as String),
    );
  }
}
