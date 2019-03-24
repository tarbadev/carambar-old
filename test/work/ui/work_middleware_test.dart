import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/character/ui/character_actions.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:carambar/work/ui/work_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

import '../../helpers/factory.dart';
import '../../helpers/fake_application_injector.dart';
import '../../helpers/mock_definition.dart';

void main() {
  setupDependencyInjectorForTest();

  group('Work Middleware', () {
    setUp(() {
      Mocks.setupMockStore();
    });

    test('on GetAvailableJobsAction loads the available jobs and dispatches and SetAvailableJobsAction', () async {
      var expectedJobs = [Factory.job()];
      var expectedDisplayJobs = [Factory.displayJob()];
      var getAvailableJobsActions = GetAvailableJobsAction();

      when(Mocks.workService.getAvailableJobs()).thenReturn(expectedJobs);

      await getAvailableJobs(Mocks.store, getAvailableJobsActions, Mocks.next);

      verify(Mocks.store.dispatch(SetAvailableJobsAction(expectedDisplayJobs)));

      verify(Mocks.mockNext.next(getAvailableJobsActions));
    });

    test('on ApplyJobAction sets the job by calling the character service', () async {
      var jobId = 23;
      var expectedJob = Factory.job(id: jobId);
      var applyJobAction = ApplyJobAction(jobId);

      when(Mocks.workService.getJob(any)).thenReturn(expectedJob);

      await applyForJob(Mocks.store, applyJobAction, Mocks.next);

      verify(Mocks.store.dispatch(SetCharacterJobAction(expectedJob)));
      verify(Mocks.workService.getJob(jobId));
      verify(Mocks.mockNext.next(applyJobAction));
    });

    test('on ApplyJobAction dispatch SelectHomeTabAction', () async {
      var applyJobAction = ApplyJobAction(1);

      when(Mocks.workService.getJob(any)).thenReturn(Factory.job());

      await applyForJob(Mocks.store, applyJobAction, Mocks.next);

      verify(Mocks.store.dispatch(SelectHomeTabAction()));
      verify(Mocks.mockNext.next(applyJobAction));
    });
  });
}
