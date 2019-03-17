import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/work/domain/service/work_service.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:redux/redux.dart';

List<Middleware<ApplicationState>> createWorkMiddleware() => [
  TypedMiddleware<ApplicationState, GetAvailableJobsAction>(getAvailableJobs),
];

Future getAvailableJobs(Store<ApplicationState> store, GetAvailableJobsAction action, NextDispatcher next) async {
  var container = kiwi.Container();
  WorkService _workService = container.resolve<WorkService>();

  var jobs = await _workService.getAvailableJobs();

  store.dispatch(SetAvailableJobsAction(jobs));

  next(action);
}