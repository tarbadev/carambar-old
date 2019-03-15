import 'package:carambar/service/age_event_service.dart';
import 'package:carambar/service/character_service.dart';
import 'package:carambar/ui/presenter/display_character.dart';

class CharacterPresenter {
  final CharacterService _characterService;
  final AgeEventService _ageEventService;

  CharacterPresenter(this._characterService, this._ageEventService);

  Future<DisplayCharacter> getDisplayCharacter() async {
    var character = await _characterService.getCharacter();

    if (character == null) {
      character = await _characterService.generateCharacter();
      var displayCharacter = DisplayCharacter.fromCharacter(character);

      var newCharacterEvent = '''
      You just started your life!
      You're a baby ${displayCharacter.genderChild.toLowerCase()} named ${displayCharacter.name} from ${displayCharacter.origin}
      '''
          .split('\n')
          .map((line) => line.trim())
          .reduce((line1, line2) => line2.isNotEmpty ? '$line1\n$line2' : line1);
      await _ageEventService.addEvent(character.age, event: newCharacterEvent);
    }

    return DisplayCharacter.fromCharacter(character);
  }

  Future<void> incrementAge() async => await _characterService.incrementAge();

  Future<void> endLife() async {
    await _characterService.deleteCharacter();
    await _ageEventService.deleteAgeEvents();
  }
}
