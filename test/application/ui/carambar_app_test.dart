import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/carambar_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';
import '../../helpers/testable_widget.dart';
import '../../helpers/view/carambar_app_view.dart';

void main() {
  setupDependencyInjectorForTest();

  testWidgets('Carambar App dispatches the InitiateStateAction on build', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CarambarApp()));

    verify(Mocks.store.dispatch(InitiateStateAction()));
  });

  testWidgets('Carambar App dispatches the SelectTabAction on button tab tapped', (WidgetTester tester) async {
    final carambarAppView = CarambarAppView(tester);
    await tester.pumpWidget(buildTestableWidget(CarambarApp()));

    await carambarAppView.clickOnHomeTab();
    verify(Mocks.store.dispatch(SelectTabAction(0)));

    await carambarAppView.clickOnCharacterTab();
    verify(Mocks.store.dispatch(SelectTabAction(1)));

    await carambarAppView.clickOnWorkTab();
    verify(Mocks.store.dispatch(SelectTabAction(2)));

    await carambarAppView.clickOnSettingsTab();
    verify(Mocks.store.dispatch(SelectTabAction(3)));
  });

  testWidgets('Carambar App displays the amount of cash available', (WidgetTester tester) async {
    final carambarAppView = CarambarAppView(tester);
    await tester.pumpWidget(buildTestableWidget(CarambarApp(), availableCash: 4350.45));

    expect(carambarAppView.getAvailableCash(), '\$4,350.45');
  });
}