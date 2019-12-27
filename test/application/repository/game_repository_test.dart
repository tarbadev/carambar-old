import 'dart:io';

import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/game_repository.dart';
import 'package:carambar/character/domain/entity/nationality.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/storage/storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp();

    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  group('GameRepository', () {
    GameRepository gameRepository;
    GameStorage gameStorage;

    setUp(() async {
      gameStorage = GameStorage();
      await gameStorage.delete();
      gameRepository = GameRepository(gameStorage.fileName);
    });

    test('save saves initiateEvent to file', () async {
      final initiateEvent = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'male',
        Nationality.france,
      );

      await gameRepository.save([initiateEvent]);

      final expectedJsonString = '[{' +
          '"age":12,' +
          '"firstName":"firstName",' +
          '"lastName":"lastName",' +
          '"gender":"male",' +
          '"origin":"Nationality.france"' +
          '}]';

      expect(await gameStorage.read(), expectedJsonString);
    });
  });
}
