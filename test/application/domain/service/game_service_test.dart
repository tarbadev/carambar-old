import 'package:carambar/application/domain/entity/game_event.dart';
import 'package:carambar/application/domain/entity/character.dart';
import 'package:carambar/application/domain/entity/initiate_event.dart';
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
  });
}
