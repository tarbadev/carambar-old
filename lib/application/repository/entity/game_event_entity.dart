import 'dart:convert';

import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_event_entity.g.dart';

enum EventType { Initiate, IncrementAge }

@JsonSerializable(nullable: true)
class GameEventEntity {
  final int age;
  final EventType eventType;
  final Map<String, dynamic> event;

  GameEventEntity(
    this.age,
    this.eventType,
    this.event,
  );

  factory GameEventEntity.fromJson(Map<String, dynamic> jsonData) {
    return _$GameEventEntityFromJson(jsonData);
  }

  Map<String, dynamic> toJson() => _$GameEventEntityToJson(this);

  GameEventEntity.fromInitiateEvent(InitiateEvent initiateEvent)
      : age = initiateEvent.age,
        eventType = EventType.Initiate,
        event = <String, dynamic>{
          'firstName': initiateEvent.firstName,
          'lastName': initiateEvent.lastName,
          'gender': initiateEvent.gender,
          'origin': initiateEvent.origin.toString()
        };

  GameEventEntity.fromGameEvent(GameEvent gameEvent)
      : age = gameEvent.age,
        eventType = EventType.IncrementAge,
        event = null;

  InitiateEvent _toInitiateEvent() {
    return InitiateEvent(
      age,
      event['firstName'] as String,
      event['lastName'] as String,
      event['gender'] as String,
      Nationality.values
          .firstWhere((e) => e.toString() == event['origin'] as String),
    );
  }

  GameEvent _toGameEvent() => GameEvent(age);

  factory GameEventEntity.fromEvent(GameEvent event) {
    if (event.runtimeType == InitiateEvent)
      return GameEventEntity.fromInitiateEvent(event);
    else if (event.runtimeType == GameEvent) {
      return GameEventEntity.fromGameEvent(event);
    } else
      return null;
  }

  GameEvent toEvent() {
    if (eventType == EventType.Initiate) {
      return _toInitiateEvent();
    } else if (eventType == EventType.IncrementAge) {
      return _toGameEvent();
    }
  }
}
