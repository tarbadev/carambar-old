import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/home/ui/home_actions.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('Settings Middleware', () {
    setUp(() {
      Mocks.setupMockStore();
    });

    test('endLife calls the services to delete objects and dispatches an initiate action and switch to home tab',
        () async {
      var endLifeAction = EndLifeAction();

      await endLife(Mocks.store, endLifeAction, Mocks.next);

      verify(Mocks.gameService.deleteGameEvents());

      verify(Mocks.store.dispatch(SetAgeEventsAction([])));
      verify(Mocks.store.dispatch(InitiateStateAction()));
      verify(Mocks.store.dispatch(SelectHomeTabAction()));

      verify(Mocks.mockNext.next(endLifeAction));
    });
  });
}
