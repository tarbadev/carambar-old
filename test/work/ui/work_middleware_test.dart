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

      when(Mocks.workService.getAvailableJobs()).thenReturn(expectedJobs);

      await getAvailableJobs(Mocks.store, getAvailableJobsActions, Mocks.next);

      verify(Mocks.store.dispatch(SetAvailableJobsAction(expectedJobs)));

      verify(Mocks.mockNext.next(getAvailableJobsActions));
    });

    test('on SetJobRequirementsDialogVisibleAction loads the available jobs and dispatches and SetAvailableJobsAction', () async {
      var jobRequirements = 'High school completed successfully';
      var displayJobRequirementsDialogAction = DisplayJobRequirementsDialogAction(Factory.job());

      when(Mocks.workService.getJobRequirements('Supervisor')).thenReturn(jobRequirements);

      await displayJobRequirementsDialog(Mocks.store, displayJobRequirementsDialogAction, Mocks.next);

      verify(Mocks.store.dispatch(SetJobRequirementsAction(jobRequirements)));
      verify(Mocks.store.dispatch(SetJobRequirementsDialogVisibleAction(true)));

      verify(Mocks.mockNext.next(displayJobRequirementsDialogAction));
    });
  });
}
