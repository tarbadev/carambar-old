import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/presenter/display_character.dart';

class CharacterPresenter {
  final CharacterService _characterService;

  CharacterPresenter(this._characterService);

  Future<DisplayCharacter> getDisplayCharacter() async {
    return DisplayCharacter.fromCharacter(await _characterService.getCharacter());
  }

  Future<void> incrementAge() async => await _characterService.incrementAge();
}