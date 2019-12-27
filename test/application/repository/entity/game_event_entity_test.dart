import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/increment_job_experience_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/repository/entity/game_event_entity.dart';
import 'package:test/test.dart';

void main() {
  group('GameEventEntity', () {
    group('fromEvent', () {
      test('throws an exception when the type is not known', () {
        expect(
          () => GameEventEntity.fromEvent(TestGameEvent(10)),
          throwsA(TypeMatcher<GameEventTypeNotKnownException>()),
        );
      });

      test('when event is GameEvent', () {
        final gameEvent = GameEvent(10);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.IncrementAge,
          null,
        );
        expect(GameEventEntity.fromEvent(gameEvent), gameEventEntity);
      });

      test('when event is InitiateEvent', () {
        final initiateEvent = InitiateEvent(
          12,
          'firstName',
          'lastName',
          'Female',
          Nationality.france,
        );
        final gameEventEntity = GameEventEntity(
          12,
          EventType.Initiate,
          <String, dynamic>{
            'firstName': initiateEvent.firstName,
            'lastName': initiateEvent.lastName,
            'gender': initiateEvent.gender,
            'origin': initiateEvent.origin.toString(),
          },
        );
        expect(GameEventEntity.fromEvent(initiateEvent), gameEventEntity);
      });

      test('when event is FinishStudiesEvent', () {
        final event = FinishStudiesEvent(10);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.FinishStudies,
          null,
        );
        expect(GameEventEntity.fromEvent(event), gameEventEntity);
      });

      test('when event is StartSchoolEvent', () {
        final event = StartSchoolEvent(10, School.Kindergarten);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.StartSchool,
          <String, dynamic>{'school': 'School.Kindergarten'},
        );
        expect(GameEventEntity.fromEvent(event), gameEventEntity);
      });

      test('when event is GraduateEvent', () {
        final event = GraduateEvent(10, School.Kindergarten);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.Graduate,
          <String, dynamic>{'school': 'School.Kindergarten'},
        );
        expect(GameEventEntity.fromEvent(event), gameEventEntity);
      });

      test('when event is IncrementJobExperienceEvent', () {
        final event = IncrementJobExperienceEvent(10);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.IncrementJobExperience,
          null,
        );
        expect(GameEventEntity.fromEvent(event), gameEventEntity);
      });

      test('when event is AddCashEvent', () {
        final event = AddCashEvent(10, 2000.0);
        final gameEventEntity = GameEventEntity(
          10,
          EventType.AddCash,
          <String, dynamic>{'amount': 2000.0},
        );
        expect(GameEventEntity.fromEvent(event), gameEventEntity);
      });
    });

    group('toEvent', () {
      test('throws an exception when the type is not known', () {
        expect(
          () => GameEventEntity(10, null, null).toEvent(),
          throwsA(TypeMatcher<GameEventTypeNotKnownException>()),
        );
      });

      test('when event is GameEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.IncrementAge,
          null,
        );
        final gameEvent = GameEvent(10);
        expect(gameEventEntity.toEvent(), gameEvent);
      });

      test('when event is InitiateEvent', () {
        final gameEventEntity = GameEventEntity(
          12,
          EventType.Initiate,
          <String, dynamic>{
            'firstName': 'firstName',
            'lastName': 'lastName',
            'gender': 'Female',
            'origin': 'Nationality.france',
          },
        );
        final initiateEvent = InitiateEvent(
          12,
          'firstName',
          'lastName',
          'Female',
          Nationality.france,
        );
        expect(gameEventEntity.toEvent(), initiateEvent);
      });

      test('when event is FinishStudiesEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.FinishStudies,
          null,
        );
        final gameEvent = FinishStudiesEvent(10);
        expect(gameEventEntity.toEvent(), gameEvent);
      });

      test('when event is StartSchoolEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.StartSchool,
          <String, dynamic>{
            'school': 'School.HighSchool',
          },
        );
        final gameEvent = StartSchoolEvent(10, School.HighSchool);
        expect(gameEventEntity.toEvent(), gameEvent);
      });

      test('when event is GraduateEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.Graduate,
          <String, dynamic>{
            'school': 'School.HighSchool',
          },
        );
        final gameEvent = GraduateEvent(10, School.HighSchool);
        expect(gameEventEntity.toEvent(), gameEvent);
      });

      test('when event is IncrementJobExperienceEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.IncrementJobExperience,
          null,
        );
        final gameEvent = IncrementJobExperienceEvent(10);
        expect(gameEventEntity.toEvent(), gameEvent);
      });

      test('when event is AddCashEvent', () {
        final gameEventEntity = GameEventEntity(
          10,
          EventType.AddCash,
          <String, dynamic>{
            'amount': 2000.0,
          },
        );
        final gameEvent = AddCashEvent(10, 2000.0);
        expect(gameEventEntity.toEvent(), gameEvent);
      });
    });
  });
}

class TestGameEvent extends GameEvent {
  TestGameEvent(int age) : super(age);
}
