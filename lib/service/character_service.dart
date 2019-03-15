import 'package:carambar/domain/entity/character.dart';
import 'package:carambar/repository/character_repository.dart';
import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/service/client/character_client.dart';

class CharacterService {
  final CharacterRepository _characterRepository;
  final CharacterClient _characterClient;
  final AgeEventService _ageEventService;

  CharacterService(this._characterRepository, this._characterClient, this._ageEventService);

  Future<Character> getCharacter() async {
    return await _characterRepository.readCharacter();
  }

  Future<void> incrementAge() async {
    Character character = await _characterRepository.readCharacter();
    character.age++;

    await _ageEventService.addEvent(character.age);

    await _characterRepository.save(character);
  }

  Future<Character> generateCharacter() async {
    var character = await _characterClient.generateCharacter();
    character.age = 0;

    await _characterRepository.save(character);

    return character;
  }

  Future<void> deleteCharacter() async => await _characterRepository.delete();
}