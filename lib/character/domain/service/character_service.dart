import 'package:carambar/character/domain/entity/character.dart';
import 'package:carambar/character/domain/service/client/character_client.dart';
import 'package:carambar/character/repository/character_repository.dart';

class CharacterService {
  final CharacterRepository _characterRepository;
  final CharacterClient _characterClient;

  CharacterService(this._characterRepository, this._characterClient);

  Future<Character> getCharacter() async {
    return await _characterRepository.readCharacter();
  }

  Future<Character> incrementAge() async {
    Character character = await _characterRepository.readCharacter();
    character.age++;

    await _characterRepository.save(character);

    return character;
  }

  Future<Character> generateCharacter() async {
    var character = await _characterClient.generateCharacter();
    character.age = 0;

    await _characterRepository.save(character);

    return character;
  }

  Future<void> deleteCharacter() async => await _characterRepository.delete();

  Future<Character> addGraduate(Graduate graduate) async {
    Character character = await _characterRepository.readCharacter();
    character.graduates.add(graduate);

    await _characterRepository.save(character);

    return character;
  }
}