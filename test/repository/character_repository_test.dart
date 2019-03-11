import 'dart:convert';
import 'dart:io';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/repository/entity/character_entity.dart';
import 'package:flutter/services.dart';
import 'package:test_api/test_api.dart';
import 'package:path_provider/path_provider.dart';

import '../factory.dart';
import '../helpers/storage/storage.dart';

void main() {
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

  group("CharacterRepository", () {
    CharacterRepository characterRepository;
    CharacterStorage characterStorage;

    setUp(() async {
      characterStorage = CharacterStorage();
      await characterStorage.delete();
      characterRepository = CharacterRepository(characterStorage.fileName);
    });

    test('save saves character to file', () async {
      final character = Factory.character();

      await characterRepository.save(character);

      final expectedJsonString = '{' +
          '"firstName":"john",' +
          '"lastName":"doe",' +
          '"sex":"male",' +
          '"origin":"Nationality.unitedStates",' +
          '"age":18' +
          '}';

      expect(await characterStorage.read(), expectedJsonString);
    });

    test('readCharacter reads character from file', () async {
      final character = Factory.character();
      await characterStorage.store(character);

      Character returnedCharacter = await characterRepository.readCharacter();

      expect(returnedCharacter, character);
    });

    test('readCharacter returns null when there is no existing file', () async {
      Character returnedCharacter = await characterRepository.readCharacter();

      expect(returnedCharacter, isNull);
    });
  });
}
