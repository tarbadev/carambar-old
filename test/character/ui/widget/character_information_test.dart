import 'package:carambar/character/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/fake_application_injector.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/character_tab_view.dart';

void main() {
  setupDependencyInjectorForTest();

  testWidgets('home shows a the character informations', (WidgetTester tester) async {
    var displayCharacter = Factory.displayCharacter(job: Factory.displayJob());
    var characterTabView = CharacterTabView(tester);

    await tester.pumpWidget(buildTestableWidget(CharacterInformation(displayCharacter: displayCharacter)));

    expect(characterTabView.name, displayCharacter.name);
    expect(characterTabView.gender, displayCharacter.gender);
    expect(characterTabView.origin, displayCharacter.origin);
    expect(characterTabView.age, displayCharacter.age);
    expect(characterTabView.ageCategory, displayCharacter.ageCategory);
    expect(characterTabView.school, displayCharacter.school);
    expect(characterTabView.graduates, displayCharacter.graduates);
    expect(characterTabView.job, displayCharacter.job.name);
    expect(characterTabView.salary, displayCharacter.job.salary);
  });
}
