import 'package:carambar/ui/settings_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fake_application_injector.dart';
import '../helpers/testable_widget.dart';
import '../helpers/view/settings_tab_view.dart';
import '../mock_definition.dart';

void main() {
  setupTest();

  testWidgets('Settings Tab calls endLife when "End Life" button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab()));

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    await settingsTabView.clickOnEndLifeButton();
    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.confirmEndLife();

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    verify(Mocks.characterPresenter.endLife());
  });
}
