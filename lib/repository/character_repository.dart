import 'dart:convert';
import 'dart:io';

import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/entity/character_entity.dart';
import 'package:path_provider/path_provider.dart';

class CharacterRepository {
  final String _fileName;

  CharacterRepository(this._fileName);

  Future<String> get _filePath async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<File> get _file async {
    return File('${await _filePath}/$_fileName');
  }

  Future<void> save(Character character) async {
    var characterEntity = CharacterEntity.fromCharacter(character);

    await (await _file).writeAsString(jsonEncode(characterEntity));
  }
}