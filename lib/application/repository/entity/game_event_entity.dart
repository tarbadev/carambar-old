import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_event_entity.g.dart';

enum EventType { Initiate, IncrementAge, FinishStudies, StartSchool }

@JsonSerializable(nullable: true)
class GameEventEntity extends Equatable {
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
        return _fromGameEvent(event);
        break;
      case InitiateEvent:
        return _fromInitiateEvent(event);
        break;
      case FinishStudiesEvent:
        return _fromFinishStudiesEvent(event);
        break;
      case StartSchoolEvent:
        return _fromStartSchoolEvent(event);
        break;
      default:
        throw GameEventTypeNotKnownException(event.runtimeType);
    }
  }

  static GameEventEntity _fromInitiateEvent(InitiateEvent initiateEvent) {
    return GameEventEntity(
      initiateEvent.age,
      EventType.Initiate,
      <String, dynamic>{
        'firstName': initiateEvent.firstName,
        'lastName': initiateEvent.lastName,
        'gender': initiateEvent.gender,
        'origin': initiateEvent.origin.toString(),
      },
    );
  }

  static GameEventEntity _fromGameEvent(GameEvent gameEvent) {
    return GameEventEntity(gameEvent.age, EventType.IncrementAge, null);
  }

  static GameEventEntity _fromFinishStudiesEvent(
      FinishStudiesEvent finishStudiesEvent) {
    return GameEventEntity(
      finishStudiesEvent.age,
      EventType.FinishStudies,
      null,
    );
  }

  static GameEventEntity _fromStartSchoolEvent(
      StartSchoolEvent startSchoolEvent) {
    return GameEventEntity(
      startSchoolEvent.age,
      EventType.StartSchool,
      <String, dynamic>{
        'school': startSchoolEvent.school.toString(),
      },
    );
  }

  GameEvent toEvent() {
    if (eventType == EventType.Initiate) {
      return _toInitiateEvent();
    } else if (eventType == EventType.IncrementAge) {
      return _toGameEvent();
    } else if (eventType == EventType.FinishStudies) {
      return _toFinishStudiesEvent();
    } else if (eventType == EventType.StartSchool) {
      return _toStartSchoolEvent();
    } else {
      throw GameEventTypeNotKnownException(eventType);
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

  StartSchoolEvent _toStartSchoolEvent() {
    return StartSchoolEvent(
      age,
      School.values.firstWhere((e) => e.toString() == event['school'] as String),
    );
  }

  @override
  List<Object> get props => [age, eventType, event];
}

class GameEventTypeNotKnownException implements Exception {
  final unknownType;

  GameEventTypeNotKnownException(this.unknownType);

  String toString() {
    if (unknownType == null) return "GameEventTypeNotKnownException";
    return "GameEventTypeNotKnownException: Unknown type ($unknownType)";
  }
}
