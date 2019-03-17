import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createWorkMiddleware() => [
  TypedMiddleware<ApplicationState, GetAvailableJobsAction>(getAvailableJobs),
  TypedMiddleware<ApplicationState, DisplayJobRequirementsDialogAction>(displayJobRequirementsDialog),
];

getAvailableJobs(Store<ApplicationState> store, GetAvailableJobsAction action, NextDispatcher next) {
  var container = kiwi.Container();
  WorkService _workService = container.resolve<WorkService>();

  var jobs = _workService.getAvailableJobs();

  store.dispatch(SetAvailableJobsAction(jobs));

  next(action);
}

displayJobRequirementsDialog(Store<ApplicationState> store, DisplayJobRequirementsDialogAction action, NextDispatcher next) {
  var container = kiwi.Container();
  WorkService _workService = container.resolve<WorkService>();

  var jobRequirements = _workService.getJobRequirements(action.job);

  store.dispatch(SetJobRequirementsAction(jobRequirements));
  store.dispatch(SetJobRequirementsDialogVisibleAction(true));

  next(action);
}