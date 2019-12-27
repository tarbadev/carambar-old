import 'dart:io';

import 'package:carambar/application/domain/entity/initiate_event.dart';
import 'package:carambar/application/repository/game_repository.dart';
import 'package:carambar/application/domain/entity/nationality.dart';
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

    test('createGame saves initiateEvent to event list', () async {
      final initiateEvent = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'male',
        Nationality.france,
      );

      await gameRepository.createGame(initiateEvent);

      final expectedJsonString = '[{' +
          '"age":12,' +
          '"event":{' +
          '"firstName":"firstName",' +
          '"lastName":"lastName",' +
          '"gender":"male",' +
          '"origin":"Nationality.france"' +
          '}' +
          '}]';

      expect(await gameStorage.read(), expectedJsonString);
    });
  });
}