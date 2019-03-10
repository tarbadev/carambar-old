import 'package:carambar/ui/character_tab.dart';
import 'package:carambar/ui/widget/character_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../factory.dart';
import '../fake_application_injector.dart';
import '../helpers/testable_widget.dart';
import '../mock_definition.dart';

void main() {
  setupTest();

  testWidgets('character tab shows a the character informations',
      (WidgetTester tester) async {
    when(Mocks.characterService.getCharacter())
        .thenAnswer((_) async => Factory.character());

    await tester.pumpWidget(buildTestableWidget(CharacterTab()));

    expect(find.byType(CharacterInformation), findsNothing);

    await tester.pump();

    expect(find.byType(CharacterInformation), findsOneWidget);
  });
}


