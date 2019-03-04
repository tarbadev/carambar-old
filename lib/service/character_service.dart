import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/internal_file_repository.dart';
import 'package:carambar/service/client/character_client.dart';

class CharacterService {
  final InternalFileRepository _internalFileRepository;
  final CharacterClient _characterClient;

  CharacterService(this._internalFileRepository, this._characterClient);

  Future<Character> getCharacter() async {
    var character = await _characterClient.generateCharacter();
    _internalFileRepository.save(character);

    return character;
  }
}