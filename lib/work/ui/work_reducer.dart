import 'package:carambar/work/ui/work_actions.dart';
import 'package:redux/redux.dart';

final Reducer<List<String>> setAvailableJobsReducer = combineReducers([
  TypedReducer<List<String>, SetAvailableJobsAction>(_setAvailableJobs),
]);

List<String> _setAvailableJobs(List<String> currentJobs, SetAvailableJobsAction action) => action.jobs;

final Reducer<String> setJobRequirementsReducer = combineReducers([
  TypedReducer<String, SetJobRequirementsAction>(_setJobRequirements),
]);

String _setJobRequirements(String currentJobRequirements, SetJobRequirementsAction action) => action.jobRequirements;

final Reducer<bool> setJobRequirementsDialogVisibleReducer = combineReducers([
  TypedReducer<bool, SetJobRequirementsDialogVisibleAction>(_setJobRequirementsDialogVisible),
]);

bool _setJobRequirementsDialogVisible(bool isCurrentlyVisible, SetJobRequirementsDialogVisibleAction action) => action.visible;
