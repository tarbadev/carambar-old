import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:carambar/settings/ui/tab/settings_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/settings_tab_view.dart';

void main() {
  setUp(() {
    Mocks.setupMockStore();
  });

  testWidgets('Settings Tab dispatches an endLife action when "End Life" button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab()));

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    await settingsTabView.clickOnEndLifeButton();
    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.confirmEndLife();

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    verify(Mocks.mockStore.dispatch(EndLifeAction()));
  });
}
