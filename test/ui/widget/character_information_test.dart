import 'package:carambar/ui/util/string_utils.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../factory.dart';
import '../../fake_application_injector.dart';
import '../../helpers/view/character_tab_view.dart';
import '../../helpers/testable_widget.dart';

void main() {
  setupTest();

  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    var character = Factory.character(age: 2);
    var characterInformationView = CharacterTabView(tester);

    await tester.pumpWidget(
        buildTestableWidget(CharacterInformation(character: character)));

    expect(characterInformationView.getCharacterName(),
        '${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}');
    expect(characterInformationView.getCharacterSex(),
        '${StringUtils.capitalize(character.sex)}');
    expect(characterInformationView.getCharacterOrigin(), 'United States');
    expect(characterInformationView.getCharacterAge(), '${character.age}');
    expect(characterInformationView.getCharacterAgeCategory(), 'Baby');
  });
}
