import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/entity/character_entity.dart';
import 'package:carambar/repository/internal_file_repository.dart';

class CharacterRepository extends InternalFileRepository {
  CharacterRepository(String fileName) : super(fileName);

  Future<void> save(Character character) async {
    var characterEntity = CharacterEntity.fromCharacter(character);

    await write(characterEntity);
  }

  Future<Character> readCharacter() async {
    String characterFileContent = await read();

    if (characterFileContent == null) {
      return null;
    }

    CharacterEntity characterEntity = CharacterEntity.fromJson(characterFileContent);
    return characterEntity.toCharacter();
  }
}
