import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/graduate_event.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/domain/entity/start_school_event.dart';
import 'package:carambar/application/domain/service/game_service.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mock_definition.dart';

void main() {
  group('GameService', () {
    GameService gameService;

    setUp(() {
      gameService = GameService(Mocks.gameRepository);
      reset(Mocks.gameRepository);
    });

    test('initiate generates event from character and stores it', () async {
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

      await gameService.initiate(character);

      verify(Mocks.gameRepository.save([event]));
    });

    test('incrementAge generates event and stores it', () async {
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

      await gameService.incrementAge();

      var actual = verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('finishStudies generates event and stores it', () async {
      var previousEvent = GameEvent(11);
      var finishStudiesEvent = FinishStudiesEvent(11);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, finishStudiesEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);

      await gameService.finishStudies();

      var actual = verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('startSchool generates event and stores it', () async {
      var previousEvent = GameEvent(11);
      var startSchoolEvent = StartSchoolEvent(11, School.Kindergarten);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, startSchoolEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);

      await gameService.startSchool(School.Kindergarten);

      var actual = verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });

    test('graduate generates event and stores it', () async {
      var previousEvent = GameEvent(11);
      var graduateEvent = GraduateEvent(11, School.HighSchool);
      final events = [previousEvent];
      final expectedEvents = [previousEvent, graduateEvent];

      when(Mocks.gameRepository.readEvents()).thenAnswer((_) async => events);

      await gameService.startSchool(School.Kindergarten);

      var actual = verify(Mocks.gameRepository.save(captureAny)).captured.single;
      expect(actual, expectedEvents);
    });
  });
}
