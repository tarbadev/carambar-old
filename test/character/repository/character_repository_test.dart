import 'dart:io';

import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/repository/character_repository.dart';
import 'package:flutter/services.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/storage/storage.dart';

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

  group('CharacterRepository', () {
    CharacterRepository characterRepository;
    CharacterStorage characterStorage;

    setUp(() async {
      characterStorage = CharacterStorage();
      await characterStorage.delete();
      characterRepository = CharacterRepository(characterStorage.fileName);
    });

    test('save saves character to file', () async {
      final character = Factory.character(graduates: [Graduate.MiddleSchool], job: Factory.job());

      await characterRepository.save(character);

      final expectedJsonString = '{' +
          '"firstName":"john",' +
          '"lastName":"doe",' +
          '"gender":"male",' +
          '"origin":"Nationality.unitedStates",' +
          '"age":18,' +
          '"graduates":["Graduate.MiddleSchool"],' +
          '"job":{' +
            '"id":1,' +
            '"name":"Supervisor",' +
            '"salary":15000.0,' +
            '"requirements":["Requirement.HighSchool"]' +
            '}' +
          '}';

      expect(await characterStorage.read(), expectedJsonString);
    });

    test('save saves character to file when job is null', () async {
      final character = Factory.character(graduates: [Graduate.MiddleSchool], job: null);

      await characterRepository.save(character);

      final expectedJsonString = '{' +
          '"firstName":"john",' +
          '"lastName":"doe",' +
          '"gender":"male",' +
          '"origin":"Nationality.unitedStates",' +
          '"age":18,' +
          '"graduates":["Graduate.MiddleSchool"],' +
          '"job":null'
          '}';

      expect(await characterStorage.read(), expectedJsonString);
    });

    test('readCharacter reads character from file', () async {
      final character = Factory.character(job: Factory.job());
      await characterStorage.store(character);

      Character returnedCharacter = await characterRepository.readCharacter();

      expect(returnedCharacter, character);
    });

    test('readCharacter reads character from file when job is null', () async {
      final character = Factory.character(job: null);
      await characterStorage.store(character);

      Character returnedCharacter = await characterRepository.readCharacter();

      expect(returnedCharacter, character);
    });

    test('readCharacter returns null when there is no existing file', () async {
      Character returnedCharacter = await characterRepository.readCharacter();

      expect(returnedCharacter, isNull);
    });

    test('delete removes the file', () async {
      final character = Factory.character();
      await characterStorage.store(character);

      await characterRepository.delete();

      expect(await characterStorage.read(), isNull);
    });
  });
}
