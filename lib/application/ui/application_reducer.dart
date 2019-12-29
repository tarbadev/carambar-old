import 'package:carambar/application/ui/application_actions.dart';
import 'package:carambar/application/ui/application_state.dart';
import 'package:carambar/character/ui/character_reducer.dart';
import 'package:carambar/home/ui/home_reducer.dart';
import 'package:carambar/settings/ui/settings_reducer.dart';
import 'package:carambar/work/ui/work_reducer.dart';
import 'package:redux/redux.dart';

ApplicationState applicationReducer(ApplicationState state, action) =>
    ApplicationState(
      setCurrentTabReducer(state.currentTab, action),
      setCharacterReducer(state.character, action),
      setAgeEventsReducer(state.ageEvents, action),
      setEndLifeDialogVisibleReducer(state.isEndLifeDialogVisible, action),
      addAvailableCashReducer(state.availableCash, action),
      setAvailableJobsReducer(state.availableJobs, action),
    );

final Reducer<int> setCurrentTabReducer = combineReducers([
  TypedReducer<int, SelectTabAction>(_selectTab),
]);

int _selectTab(int currentTab, SelectTabAction action) => action.index;

final Reducer<double> addAvailableCashReducer = combineReducers([
  TypedReducer<double, AddAvailableCashAction>(addAvailableCash),
  TypedReducer<double, SetAvailableCashAction>(setAvailableCash),
]);

double addAvailableCash(double currentCash, AddAvailableCashAction action) =>
    currentCash + action.cash;

double setAvailableCash(double currentCash, SetAvailableCashAction action) =>
    action.cash;