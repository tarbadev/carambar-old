import 'package:carambar/work/ui/tab/work_tab.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/factory.dart';
import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/work_tab_view.dart';

void main() {
  testWidgets('Work Tab displays the available jobs', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJob = Factory.displayJob();

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: [expectedJob]));

    expect(workTabView.isVisible, isTrue);
    expect(workTabView.availableJobs, [expectedJob.name]);
  });

  testWidgets('Work Tab does not display the available jobs when availableJobs is null', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: null));

    expect(workTabView.isVisible, isFalse);
  });

  testWidgets('Work Tab dispatches an GetAvailableJobsAction when availableJobs is empty', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: []));

    verify(Mocks.store.dispatch(GetAvailableJobsAction()));
  });

  testWidgets('Work Tab dispatches an GetAvailableJobsAction when availableJobs is null', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: null));

    verify(Mocks.store.dispatch(GetAvailableJobsAction()));
  });

  testWidgets('Work Tab does not dispatch an GetAvailableJobsAction when availableJobs is not empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: [Factory.displayJob()]));

    verifyNever(Mocks.store.dispatch(GetAvailableJobsAction()));
  });

  testWidgets('Work Tab displays job dialog with job informations', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJobRequirements = ['Lots of job requirements'];
    var expectedPersonalityTraits = ['A few personality traits'];
    var expectedJobs = [
      Factory.displayJob(
        name: 'Supervisor',
        salary: '\$15,000/year',
        requirements: expectedJobRequirements,
        personalityTraits: expectedPersonalityTraits,
      )
    ];

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: expectedJobs));
    await workTabView.tapOnAvailableJob('Supervisor');
    await tester.pump();

    expect(workTabView.jobDialog.isVisible, isTrue);
    expect(workTabView.jobDialog.title, 'Supervisor');
    expect(workTabView.jobDialog.salary, '\$15,000/year');
    expect(workTabView.jobDialog.requirements, expectedJobRequirements);
    expect(workTabView.jobDialog.personalityTraits, expectedPersonalityTraits);
  });

  testWidgets('Work Tab dispatches an ApplyJobAction on apply button click', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var jobId = 1;
    var expectedJobs = [Factory.displayJob(name: 'Supervisor', id: jobId)];

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: expectedJobs));
    await workTabView.tapOnAvailableJob('Supervisor');
    await tester.pump();

    expect(workTabView.jobDialog.isVisible, isTrue);
    await workTabView.jobDialog.apply();
    await tester.pump();
    expect(workTabView.jobDialog.isVisible, isFalse);

    verify(Mocks.store.dispatch(ApplyJobAction(jobId)));
  });
}
