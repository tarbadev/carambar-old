import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/increment_job_experience_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_event_entity.g.dart';

enum EventType {
  Initiate,
  IncrementAge,
  FinishStudies,
  StartSchool,
  Graduate,
  IncrementJobExperience,
  AddCash,
  SetCurrentJob,
}

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
      case GraduateEvent:
        return _fromGraduateEvent(event);
        break;
      case IncrementJobExperienceEvent:
        return _fromIncrementJobExperienceEvent(event);
        break;
      case AddCashEvent:
        return _fromAddCashEvent(event);
        break;
      case SetCurrentJobEvent:
        return _fromSetCurrentJobEvent(event);
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

  static GameEventEntity _fromGraduateEvent(GraduateEvent graduateEvent) {
    return GameEventEntity(
      graduateEvent.age,
      EventType.Graduate,
      <String, dynamic>{
        'school': graduateEvent.school.toString(),
      },
    );
  }

  static GameEventEntity _fromIncrementJobExperienceEvent(
      IncrementJobExperienceEvent incrementJobExperienceEvent) {
    return GameEventEntity(
      incrementJobExperienceEvent.age,
      EventType.IncrementJobExperience,
      null,
    );
  }

  static GameEventEntity _fromAddCashEvent(AddCashEvent addCashEvent) {
    return GameEventEntity(
      addCashEvent.age,
      EventType.AddCash,
      <String, dynamic>{
        'amount': addCashEvent.amount,
      },
    );
  }

  static GameEventEntity _fromSetCurrentJobEvent(SetCurrentJobEvent setCurrentJobEvent) {
    return GameEventEntity(
      setCurrentJobEvent.age,
      EventType.SetCurrentJob,
      <String, dynamic>{
        'jobId': setCurrentJobEvent.jobId,
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
    } else if (eventType == EventType.Graduate) {
      return _toGraduateEvent();
    } else if (eventType == EventType.IncrementJobExperience) {
      return _toIncrementJobExperienceEvent();
    } else if (eventType == EventType.AddCash) {
      return _toAddCashEvent();
    } else if (eventType == EventType.SetCurrentJob) {
      return _toSetCurrentJobEvent();
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
      School.values
          .firstWhere((e) => e.toString() == event['school'] as String),
    );
  }

  GraduateEvent _toGraduateEvent() {
    return GraduateEvent(
      age,
      School.values
          .firstWhere((e) => e.toString() == event['school'] as String),
    );
  }

  IncrementJobExperienceEvent _toIncrementJobExperienceEvent() =>
      IncrementJobExperienceEvent(age);

  AddCashEvent _toAddCashEvent() {
    return AddCashEvent(
      age,
      event['amount'] as double,
    );
  }

  SetCurrentJobEvent _toSetCurrentJobEvent() {
    return SetCurrentJobEvent(
      age,
      event['jobId'],
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
