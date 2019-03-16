import 'package:carambar/character/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/fake_application_injector.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/character_tab_view.dart';

void main() {
  setupDependencyInjectorForTest();

  testWidgets('home shows a the character informations', (WidgetTester tester) async {
    var displayCharacter = Factory.displayCharacter();
    var characterTabView = CharacterTabView(tester);

    await tester.pumpWidget(buildTestableWidget(CharacterInformation(displayCharacter: displayCharacter)));

    expect(characterTabView.getCharacterName(), displayCharacter.name);
    expect(characterTabView.getCharacterGender(), displayCharacter.gender);
    expect(characterTabView.getCharacterOrigin(), displayCharacter.origin);
    expect(characterTabView.getCharacterAge(), displayCharacter.age);
    expect(characterTabView.getCharacterAgeCategory(), displayCharacter.ageCategory);
    expect(characterTabView.getCharacterSchool(), displayCharacter.school);
    expect(characterTabView.getCharacterGraduates(), displayCharacter.graduates);
  });
}
