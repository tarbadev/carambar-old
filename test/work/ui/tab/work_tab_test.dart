import 'package:carambar/work/ui/tab/work_tab.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/mock_definition.dart';
import '../../../helpers/testable_widget.dart';
import '../../../helpers/view/work_tab_view.dart';

void main() {
  testWidgets('Work Tab displays the available jobs', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJobs = ['Supervisor'];

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: expectedJobs));

    expect(workTabView.isVisible, isTrue);
    expect(workTabView.getAvailableJobs(), expectedJobs);
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

  testWidgets('Work Tab does not dispatch an GetAvailableJobsAction when availableJobs is not empty', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: ['Supervisor']));

    verifyNever(Mocks.store.dispatch(GetAvailableJobsAction()));
  });

  testWidgets('Work Tab dispatches a DisplayJobRequirementsDialogAction when an available job is tapped', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJobs = ['Supervisor'];

    await tester.pumpWidget(buildTestableWidget(WorkTab(), availableJobs: expectedJobs));

    await workTabView.tapOnAvailableJob('Supervisor');

    verify(Mocks.store.dispatch(DisplayJobRequirementsDialogAction('Supervisor')));
  });

  testWidgets('Work Tab displays the job requirements when isJobRequirementsDialogVisible is true', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJobRequirements = 'Lots of job requirements';

    await tester.pumpWidget(buildTestableWidget(WorkTab(), jobRequirements: expectedJobRequirements, isJobRequirementsDialogVisible: true));
    await tester.pump();

    expect(workTabView.isJobRequirementsVisible, isTrue);
    expect(workTabView.jobRequirements, expectedJobRequirements);
  });

  testWidgets('Work Tab dispatches a SetJobRequirementsDialogVisibleAction on close dialog tap', (WidgetTester tester) async {
    var workTabView = WorkTabView(tester);
    var expectedJobRequirements = 'Lots of job requirements';

    await tester.pumpWidget(buildTestableWidget(WorkTab(), jobRequirements: expectedJobRequirements, isJobRequirementsDialogVisible: true));
    await tester.pump();

    expect(workTabView.isJobRequirementsVisible, isTrue);

    await workTabView.tapOnCloseJobRequirementsDialog();

    verify(Mocks.store.dispatch(SetJobRequirementsDialogVisibleAction(false)));
  });
}