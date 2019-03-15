import 'package:carambar/character/ui/tab/character_tab.dart';
import 'package:carambar/character/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/fake_application_injector.dart';
import '../../../helpers/testable_widget.dart';

void main() {
  setupDependencyInjectorForTest();

  testWidgets('character tab shows a the character informations',
      (WidgetTester tester) async {
    var character = Factory.character();
    var displayCharacter = Factory.displayCharacter();

    await tester.pumpWidget(buildTestableWidget(CharacterTab(), character: character));

    var characterInformationFinder = find.byType(CharacterInformation);
    expect(characterInformationFinder, findsNothing);

    await tester.pump();

    expect(characterInformationFinder, findsOneWidget);

    CharacterInformation characterInformation =
        characterInformationFinder.evaluate().single.widget;
    expect(characterInformation.displayCharacter, displayCharacter);
  });
}
