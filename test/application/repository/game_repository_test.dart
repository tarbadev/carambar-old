import 'dart:io';

import 'package:carambar/application/domain/entity/finish_studies_event.dart';
import 'package:carambar/application/domain/entity/game_event.dart';
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

    test('save saves events', () async {
      final initiateEvent = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'male',
        Nationality.france,
      );
      final events = [GameEvent(11), initiateEvent, FinishStudiesEvent(12)];

      expect(await gameRepository.save(events), events);

      final expectedJsonString = '[{' +
          '"age":11,' +
          '"eventType":"IncrementAge",' +
          '"event":null' +
          '},' +
          '{' +
          '"age":12,' +
          '"eventType":"Initiate",' +
          '"event":{' +
          '"firstName":"firstName",' +
          '"lastName":"lastName",' +
          '"gender":"male",' +
          '"origin":"Nationality.france"' +
          '}' +
          '},{' +
          '"age":12,' +
          '"eventType":"FinishStudies",' +
          '"event":null' +
          '}]';

      expect(await gameStorage.read(), expectedJsonString);
    });

    test('readEvents reads character from file when job is null', () async {
      final initiateEvent = InitiateEvent(
        12,
        'firstName',
        'lastName',
        'male',
        Nationality.france,
      );
      final events = [GameEvent(11), initiateEvent, FinishStudiesEvent(12)];
      await gameStorage.store(events);

      final actual = await gameRepository.readEvents();

      expect(actual, events);
    });

    test('readEvents when no file present returns null', () async {
      expect(await gameRepository.readEvents(), isNull);
    });
  });
}
