import 'base_view_driver.dart';

class CharacterTabHelper extends BaseViewDriver {
  CharacterTabHelper(driver) : super(driver);

  Future<String> get name async => await getTextByKey('characterName');
  Future<String> get gender async => await getTextByKey('characterGender');
  Future<String> get origin async => await getTextByKey('characterOrigin');
  Future<String> get age async => await getTextByKey('characterAge');
  Future<String> get ageCategory async => await getTextByKey('characterAgeCategory');
  Future<String> get school async => await getTextByKey('characterSchool');
  Future<List<String>> get graduates async {
    List<String> graduates = [];
    try {
      var index = 0;
      do {
        graduates.add(await getTextByKey(
            'Character__graduates__${index++}',
            timeout: Duration(milliseconds: 500)));
      } while (true);
    } catch (_) {}

    return graduates;
  }

  Future<void> goTo() async {
    await tapOnButtonByKey('bottomNavigationCharacter');
  }
}