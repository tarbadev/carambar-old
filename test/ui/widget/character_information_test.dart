import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../factory.dart';
import '../../helpers/testable_widget.dart';
import '../../helpers/view/character_tab_view.dart';

void main() {
  testWidgets('home shows a the character informations',
      (WidgetTester tester) async {
    var displayCharacter = Factory.displayCharacter();
    var characterInformationView = CharacterTabView(tester);

    await tester.pumpWidget(buildTestableWidget(
        CharacterInformation(displayCharacter: displayCharacter)));

    expect(characterInformationView.getCharacterName(), displayCharacter.name);
    expect(
        characterInformationView.getCharacterGender(), displayCharacter.gender);
    expect(
        characterInformationView.getCharacterOrigin(), displayCharacter.origin);
    expect(characterInformationView.getCharacterAge(), displayCharacter.age);
    expect(characterInformationView.getCharacterAgeCategory(),
        displayCharacter.ageCategory);
  });
}
