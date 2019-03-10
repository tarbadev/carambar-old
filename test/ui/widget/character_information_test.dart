import 'package:carambar/ui/util/string_utils.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../factory.dart';
import '../../fake_application_injector.dart';
import '../../helpers/view/character_information_view.dart';
import '../../helpers/testable_widget.dart';

void main() {
  setupTest();

  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    var character = Factory.character(age: 34);
    var characterInformationView = CharacterInformationView(tester);

    await tester.pumpWidget(
        buildTestableWidget(CharacterInformation(character: character)));

    expect(characterInformationView.getCharacterName(),
        "${StringUtils.capitalize(character.firstName)} ${StringUtils.capitalize(character.lastName)}");
    expect(characterInformationView.getCharacterSex(),
        "${StringUtils.capitalize(character.sex)}");
    expect(characterInformationView.getCharacterOrigin(),
        "${StringUtils.capitalize(character.origin)}");
    expect(characterInformationView.getCharacterAge(), "${character.age}");
  });
}
