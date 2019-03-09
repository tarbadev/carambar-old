import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/client/character_client.dart';

class CharacterService {
  final CharacterRepository _characterRepository;
  final CharacterClient _characterClient;

  CharacterService(this._characterRepository, this._characterClient);

  Future<Character> getCharacter() async {
    var character = await _characterRepository.read() ?? await _generateCharacter();

    return character;
  }

  Future<void> incrementAge() async {
    Character character = await _characterRepository.read();
    character.age++;

    await _characterRepository.save(character);
  }

  Future<Character> _generateCharacter() async {
    var character = await _characterClient.generateCharacter();
    character.age = 0;

    await _characterRepository.save(character);

    return character;
  }
}