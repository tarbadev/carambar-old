import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:carambar/work/ui/work_actions.dart';
import 'package:redux/redux.dart';

final Reducer<List<DisplayJob>> setAvailableJobsReducer = combineReducers([
  TypedReducer<List<DisplayJob>, SetAvailableJobsAction>(_setAvailableJobs),
]);

List<DisplayJob> _setAvailableJobs(List<DisplayJob> currentJobs, SetAvailableJobsAction action) => action.jobs;
