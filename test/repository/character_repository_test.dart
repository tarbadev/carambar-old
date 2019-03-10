import 'dart:convert';
import 'dart:io';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/repository/entity/character_entity.dart';
import 'package:flutter/services.dart';
import 'package:test_api/test_api.dart';
import 'package:path_provider/path_provider.dart';

import '../factory.dart';

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
    InternalFileUtil internalFileUtil;

    setUp(() {
      internalFileUtil = InternalFileUtil();
      characterRepository = CharacterRepository(internalFileUtil.fileName);
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

      expect(await internalFileUtil.read(), expectedJsonString);
    });

    test('read reads character from file', () async {
      final character = Factory.character();
      await internalFileUtil.save(jsonEncode(CharacterEntity.fromCharacter(character)));

      Character returnedCharacter = await characterRepository.read();

      expect(returnedCharacter, character);
    });
  });
}

class InternalFileUtil {
  final String fileName = "testFile.json";

  Future<String> get filePath async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<File> get _file async {
    return File('${await filePath}/$fileName');
  }

  Future<void> save(String textToSave) async {
    await (await _file).writeAsString(textToSave);
  }

  Future<String> read() async {
    try {
      return await (await _file).readAsString();
    } catch (e) {
      return null;
    }
  }
}
