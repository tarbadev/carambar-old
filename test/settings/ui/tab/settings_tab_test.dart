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

  testWidgets('Settings Tab dispatches a SetEndLifeDialogVisibleAction when "End Life" button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab(), isEndLifeDialogVisible: false));

    expect(settingsTabView.endLifeDialog.isVisible, isFalse);

    await settingsTabView.clickOnEndLifeButton();

    verify(Mocks.mockStore.dispatch(SetEndLifeDialogVisibleAction(true)));
  });

  testWidgets('Settings Tab dispatches an EndLifeAction when confirm button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab(), isEndLifeDialogVisible: true));
    await tester.pump();

    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.confirmEndLife();

    verify(Mocks.mockStore.dispatch(EndLifeAction()));
  });

  testWidgets('Settings Tab dispatches an SetEndLifeDialogVisibleAction when confirm button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab(), isEndLifeDialogVisible: true));
    await tester.pump();

    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.confirmEndLife();

    verify(Mocks.mockStore.dispatch(SetEndLifeDialogVisibleAction(false)));
  });

  testWidgets('Settings Tab dispatches an SetEndLifeDialogVisibleAction when cancel button is pressed',
      (WidgetTester tester) async {
    var settingsTabView = SettingsTabView(tester);
    await tester.pumpWidget(buildTestableWidget(SettingsTab(), isEndLifeDialogVisible: true));
    await tester.pump();

    expect(settingsTabView.endLifeDialog.isVisible, isTrue);
    await settingsTabView.endLifeDialog.cancelEndLife();

    verify(Mocks.mockStore.dispatch(SetEndLifeDialogVisibleAction(false)));
  });
}
