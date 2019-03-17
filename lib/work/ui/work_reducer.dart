import 'package:carambar/work/ui/work_actions.dart';
import 'package:redux/redux.dart';

final Reducer<List<String>> setAvailableJobsReducer = combineReducers([
  TypedReducer<List<String>, SetAvailableJobsAction>(_setAvailableJobs),
]);

List<String> _setAvailableJobs(List<String> currentJobs, SetAvailableJobsAction action) => action.jobs;
