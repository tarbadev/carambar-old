import 'package:carambar/work/ui/work_actions.dart';
import 'package:carambar/work/ui/work_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group("Work Middleware", () {
    setUp(() {
      Mocks.setupMockStore();
    });

    test('on GetAvailableJobsAction loads the available jobs and dispatches and SetAvailableJobsAction', () async {
      var expectedJobs = [Factory.job()];
      var getAvailableJobsActions = GetAvailableJobsAction();

      when(Mocks.workService.getAvailableJobs()).thenAnswer((_) async => expectedJobs);

      await getAvailableJobs(Mocks.store, getAvailableJobsActions, Mocks.next);

      verify(Mocks.store.dispatch(SetAvailableJobsAction(expectedJobs)));

      verify(Mocks.mockNext.next(getAvailableJobsActions));
    });
  });
}
