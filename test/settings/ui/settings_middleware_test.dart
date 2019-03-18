import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/settings/ui/settings_actions.dart';
import 'package:carambar/settings/ui/settings_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

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

      verify(Mocks.characterService.deleteCharacter());
      verify(Mocks.ageEventService.deleteAgeEvents());

      verify(Mocks.store.dispatch(InitiateStateAction()));
      verify(Mocks.store.dispatch(SelectHomeTabAction()));

      verify(Mocks.mockNext.next(endLifeAction));
    });
  });
}
