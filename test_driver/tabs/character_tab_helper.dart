import 'base_view_driver.dart';

class CharacterTabHelper extends BaseViewDriver {
  CharacterTabHelper(driver) : super(driver);

  Future<String> get name async => await getTextByKey('Character__Name');
  Future<String> get gender async => await getTextByKey('Character__Gender');
  Future<String> get origin async => await getTextByKey('Character__Origin');
  Future<String> get age async => await getTextByKey('Character__Age');
  Future<String> get ageCategory async => await getTextByKey('Character__AgeCategory');
  Future<String> get school async => await getTextByKey('Character__School');
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
  Future<String> get job async => await getTextByKey('Character__Job');
  Future<String> get salary async => await getTextByKey('Character__Salary');

  Future<void> goTo() async {
    await tapOnButtonByKey('Home__BottomNavigationCharacter');
  }
}