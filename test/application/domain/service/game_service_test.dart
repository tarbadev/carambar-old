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

    test('generateGame generates a new game and saves it', () async {
      final event = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'Female',
        Nationality.france,
      );

      await gameService.addEvent(event);

      verify(Mocks.gameRepository.save([event]));
    });
  });
}
