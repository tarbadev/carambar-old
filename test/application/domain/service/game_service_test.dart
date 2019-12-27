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
        age: 12
      );
      final event = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'Female',
        Nationality.france,
      );

      await gameService.initiate(character);

      verify(Mocks.gameRepository.createGame(event));
    });
  });
}
