import 'package:carambar/settings/ui/tab/settings_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/fake_application_injector.dart';
import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/settings_tab_view.dart';

void main() {
  setupWidgetTest();

  testWidgets('Settings Tab calls endLife when "End Life" button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab()));

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    await settingsTabView.clickOnEndLifeButton();
    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.confirmEndLife();

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    verify(Mocks.characterService.deleteCharacter());
    verify(Mocks.ageEventService.deleteAgeEvents());
  });
}
