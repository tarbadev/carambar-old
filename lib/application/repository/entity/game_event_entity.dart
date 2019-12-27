import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_event_entity.g.dart';

enum EventType { Initiate, IncrementAge, FinishStudies }

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


  factory GameEventEntity.fromEvent(GameEvent event) {
    switch (event.runtimeType) {
      case GameEvent:
        return GameEventEntity.fromGameEvent(event);
        break;
      case InitiateEvent:
        return GameEventEntity.fromInitiateEvent(event);
        break;
      case FinishStudiesEvent:
        return GameEventEntity.fromFinishStudiesEvent(event);
        break;
      default:
        throw GameEventTypeNotKnownException();
    }
  }

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

  GameEventEntity.fromFinishStudiesEvent(FinishStudiesEvent finishStudiesEvent)
      : age = finishStudiesEvent.age,
        eventType = EventType.FinishStudies,
        event = null;

  GameEvent toEvent() {
    if (eventType == EventType.Initiate) {
      return _toInitiateEvent();
    } else if (eventType == EventType.IncrementAge) {
      return _toGameEvent();
    } else if (eventType == EventType.FinishStudies) {
      return _toFinishStudiesEvent();
    } else {
      throw GameEventTypeNotKnownException();
    }
  }

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

  FinishStudiesEvent _toFinishStudiesEvent() => FinishStudiesEvent(age);
}

class GameEventTypeNotKnownException implements Exception {}