import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/client/character_client.dart';

class CharacterService {
  final CharacterRepository _internalFileRepository;
  final CharacterClient _characterClient;

  CharacterService(this._internalFileRepository, this._characterClient);

  Future<Character> getCharacter() async {
    var character = await _characterClient.generateCharacter();
    character.age = 0;
    _internalFileRepository.save(character);

    return character;
  }
}