import 'package:carambar/application/domain/entity/add_cash_event.dart';
import 'package:carambar/application/domain/entity/add_job_apply_failure_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:carambar/application/domain/entity/set_current_job_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/work/domain/entity/job.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/mock_definition.dart';

void main() {
  group('GameService', () {
    GameService gameService;

    setUp(() {
      gameService = GameService(Mocks.gameRepository);
      reset(Mocks.gameRepository);
    });

    test('initiate generates an event from character and stores it', () async {
      final character = Character(
          firstName: 'firstName',
          lastName: 'lastName',
          gender: 'Female',
          origin: Nationality.france,
          age: 12);
      final event = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'Female',
        Nationality.france,
      );
      final gameEvents = [event];

      when(Mocks.gameRepository.save(any)).thenAnswer((_) async => gameEvents);

      expect(await gameService.initiate(character), gameEvents);

      verify(Mocks.gameRepository.save(gameEvents));
    });

    test('incrementAge generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var initiateEvent = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'Female',
        Nationality.france,
      );
      final events = [previousEvent, initiateEvent];
      final expectedEvents = [previousEvent, initiateEvent, GameEvent(13)];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(await gameService.incrementAge(), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('finishStudies generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var finishStudiesEvent = FinishStudiesEvent(11);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, finishStudiesEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(await gameService.finishStudies(), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('startSchool generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var startSchoolEvent = StartSchoolEvent(11, School.Kindergarten);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, startSchoolEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(
          await gameService.startSchool(School.Kindergarten), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('graduate generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var graduateEvent = GraduateEvent(11, School.HighSchool);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, graduateEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(await gameService.graduate(School.HighSchool), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('addCash generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var graduateEvent = AddCashEvent(11, 2000);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, graduateEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(await gameService.addCash(2000), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('setCurrentJob generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var graduateEvent = SetCurrentJobEvent(11, 34);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, graduateEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(
          await gameService.setCurrentJob(Factory.job(id: 34)), expectedEvents);

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('addJobApplyFailure generates an event and stores it', () async {
      var previousEvent = GameEvent(11);
      var graduateEvent = AddJobApplyFailureEvent(11, 34, Requirement.values);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, graduateEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);
      when(Mocks.gameRepository.save(any))
          .thenAnswer((_) async => expectedEvents);

      expect(
        await gameService.addJobApplyFailure(
            Factory.job(id: 34), Requirement.values),
        expectedEvents,
      );

      var actual =
          verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('getEvents returns the events', () async {
      final events = [
        InitiateEvent(12, 'John', 'Doe', 'Male', Nationality.france)
      ];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);

      expect(await gameService.getEvents(), events);
    });

    test('getEvents when no existing data returns the []', () async {
      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => null);

      expect(await gameService.getEvents(), []);
    });

    test('deleteGameEvents', () async {
      await gameService.deleteGameEvents();

      verify(Mocks.gameRepository.delete());
    });
  });
}
