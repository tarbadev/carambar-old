import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createWorkMiddleware() => [
  TypedMiddleware<ApplicationState, GetAvailableJobsAction>(getAvailableJobs),
];

getAvailableJobs(Store<ApplicationState> store, GetAvailableJobsAction action, NextDispatcher next) {
  var container = kiwi.Container();
  WorkService _workService = container.resolve<WorkService>();

  var jobs = _workService.getAvailableJobs();

  store.dispatch(SetAvailableJobsAction(jobs.map((job) => DisplayJob.fromJob(job)).toList()));

  next(action);
}